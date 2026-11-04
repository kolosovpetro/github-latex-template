#!/usr/bin/env bash

set -Eeuo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
repo_name="$(basename -- "$repo_root")"
default_repo_name="github-latex-template"

printf 'Git root directory name: %s\n' "$repo_name"
printf 'Git root directory abs path: %s\n' "$repo_root"
printf 'Git root default directory name: %s\n' "$default_repo_name"
printf 'Initializing LaTeX template for repository: %s\n' "$repo_name"

replace_text_in_file() {
  local file_path="$1" old_text="$2" new_text="$3"
  printf 'Replacing text in: %s\n' "$file_path"
  if [[ ! -f "$file_path" ]]; then
    printf 'Warning: file not found: %s\n' "$file_path" >&2
    return 0
  fi

  python3 - "$file_path" "$old_text" "$new_text" <<'PY'
import pathlib
import sys

path = pathlib.Path(sys.argv[1])
old = sys.argv[2].encode()
new = sys.argv[3].encode()
content = path.read_bytes()
path.write_bytes(content.replace(old, new))
PY
  printf 'Updated: %s\n' "$file_path"
}

rename_file_safe() {
  local old_path="$1" new_path="$2"
  printf 'Renaming: %s -> %s\n' "$old_path" "$new_path"
  if [[ ! -e "$old_path" ]]; then
    printf 'Warning: file not found: %s\n' "$old_path" >&2
    return 0
  fi
  if [[ -e "$new_path" ]]; then
    printf 'Warning: target already exists, skipping rename: %s\n' "$new_path" >&2
    return 0
  fi
  mv -- "$old_path" "$new_path"
}

clear_directory() {
  local directory_path="$1"
  printf 'Clearing directory: %s\n' "$directory_path"
  if [[ ! -d "$directory_path" ]]; then
    printf 'Warning: directory not found: %s\n' "$directory_path" >&2
    return 0
  fi
  find "$directory_path" -type f -delete
}

workflow_files=(
  "$repo_root/.github/workflows/build-and-deploy-pdf.yml"
  "$repo_root/.github/workflows/build-pdf.yml"
)
temp_url_old='kolosovpetro/github-latex-template/.github/workflows/'
temp_url_new='kolosovpetro/TEMP/.github/workflows/'

for file in "${workflow_files[@]}"; do
  replace_text_in_file "$file" "$temp_url_old" "$temp_url_new"
done
for file in "${workflow_files[@]}"; do
  replace_text_in_file "$file" "$default_repo_name" "$repo_name"
done
for file in "${workflow_files[@]}"; do
  replace_text_in_file "$file" "$temp_url_new" "$temp_url_old"
done

for file in \
  "$repo_root/.run/bibliography.run.xml" \
  "$repo_root/.run/build-latex.run.xml"; do
  replace_text_in_file "$file" "$default_repo_name" "$repo_name"
done

rename_file_safe \
  "$repo_root/mathematica/$default_repo_name.m" \
  "$repo_root/mathematica/$repo_name.m"
rename_file_safe \
  "$repo_root/mathematica/$default_repo_name.nb" \
  "$repo_root/mathematica/$repo_name.nb"

clear_directory "$repo_root/out"

rename_file_safe \
  "$repo_root/src/$default_repo_name.tex" \
  "$repo_root/src/$repo_name.tex"
rename_file_safe \
  "$repo_root/src/$default_repo_name.bib" \
  "$repo_root/src/$repo_name.bib"

replace_text_in_file \
  "$repo_root/src/$repo_name.tex" \
  "\\bibliography{$default_repo_name}" \
  "\\bibliography{$repo_name}"

replace_text_in_file \
  "$repo_root/src/metadata/footer.tex" \
  "https://github.com/kolosovpetro/$default_repo_name" \
  "https://github.com/kolosovpetro/$repo_name"
replace_text_in_file \
  "$repo_root/src/metadata/footer.tex" \
  "github.com/kolosovpetro/$default_repo_name" \
  "github.com/kolosovpetro/$repo_name"

replace_text_in_file \
  "$repo_root/mathematica/$repo_name.m" \
  "$default_repo_name" \
  "$repo_name"

for file in "$repo_root/renovate.json" "$repo_root/renovate.json.license"; do
  if [[ -e "$file" ]]; then
    printf 'Removing: %s\n' "$file"
    rm -- "$file"
  else
    printf 'Skipping non-existing file: %s\n' "$file"
  fi
done

for file in \
  "$repo_root/.github/workflows/build-pdf-template.yml" \
  "$repo_root/.github/workflows/build-and-deploy-pdf-template.yml"; do
  if [[ -e "$file" ]]; then
    printf 'Removing: %s\n' "$file"
    rm -- "$file"
  else
    printf 'Skipping non-existing file: %s\n' "$file"
  fi
done

printf '\nInitialization completed successfully.\n'
