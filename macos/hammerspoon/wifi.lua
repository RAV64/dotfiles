-- wifi.lua
-- Manages automatic Wi-Fi off/on based on sleep/wake state

local M = {}

-- Turns Wi-Fi on/off via Hammerspoon
local function setWifi(power)
	hs.wifi.setPower(power)
end

-- Called when system is about to sleep
function M.handleSleep()
	local wifiDetails = hs.wifi.interfaceDetails()
	local isOn = wifiDetails and wifiDetails.power == true
	STATE.auto_wifi = isOn

	if isOn then
		print("[wifi] Sleep detected → Turning Wi-Fi OFF")
		setWifi(false)
	else
		print("[wifi] Sleep detected → Wi-Fi already OFF")
	end
end

-- Called when system wakes
function M.handleWake()
	if STATE.auto_wifi then
		print("[wifi] Wake detected → Restoring Wi-Fi ON")
		setWifi(true)
	else
		print("[wifi] Wake detected → Leaving Wi-Fi OFF")
	end
end

return M
