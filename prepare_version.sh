#!/bin/bash
# prepare_version.sh
# Usage: ./prepare_version.sh <version>
# Example: ./prepare_version.sh 1.2.3

if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION="$1"

# Patch Cargo.toml version (adjust path if needed)
echo "Patching Cargo.toml version to $VERSION"
dasel put -f apps/app/Cargo.toml -t string -v "$VERSION" 'package.version' || {
  echo "Error: 'dasel' command not found or failed."
  exit 1
}

echo "Version patched successfully."
