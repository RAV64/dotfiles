local status, _ = pcall(require, "impatient")
if not status then
	print("ERROR: impatient")
	return
end

require("core")
