#!/usr/bin/env bash

# Description: Setup remote X11 display on macOS
# Per https://gist.github.com/devnoname120/ \
#   ce02ef43da968e15340427c2f1c286a7

brew install --cask --no-quarantine xquartz
defaults write org.xquartz.X11 nolisten_tcp -bool false
defaults write org.xquartz.X11 no_auth -bool false
defaults write org.xquartz.X11 enable_iglx -bool true

mkdir -p ~/.xinitrc.d

cat << 'EOF' > ~/.xinitrc.d/xhost-config.sh
#!/bin/sh

xhost +localhost
xhost +\$(hostname)
EOF

chmod +x ~/.xinitrc.d/xhost-config.sh
