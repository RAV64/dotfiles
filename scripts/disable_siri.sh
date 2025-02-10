#!/bin/bash
# https://gist.github.com/BreakingPitt/cbec2bdc5028d1d559554069b0cc92bb

# Disable Siri from System Preferences
echo "Disabling Siri from System Preferences..."
defaults write com.apple.Siri StatusMenuVisible -bool false
defaults write com.apple.assistant.support "Assistant Enabled" -bool false

# Prevent Siri from launching at startup
echo "Preventing Siri from launching at startup..."
launchctl unload -w /System/Library/LaunchAgents/com.apple.Siri.plist

# Remove Siri icon from the menu bar
echo "Removing Siri icon from the menu bar..."
defaults write com.apple.Siri StatusMenuVisible -bool false

# Kill the Siri process if it's running
echo "Killing the Siri process..."
killall "Siri" 2>/dev/null

# Reboot the system to apply changes (optional)
read -p "Do you want to reboot now to apply changes? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Rebooting..."
    sudo reboot
else
    echo "Reboot skipped. Some changes may require a reboot to take full effect."
fi

echo "Siri has been disabled."
