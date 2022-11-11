#!/usr/bin/env bash
set -e

mkdir -p /root/.jupyter || true

jq \
    --null-input \
    --arg password $(python -c "from notebook.auth import passwd; print(passwd('$PASSWORD'));") \
    '{"NotebookApp": {"password": $password}}' \
    > /root/.jupyter/jupyter_notebook_config.json

chmod 600 /root/.jupyter/jupyter_notebook_config.json

jupyter lab \
    --no-browser \
    --allow-root \
    --ip="0.0.0.0" \
    --port=8888