local status, comment = pcall(require, "nvim_comment")
if not status then
	print("ERROR: nvim_comment")
	return
end

comment.setup()
