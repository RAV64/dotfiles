local status, rust_tools = pcall(require, "rust-tools")
if not status then
  print("ERROR: rust-tools")
  return
end

rust_tools.setup({})
