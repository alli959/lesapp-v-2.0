#!/bin/bash

# Navigate to the iOS directory
cd ios

# Directory where symlinks should be located
SYMLINK_DIR=".symlinks/plugins"

# Check if the symlink directory exists
if [ ! -d "$SYMLINK_DIR" ]; then
    echo "Symlink directory does not exist, creating..."
    mkdir -p $SYMLINK_DIR
fi

# Example of creating a symlink for the amplify_auth_cognito plugin
ln -sf "$HOME/plugins/amplify_auth_cognito_ios" "$SYMLINK_DIR/amplify_auth_cognito"

echo "Symlinks setup complete."
