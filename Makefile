nonSdfFolder = "docs/sprite-non-sdf"
sdfFolder = "docs/sprite"
iconFolder = "assets/maki-icons"

.PHONY: help clean clean style build-voyager build-aerial sprite voyager aerial

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  build          to build styles and sprites"
	@echo "  clean          to clean build folder"
	@echo "  style          to build style files"
	@echo "  build-voyager  to build only voyager style"
	@echo "  build-aerial   to build only aerial style"
	@echo "  build-dark     to build only dark style"
	@echo "  build-positron to build only positron style"
	@echo "  build-unmap 	to build only UN Streets map style"
	@echo "  sprite         to build only sprite"
	@echo "  voyager        to develop voyager style YAML"
	@echo "  aerial         to develop aerial style YAML"
	@echo "  dark           to develop dark style YAML"
	@echo "  positron       to develop positron style YAML"
	@echo "  unmap           	to develop UN Streets map style YAML"

build: clean style sprite

clean:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Cleaning build folder"
	@echo "------------------------------------------------------------------"
	rm -rf docs

style: build-voyager build-aerial build-dark build-positron build-blank build-unmap

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

build-dark:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building dark style"
	@echo "------------------------------------------------------------------"
	mkdir -p docs
	pnpm charites build assets/dark.yml docs/dark.json

build-positron:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building positron style"
	@echo "------------------------------------------------------------------"
	mkdir -p docs
	pnpm charites build assets/positron.yml docs/positron.json

build-blank:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building blank style"
	@echo "------------------------------------------------------------------"
	mkdir -p docs
	pnpm charites build assets/blank.yml docs/blank.json

build-unmap:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building UN Streets style"
	@echo "------------------------------------------------------------------"
	mkdir -p docs
	pnpm charites build assets/un_street_map.yml docs/un_street_map.json

build-test:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Building UN Streets style"
	@echo "------------------------------------------------------------------"
	mkdir -p docs
	pnpm charites build assets/test_style.yml docs/test_style.json

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

dark:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Launching a local server to edit Dark style"
	@echo "------------------------------------------------------------------"
	pnpm charites serve assets/dark.yml --sprite-input $(iconFolder) --sdf

positron:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Launching a local server to edit Positron style"
	@echo "------------------------------------------------------------------"
	pnpm charites serve assets/positron.yml --sprite-input $(iconFolder) --sdf

blank:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Launching a local server to edit Blank style"
	@echo "------------------------------------------------------------------"
	pnpm charites serve assets/blank.yml --sprite-input $(iconFolder) --sdf

unmap:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Launching a local server to edit UN Street style"
	@echo "------------------------------------------------------------------"
	pnpm charites serve assets/un_street_map.yml

test:
	@echo
	@echo "------------------------------------------------------------------"
	@echo "Launching a local server to edit Test style"
	@echo "------------------------------------------------------------------"
	pnpm charites serve assets/test_style.yml --sprite-input $(iconFolder) --sdf