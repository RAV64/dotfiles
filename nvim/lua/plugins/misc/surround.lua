local status, surround = pcall(require, 'surround')
if not status then
  print("ERROR: surround")
  return
end

surround.setup {
  mappings_style = "surround"
}
