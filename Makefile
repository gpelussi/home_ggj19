GAME_DIR=src
GAME_NAME=transient
RELEASE_DIR=release
RELEASE_BASENAME=$(GAME_NAME)_

OSX_TEMPLATE=osx
WIN_TEMPLATE=windows
GNU_TEMPLATE=ubuntu64

OSX_NAME=_osx
WIN_NAME=_win64
GNU_NAME=_linux64

EXT_OSX=.dmg
EXT_WIN=.exe
EXT_GNU=.x86_64

LINUX_TARGET=$(RELEASE_BASENAME)$(VERSION)$(GNU_NAME)
WINDOWS_TARGET=$(RELEASE_BASENAME)$(VERSION)$(WIN_NAME)
OSX_TARGET=$(RELEASE_BASENAME)$(VERSION)$(OSX_NAME)

.PHONY: all osx linux windows version clean
all: osx linux windows

clean:
	rm -rf release/*

osx: version $(RELEASE_DIR)
	cd $(GAME_DIR) && godot -v --export $(OSX_TEMPLATE) "../$(RELEASE_DIR)/$(OSX_TARGET)$(EXT_OSX)"

linux: version $(RELEASE_DIR)
	cd $(GAME_DIR) && godot -v --export $(GNU_TEMPLATE) "../$(RELEASE_DIR)/$(LINUX_TARGET)$(EXT_GNU)"
	mkdir -pv $(RELEASE_DIR)/$(LINUX_TARGET)
	mv $(RELEASE_DIR)/$(LINUX_TARGET)$(EXT_GNU) $(RELEASE_DIR)/$(LINUX_TARGET).pck $(RELEASE_DIR)/$(LINUX_TARGET)
	cd $(RELEASE_DIR) && zip -9r $(LINUX_TARGET).zip $(LINUX_TARGET) -x *.zip
	rm -rf $(RELEASE_DIR)/$(LINUX_TARGET)/

windows: version $(RELEASE_DIR)
	cd $(GAME_DIR) && godot -v --export $(WIN_TEMPLATE) "../$(RELEASE_DIR)/$(WINDOWS_TARGET)$(EXT_WIN)"
	mkdir -pv $(RELEASE_DIR)/$(WINDOWS_TARGET)
	mv $(RELEASE_DIR)/$(WINDOWS_TARGET)$(EXT_WIN) $(RELEASE_DIR)/$(WINDOWS_TARGET).pck $(RELEASE_DIR)/$(WINDOWS_TARGET)
	cd $(RELEASE_DIR) && zip -9r $(WINDOWS_TARGET).zip $(WINDOWS_TARGET) -x *.zip
	rm -rf $(RELEASE_DIR)/$(WINDOWS_TARGET)/

version:
ifndef $(VERSION)
	$(info Setting up version...)
	$(set VERSION $$VERSION)
	@[ "$(VERSION)" != "" ] && echo "Exporting version: $(VERSION)" \
		|| (echo "No version specified, please set the VERSION variable" && exit 1);
endif

$(RELEASE_DIR):
	mkdir -pv $(RELEASE_DIR)
