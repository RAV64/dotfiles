HOT_RELOAD = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

require("options")
local wm = require("window-manager")
require("keybinds")({ wm = wm })
