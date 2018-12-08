
validate-orb:
	circleci orb validate orb.yml && echo

publish-orb:
	circleci orb publish orb.yml khultman/terragrunt

