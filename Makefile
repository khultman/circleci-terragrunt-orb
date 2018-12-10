MAJOR_VERSION=0
MINOR_VERSION_FILE=dev-minor-version.txt

BUILD_VERSION=$(MAJOR_VERSION).$(cat $(MINOR_VERSION_FILE))
BUILD_VERSION_FILE=last-build-version.txt

validate-orb:
	circleci orb validate orb.yml && echo

publish-orb-dev: $(MINOR_VERSION_FILE)
	circleci orb publish orb.yml kchultman/terragrunt@dev:latest && echo
	echo ${BUILD_VERSION} > $(BUILD_VERSION_FILE)

promote-dev:
	circleci orb publish promote kchultman/terragrunt@dev:latest patch && echo

$(MINOR_VERSION_FILE): $(BUILD_VERSION_FILE)
	@if ! test -f $(MINOR_VERSION_FILE); then echo 0 > $(MINOR_VERSION_FILE); fi
	@echo $$(($$(cat $(MINOR_VERSION_FILE)) + 1)) > $(MINOR_VERSION_FILE)

