docker run --rm `
-v ${PWD}\Licensing:/home/wolframengine/.WolframEngine/Licensing `
wolframresearch/wolframengine:15.0 `
wolframscript -code "Prime[100]"