function cwt
  if test (count $argv) -gt 0
    cw "test --lib -- --nocapture $argv[1]"
  else 
    cw "test --lib -- --nocapture"
  end
end
