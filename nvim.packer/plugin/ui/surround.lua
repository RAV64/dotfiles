local surround_status, surround = pcall(require, "nvim-surround")
if not surround_status then
	print("ERROR: surround")
	return
end

surround.setup({})
