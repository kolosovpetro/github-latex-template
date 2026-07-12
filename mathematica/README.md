# Run in Docker

## Image

- Image: `wolframresearch/wolframengine:15.0`
- Url: https://hub.docker.com/r/wolframresearch/wolframengine

## Get Free Developer License

- Register user account in Wolfram (https://account.wolfram.com/login/oauth2/sign-in)
- Run `docker run -it --rm wolframresearch/wolframengine:15.0 bash`
- Inside interactive container: `wolframscript`
- Follow the steps: https://www.wolfram.com/engine/free-license/
- Copy license file: `docker cp <container-id>:/home/wolframengine/.WolframEngine/Licensing/mathpass .\mathpass`
- Mount license file and test wolframscript: `.\Test-Wolfram-Container.ps1`

# Run equation tests (Windows: Powershell)

It is assumed that Wolfram Engine (with Wolfram script is installed on the machine)

- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "GenerateExamplesInPolynomialForm.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "GenerateExamplesInPolynomialFormR0.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "ValidateOrdinarySumsOfPowers.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "ValidateDoubleSumsOfPowers.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "ValidateMultifoldSumsOfPowers.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "ValidateMultifoldBinomialSumsOfPowers.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "ValidateOrdinarySumsOfPowersAtZero.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "ValidateDoubleSumsOfPowersAtZero.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "ValidateMultifoldSumsOfPowersAtZero.txt"
- .\mathematica\Run-Mathematica.ps1 -MathematicaFileName "ValidateMultifoldSumsOfPowersAtZeroBinomialForm.txt"

# Run equation tests (Docker: Powershell)

- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "GenerateExamplesInPolynomialForm.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "GenerateExamplesInPolynomialFormR0.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "ValidateOrdinarySumsOfPowers.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "ValidateDoubleSumsOfPowers.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "ValidateMultifoldSumsOfPowers.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "ValidateMultifoldBinomialSumsOfPowers.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "ValidateOrdinarySumsOfPowersAtZero.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "ValidateDoubleSumsOfPowersAtZero.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "ValidateMultifoldSumsOfPowersAtZero.txt"
- .\mathematica\Run-Wolfram-Container.ps1 -MathematicaFileName "ValidateMultifoldSumsOfPowersAtZeroBinomialForm.txt"

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