
ARG ENV_MODE=prod

# -----------------------------
# Base stage (common env setup)
# -----------------------------
FROM python:3.13-slim AS base
COPY --from=ghcr.io/astral-sh/uv:0.6.16 /uv /uvx /bin/
WORKDIR /app
COPY pyproject.toml uv.lock ./
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-install-project
COPY src/ src/
ENV PATH=/root/.local/bin:$PATH

# --------------------------------------------------
# Dev stage (extends base with tests and debug tools)
# --------------------------------------------------
FROM base AS dev
COPY tests/ tests/
# Optionally install test tools, e.g. pytest
# RUN uv pip install pytest

# ------------------------
# Prod stage (copy from base, skip tests)
# ------------------------
FROM base AS prod
# Optionally remove caches, dev dependencies, etc.
# RUN rm -rf /root/.cache /tests

# ------------------------
# Final stage (controlled via ENV_MODE)
# ------------------------
FROM ${ENV_MODE} AS final
CMD [".venv/bin/python", "-m", "src.main"]

# To add env variables at run time, do docker run --rm -e GREETING="Hello!". 
# These can be accessed in the code using os.environ.get("GREETING")