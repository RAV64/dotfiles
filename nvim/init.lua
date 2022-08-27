local status, _ = pcall(require, "impatient")
if not status then
	print("ERROR: impatient")
else
	-- impatient.enable_profile() --:LuaCacheProfile
end

require("rav64")
