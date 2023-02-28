function bun-update
for pkg in (bun pm ls -g | sed 1d)
          bun a -g $(string split -f2 " " $pkg | string escape | string split -f1 "\e")
  end
end
