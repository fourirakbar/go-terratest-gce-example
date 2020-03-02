.PHONY: help setup release changelog tag doc
.DEFAULT_GOAL := help

help: ## List of help for this repository
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: ## Setup pre-commit hook
	pre-commit install

release: ## Create release
	./semtag ${version} -s ${scope}

changelog: ## Generate changelog
	git-chglog -o CHANGELOG.md

tag: ## Generate tag
	./semtag get

doc: ## Create terraform documentation
	terraform-docs
