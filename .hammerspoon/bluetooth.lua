local dependency = hs.task.new("/opt/homebrew/bin/blueutil", nil, {}):start()

if dependency then
	function SetBluetooth(bool)
		local state = bool and "on" or "off"
		hs.task.new("/opt/homebrew/bin/blueutil", nil, { "--power", state }):start()
	end

	function __AutoBluetooth(bool)
		return function(_, stdOut, _)
			if not bool then
				STATE.auto_bluetooth = stdOut == "1\n"
				if STATE.auto_bluetooth then
					print("Bluetooth off")
					SetBluetooth(bool)
				end
			elseif bool and STATE.auto_bluetooth then
				print("Bluetooth on")
				SetBluetooth(bool)
			end
		end
	end

	return function(bool)
		hs.task.new("/opt/homebrew/bin/blueutil", __AutoBluetooth(bool), { "-p" }):start()
	end
end

print("MISSING DEPENDENCY: blueutil (brew install blueutil)")
