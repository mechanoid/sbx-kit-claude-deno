#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# deno-init.sh – Scaffold a new Deno project
# ==============================================================================

# --- Prerequisites ------------------------------------------------------------

if ! command -v jq &> /dev/null; then
  echo "Error: jq is required but not installed."
  exit 1
fi

# --- Arguments ----------------------------------------------------------------

if [ -z "${1:-}" ]; then
  echo "Usage: ./deno-init.sh <project-name>"
  exit 1
fi

PROJECT_NAME="$1"

# --- Scaffold project ---------------------------------------------------------

# Initialize a new Deno project
deno init "$PROJECT_NAME"
cd "$PROJECT_NAME"

# --- Configure ----------------------------------------------------------------

# Rename config to jsonc to allow comments
mv deno.json deno.jsonc

# Enable Node.js compatibility via node_modules
jq '. + {"nodeModulesDir": "auto"}' deno.jsonc > tmp && mv tmp deno.jsonc

# --- Dependencies -------------------------------------------------------------

# Add dotenv support from JSR standard library
deno add jsr:@std/dotenv

# Create initial .env file
touch .env

# --- Git ----------------------------------------------------------------------

echo "node_modules" > .gitignore
echo ".env" >> .gitignore
git init
# git add .
# git commit -m "Deno Project initialized

- Scaffolded project with deno init
- Renamed deno.json to deno.jsonc
- Enabled Node.js compatibility (nodeModulesDir: auto)
- Added @std/dotenv dependency
- Created .env file
- Added .gitignore (excluding node_modules, .env)"

# --- Done ---------------------------------------------------------------------

echo "✔ Project '$PROJECT_NAME' created."
