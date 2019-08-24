.PHONY: all clean mrproper rebuild

# list of extensions to include in pack, loaded from data directory
EXTENSIONS = .json

# to compile Moonscript
MOONSCRIPT_FILES = $(shell find src -name '*.moon')
LUAC_FILES = $(patsubst %.moon, %.lua, $(MOONSCRIPT_FILES))

# to ensure that everything is rebuilt if Lua sources or data files change
LUA_FILES = $(shell find src -name '*.lua')
DATA_FILES = $(shell find data)
RES_FILES = $(shell find res 2>/dev/null)

# output name
OUT_NAME = $(shell luvit tools/getname.lua)

all: $(OUT_NAME).tar.gz

clean:
	rm -f $(LUAC_FILES)
	rm -f module.pack
	rm -rf build/

mrproper: clean
	rm -f $(OUT_NAME).tar.gz

rebuild: clean all

$(OUT_NAME).tar.gz: module.pack config.json module.info $(RES_FILES)
	@mkdir -p build/$(OUT_NAME)
	@ln -sf ../../module.pack ../../module.info ../../config.json build/$(OUT_NAME)
	@[ -d res ] && ln -sf ../../res build/$(OUT_NAME) || exit 0
	tar czf $@ -h -C build $(OUT_NAME)

module.pack: $(LUA_FILES) $(LUAC_FILES) $(DATA_FILES)
	luvit tools/mkmodule.lua .lua $(EXTENSIONS)

%.lua: %.moon
	moonc $<
