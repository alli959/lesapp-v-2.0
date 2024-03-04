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
# You need to replace <path_to_flutter_plugin> with the actual path to the plugin in your Flutter environment
ln -sf "C:\Users\Notandi\AppData\Local\Pub\Cache\hosted\pub.dev\amplify_auth_cognito-1.4.2" "$SYMLINK_DIR/amplify_auth_cognito"

echo "Symlinks setup complete."
