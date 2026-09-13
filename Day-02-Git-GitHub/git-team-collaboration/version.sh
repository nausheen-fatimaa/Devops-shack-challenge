#!/bin/bash

CURRENT_VERSION=$(git describe --tags --abbrev=0 2>/dev/null)

if [ -z "$CURRENT_VERSION" ]; then
    CURRENT_VERSION="v0.0.0"
fi

echo "Current version: $CURRENT_VERSION"
