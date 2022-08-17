local status, modes = pcall(require, "modes")
if not status then
  print("ERROR: modes")
  return
end

local clrs_status, clrs = pcall(require, "catppuccin.palettes")
if not clrs_status then
  print("ERROR: clrs for modes")
  return
end

modes.setup({
  colors = {
    copy = clrs.lavender,
    delete = "#c75c6a",
    insert = clrs.green,
    visual = clrs.flamingo,
  },
})
