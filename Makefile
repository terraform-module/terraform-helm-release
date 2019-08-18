.EXPORT_ALL_VARIABLES:

.PHONY: pre-commit changelog release

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

hooks: ## Commit hooks setup
	@pre-commit install
	@pre-commit gc
	@pre-commit autoupdate

validate: ## Validate with pre-commit hooks
	@pre-commit run --all-files

changelog: ## Update changelog
	git-chglog -o CHANGELOG.md --next-tag `semtag final -s minor -o`

release: ## Create release version
	semtag final -s minor