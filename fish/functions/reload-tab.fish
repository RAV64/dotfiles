function reload-tab --argument path
    fswatch -o $path | xargs -n1 -I {} osascript -e 'tell application "Chromium" to tell the active tab of its first window to reload'
end
