# imglib-mkmodule
This is a tool for developping modules for [natnat-mc/imglib](https://github.com/natnat-mc/imglib).
It allows for modules written in Lua and Moonscript, and generates a `.tar.gz` that is ready to be extracted in the `modules` folder of an imglib installation.
It compiles the Moonscript sources from the `src` folder to Lua and packages files from `src` and `data` that match the extensions defined in the `Makefile`.
It packages the `config.json` and `module.info` file too, along with the `res` folder if present.
