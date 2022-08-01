local status, _ = pcall(require, 'bufdelete')
if not status then
  print('ERROR: bufdelete')
  return
end
