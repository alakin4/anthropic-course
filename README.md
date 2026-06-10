# Alan's Python Project Template
This repository serves as a boilerplate for Python projects, adhering to best practices in project structure, dependency management, testing, and continuous integration.

> This template can be used to inform you of where the most important pieces should be and
how to keep things organized. For the most part, the template follows the [Python
Packaging Guide](https://packaging.python.org/en/latest/tutorials/packaging-projects/)
which is intended to be followed by the larger community.

## Project Structure

   ```
   .
   ├── Dockerfile
   ├── LICENSE
   ├── README.md
   ├── docker-dev.sh
   ├── pyproject.toml
   ├── src
   │   ├── __init__.py
   │   ├── main.py
   ├── tests
   │   └── test_main.py
   └── uv.lock
   ```

## Features

- **Structured Codebase**: All source code resides in the `src/` directory, promoting a clean separation between application code and configuration files.
- **Dependency Management**: Utilizes [uv](https://github.com/astral-sh/uv) for managing dependencies via `pyproject.toml` and `uv.lock`.
- **Testing Framework**: Integrated with `pytest` for writing and running tests.
- **Linting and Formatting**: Configured with `ruff` for code linting and formatting.
- **Pre-commit Hooks**: Automated code quality checks using pre-commit hooks defined in `.pre-commit-config.yaml`.
- **Docker Support**: Includes a `Dockerfile` and `docker-dev.sh` script for containerized development environments.
- **Continuous Integration**: Set up with GitHub Actions for automated testing and linting on push events.
- **VSCode Ready**: Includes a `.vscode` directory with workspace configurations for linters, formatters, and testing integration.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Python 3.10+](https://www.python.org/downloads/)
- [uv](https://github.com/astral-sh/uv) (`brew install uv`)
- [Docker](https://www.docker.com/) (optional, for containerized development)
- [pre-commit](https://pre-commit.com/) (`pip install pre-commit` or `brew install pre-commit`)

### Installation

1. **Clone the repository**:

   ```sh
   git clone https://github.com/alakin4/python-template.git
   cd python-template

> To have a different project name, it is better to start the project from github and select this as a template.

2. **Install dependencies**:
   ```sh
   uv sync --all-groups

3. **Set up pre-commit hooks**:
   ```sh
   pre-commit install

4. **Run tests**:
   ```sh
   uv run pytest tests -v or uv run pytest -v.
   ```
   
The `-v` adds a bit more structured output

## Running the Application
Run the application from the entry point
   ```sh
    uv run src/main.py
   ```

## Virtual Environments with uv
Create and activate a virtual environment:
   ```sh
    uv venv
    source .venv/bin/activate
   ```
Run `deactivate` to Deactivate the virtual environment.

## Keeping Lock File in Sync
If you modify `pyproject.toml`  directly, make sure to verify lock file sync:
   ```sh
    uv lock --locked
   ```
## Code Quality Checks
* Check for rule violations:
    ```sh
    uvx ruff check .
    ```
* Format code:
    ```sh
    uvx ruff format .
    ```
* Format specifically rule:
    ```sh
    uvx ruff check --select I --fix .
    ```
* Check if all files are formatted correctly:
    ```sh
    uvx ruff format --check .
    ```
## Type Checking
Ruff does not catch type hint issues. Use pyright:
   ```sh
    uv run pyright
   ```
    
## Testing
* Run tests:
  ```sh
  uv run pytest -v
  ``` 
* With coverage tracking:
  ```sh
  uv run pytest -v --cov
  ```
 * Generate XML report:
      ```sh
        uv run pytest -v --cov --cov-report=xml
      ```
 ## Pre-commit Hooks
- Install `pre-commit` globally and initialize it in the repo as indicated above using `pre-commit install
- Trigger manually using: `pre-commit run --all-files`

## Environment Variables
A `.env` file can be used (e.g. with `GREETING=Hello`).

