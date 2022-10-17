function launchlist
echo "~/Library/LaunchAgents"
la ~/Library/LaunchAgents
echo "/Library/LaunchAgents"
la /Library/LaunchAgents
echo "/Library/LaunchDaemons"
la /Library/LaunchDaemons
echo "/System/Library/LaunchAgents"
la /System/Library/LaunchAgents | grep -v "apple"
echo "/System/Library/LaunchDaemons"
la /System/Library/LaunchDaemons | grep -v "apple"
end
