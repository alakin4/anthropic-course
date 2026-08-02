.PHONY: install venv activate shell

VENV_DIR := .venv

install:
	uv sync --group dev

venv:
	uv venv

activate:
	@echo "Activate the virtual environment with: source $(VENV_DIR)/bin/activate"

shell: venv
	. $(VENV_DIR)/bin/activate && exec $$SHELL
