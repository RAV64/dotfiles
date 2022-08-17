local status, impatient = pcall(require, "impatient")
if not status then
	print("ERROR: impatient")
	return
end

-- impatient.enable_profile() --:LuaCacheProfile
require("rav64")
