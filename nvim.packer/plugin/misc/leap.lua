local status, leap = pcall(require, "leap")
if not status then
	print("ERROR: leap")
	return
end

leap.set_default_keymaps()
