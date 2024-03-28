local screen = hs.screen.mainScreen():currentMode()
local launch = hs.application.launchOrFocus

CHOOSER = hs.chooser.new(function(result)
	if result then
		launch(result.subText)
	end
end)

local function appID(app)
	return hs.application.infoForBundlePath(app)["CFBundleIdentifier"]
end

local function getImage(app)
	local image_id = appID(app)
	return image_id and hs.image.imageFromAppBundle(image_id) or image_id
end

local function CallBack(chooser)
	return function(_, stdOut, _)
		local apps = hs.fnutils.split(stdOut, "\n", nil, true)
		table.remove(apps)

		local choices = hs.fnutils.map(apps, function(str)
			if str:sub(-1) == "/" then
				str = str:sub(1, -2)
			end

			local name_table = hs.fnutils.split(str, "/", nil, true)

			local image = getImage(str)

			return {
				["text"] = name_table[#name_table],
				["subText"] = str,
				["image"] = image,
			}
		end)

		chooser:choices(choices)
	end
end

function SetChoices(chooser)
	local home = os.getenv("HOME")
	hs.task
		.new("~/.cargo/bin/fd", CallBack(chooser), {
			".", -- Catch all
			"-e", -- With extension:
			"app", -- "app"
			"-d", -- with depth:
			"1", -- 1
			"-a", -- Output absolute path
			-- From directories
			"/Applications/",
			home .. "/Applications/",
			"/System/Applications/",
			"/System/Applications/Utilities/",
		})
		:start()
end

SetChoices(CHOOSER)

return function()
	CHOOSER:show({ x = screen.w / 3.3, y = 150 })
end
