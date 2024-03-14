SCREEN = hs.screen.mainScreen()
GRID = hs.grid.getGrid(SCREEN)

local M = {
	right_half = hs.geometry(0.5 * GRID.w, 0, 0.5 * GRID.w, GRID.h),
	left_half = hs.geometry(0, 0, 0.5 * GRID.w, GRID.h),
	top_half = hs.geometry(0, 0, GRID.w, 0.5 * GRID.h),
	bottom_half = hs.geometry(0, 0.5 * GRID.h, GRID.w, 0.5 * GRID.h),
	almost_maximize = hs.geometry(0.1 * GRID.w, 0.03 * GRID.h, 0.87 * GRID.w, 0.94 * GRID.h),
}

M.maximizeWindow = function()
	hs.grid.maximizeWindow(hs.window.focusedWindow())
end

M.centerOnScreen = function()
	hs.window.focusedWindow():centerOnScreen(SCREEN)
end

M.moveTo = function(region)
	return function()
		hs.grid.set(hs.window.focusedWindow(), region, SCREEN)
	end
end

return M
