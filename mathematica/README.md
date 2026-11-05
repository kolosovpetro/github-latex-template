# Run in Docker

## Image

- Image: `wolframresearch/wolframengine:15.0`
- Url: https://hub.docker.com/r/wolframresearch/wolframengine

## Get Free Developer License

- Register user account in Wolfram (https://account.wolfram.com/login/oauth2/sign-in)
- Follow the steps: https://www.wolfram.com/engine/free-license/
- Run `docker run -it --name wolfram-licensed wolframresearch/wolframengine:15.0 bash`
- Inside interactive container: `wolframscript`
  - Enter login
  - Enter password
- Copy license file from the repository root: `./copy-wolfram-license.sh`
- Mount license file and test wolframscript: `./Validate-Wolfram-Container.sh`

# Run equation tests (Docker: Bash)

- ./Run-Wolfram-Container.sh "GenerateExamplesInPolynomialForm.txt"
- ./Run-Wolfram-Container.sh "GenerateExamplesInPolynomialFormR0.txt"
- ./Run-Wolfram-Container.sh "ValidateOrdinarySumsOfPowers.txt"
- ./Run-Wolfram-Container.sh "ValidateDoubleSumsOfPowers.txt"
- ./Run-Wolfram-Container.sh "ValidateMultifoldSumsOfPowers.txt"
- ./Run-Wolfram-Container.sh "ValidateMultifoldBinomialSumsOfPowers.txt"
- ./Run-Wolfram-Container.sh "ValidateOrdinarySumsOfPowersAtZero.txt"
- ./Run-Wolfram-Container.sh "ValidateDoubleSumsOfPowersAtZero.txt"
- ./Run-Wolfram-Container.sh "ValidateMultifoldSumsOfPowersAtZero.txt"
- ./Run-Wolfram-Container.sh "ValidateMultifoldSumsOfPowersAtZeroBinomialForm.txt"
