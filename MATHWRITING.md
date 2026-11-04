PLAIN TEXT CHECKLIST: GENERAL WRITING RULES FOR INTEGERS

Use this checklist when drafting, editing, or reviewing the paper. Apply it to prose and LaTeX source where relevant, then check the rendered document for layout issues before submission.

1. Page layout
   - All text, formulas, tables, and figures must stay inside the page margins.
   - No equation or figure may extend into the margin.

2. Sentence beginnings
   - Begin every sentence, including theorem statements, with an English word rather than a formula or symbol.
   - Bad:  n^2 is an integer.
   - Good: For all integers n, the quantity n^2 is an integer.
   - This rule also applies to theorem statements.

3. Text before theorems and similar environments
   - The sentence immediately before a theorem, lemma, definition, remark, etc. must:
     - Be a complete sentence
     - End with a period
   - Good: We now state the following result.
   - Bad: We now state the following result:

4. Section and subsection titles
   - Use title case: capitalize the first and last words and the principal words.
   - Lowercase articles, coordinating conjunctions, and prepositions unless they are the first or last word.
   - Example:
     - Good: Sums of Powers via Finite Differences
     - Bad: Sums Of Powers Via Finite Differences

5. Contractions
   - Do not use contractions.
   - Bad: don’t, can’t, it’s, we’ve
   - Good: do not, cannot, it is, we have

6. Definitions
   - Italicize a term when it is introduced as a formal definition; use `\emph{...}` in LaTeX.
   - Do not use boldface.
   - Example: We call `\emph{a central difference sequence}` a sequence defined by the central difference operator.

7. Tables and figures
   - Every table and figure must have:
     - A number (label)
     - A caption
   - Place captions below both tables and figures, following this project's style.

8. Referring to theorems and similar results
   - Capitalize the word when it has a number.
   - Do not abbreviate.
   - Good: Theorem 3, Lemma 2, Corollary 5
   - Bad: theorem 3, Thm. 3

9. Referring to equations
   - Always write: Equation (n)
   - Do not write: Eq. (n) or (n) alone.

10. Logical symbols in text
    - Do not use symbols in running text.
    - Do not use: &, ∃, ∀
    - Use words instead:
      - and
      - there exists
      - for all

11. Logical arrows
    - Prefer words instead of arrows or double arrows.
    - Write:
      - if and only if
      - implies
    - Avoid: ⇒, ⇔ in normal text.

12. Commas in lists (Oxford comma)
    - When listing three or more items, include a comma before "and".
    - Example:
      - Good: a, b, and c
      - Bad: a, b and c
    - This rule also applies to bibliographies with three or more authors.

13. Referencing figures, tables, and equations
   - Refer to every numbered figure and table in the text.
   - Number an equation only when the text refers to it; refer to every numbered equation using the format in Rule 9.

14. References
    - Every item in the bibliography must be cited somewhere in the text.
    - No unused references are allowed.

15. Mathematical expressions inside sentences
    - Avoid placing two formulas separated only by a comma.
    - Bad: Let f(n), g(n) be functions.
    - Good: Let f(n) and g(n) be functions.

16. Commas after transition words
    - If a sentence starts with words like:
      - Thus
      - Therefore
      - Hence
    - Always put a comma after that word.
    - Example:
      - Thus, we obtain the desired identity.

17. Paragraph indentation
   - Use normal paragraph indentation only; do not add spaces or manual indentation to align wrapped lines or displayed material.

18. Single-paragraph rule
   - Keep each of the following to exactly one paragraph:
      - Theorem statements
      - Lemma statements
      - Definitions
      - Remarks
      - Examples
      - Acknowledgements section

19. Punctuation after displayed equations
   - Punctuate a displayed equation as part of its surrounding sentence.
   - If the sentence ends with the display, place the terminal period at the end of the final equation line, before the closing display delimiter.

20. Long equations
   - Keep short expressions inline. Put an expression in display mode when it is too long to read comfortably within the sentence or needs to break across lines.

21. Bold text
    - Do not use boldface text in the body of the paper.
    - Bold is allowed only for:
      - Section titles
      - Subsection titles
      - Theorem, lemma, definition, remark, and example headings

22. Remove unused references in *.bib file.
23. Arrange references in *.bib file in order as they used in paper.
24. For every reference add its number in comment, the line before reference goes.
25. For every reference always use terms "in", "from", "given by"
  - Bad: Donald Knuth gives a formula for sums of odd powers in terms of the central factorial numbers of the second kind $T(n,k)$~\cite{knuth1993johann}.
  - Good: Donald Knuth gives a formula for sums of odd powers in terms of the central factorial numbers of the second kind $T(n,k)$ in~\cite{knuth1993johann}.
  - Ignore: "in the OEIS~\cite{...}"
26. In proof environment use \tbinom, \tsum
27. Do not use period after cases environment
  - Bad: \end{cases}.
  - Good: \end{cases}
