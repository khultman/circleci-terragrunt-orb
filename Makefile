all: validate-orb publish-orb-dev

validate-orb:
	circleci orb validate orb.yml && echo

publish-orb-dev:
	circleci orb publish orb.yml kchultman/terragrunt@dev:latest && echo

promote-dev:
	circleci orb publish promote kchultman/terragrunt@dev:latest patch && echo



