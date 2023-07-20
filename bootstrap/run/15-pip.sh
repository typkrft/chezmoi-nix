#!/usr/bin/env zsh

packages=(
    discord-webhook\[async\]
    pandas
    pandera
    playwright
    polars
    psycopg2-binary
    pydantic
    pygsheets
    python-dotenv
    sqlalchemy\[asyncio\]
)

for package in "$packages"; do
    pip install "$package"
done