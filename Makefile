NIX_FILES := $(shell find . -type f -name '*.nix' -print)

.PHONY: help fmt fmt-check lint deadnix whitespace check

help:
	@echo "Available targets:"
	@echo "  fmt         Clean whitespace and format Nix files"
	@echo "  fmt-check   Check Nix formatting"
	@echo "  lint        Run statix"
	@echo "  deadnix     Check for dead Nix code"
	@echo "  whitespace  Check for whitespace errors"
	@echo "  check       Run all checks"

fmt:
	sed -i 's/^[[:space:]]\{4,\}/  /' $(NIX_FILES)
	sed -i 's/[[:space:]]*$$//' $(NIX_FILES)
	nixfmt $(NIX_FILES)

fmt-check:
	nixfmt --check $(NIX_FILES)

lint:
	statix check .

deadnix:
	deadnix .

whitespace:
	git diff --check
	git diff --cached --check

check: fmt-check lint deadnix whitespace
