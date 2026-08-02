.PHONY: install venv activate deactivate shell

VENV_DIR := .venv

install:
	uv sync --all-groups --all-extras

venv:
	uv venv

activate:
	@echo "Activate the virtual environment with: source $(VENV_DIR)/bin/activate"

deactivate:
	@echo "Deactivate the virtual environment with: deactivate"

shell: venv
	. $(VENV_DIR)/bin/activate && exec $$SHELL
