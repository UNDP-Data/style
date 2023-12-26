nonSdfFolder = "docs/sprite-non-sdf"
sdfFolder = "docs/sprite"
iconFolder = "assets/maki-icons"

.PHONY: help clean clean style build-voyager build-aerial sprite voyager aerial

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  build         to build styles and sprites"
	@echo "  clean         to clean build folder"
	@echo "  style         to build style files"
	@echo "  build-voyager to build only voyager style"
	@echo "  build-aerial  to build only aerial style"
	@echo "  sprite        to build only sprite"
	@echo "  voyager       to develop voyager style YAML"
	@echo "  aerial        to develop aerial style YAML"

build: clean style sprite

clean:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Cleaning build folder"
	@echo "------------------------------------------------------------------"
	rm -rf docs

style: build-voyager build-aerial

build-voyager:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building voyager style"
	@echo "------------------------------------------------------------------"
	mkdir -p docs
	pnpm charites build assets/style.yml docs/style.json

build-aerial:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building aerial style"
	@echo "------------------------------------------------------------------"
	mkdir -p docs
	pnpm charites build assets/aerialstyle.yml docs/aerialstyle.json

sprite:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building sprites"
	@echo "------------------------------------------------------------------"
	
	rm -rf $(nonSdfFolder)
	mkdir -p $(nonSdfFolder)
	pnpm sprite-one $(nonSdfFolder)/sprite --icon $(iconFolder) --ratio=1 --ratio=2 --ratio=4

	rm -rf $(sdfFolder)
	mkdir -p $(sdfFolder)
	pnpm sprite-one $(sdfFolder)/sprite --icon $(iconFolder) --ratio=1 --ratio=2 --ratio=4 --sdf

voyager:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Launching a local server to edit Voyager style"
	@echo "------------------------------------------------------------------"
	pnpm charites serve assets/style.yml --sprite-input $(iconFolder) --sdf

aerial:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Launching a local server to edit Aerial style"
	@echo "------------------------------------------------------------------"
	pnpm charites serve assets/aerialstyle.yml --sprite-input $(iconFolder) --sdf