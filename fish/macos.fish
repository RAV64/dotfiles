set -gx PATH /opt/homebrew/sbin $PATH
set -gx PATH /opt/homebrew/bin $PATH
launchctl remove com.valvesoftware.steam.ipctool
ps aux | grep -i 'siri' | grep -v 'grep' | awk '{print $2}' | xargs -r kill -9
