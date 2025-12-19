local M = {}

function M.handleSleep()
	local wifiDetails = hs.wifi.interfaceDetails()
	local isOn = wifiDetails and wifiDetails.power == true
	STATE.auto_wifi = isOn

	if isOn then
		print("[wifi] Sleep detected → Turning Wi-Fi OFF")
		hs.wifi.setPower(false)
	else
		print("[wifi] Sleep detected → Wi-Fi already OFF")
	end
end

function M.handleWake()
	if STATE.auto_wifi then
		print("[wifi] Wake detected → Restoring Wi-Fi ON")
		hs.wifi.setPower(true)
	else
		print("[wifi] Wake detected → Leaving Wi-Fi OFF")
	end
end

return M
