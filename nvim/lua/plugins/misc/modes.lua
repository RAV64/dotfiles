local status, modes = pcall(require, "modes")
if not status then
	print("ERROR: modes")
	return
end

modes.setup()
