SCREEN = hs.screen.mainScreen()
hs.grid.setGrid("8 * 4", SCREEN)

GRID = hs.grid.getGrid(SCREEN)

REGION = {
	right_half = hs.geometry(0.5 * GRID.w, 0, 0.5 * GRID.w, GRID.h),
	left_half = hs.geometry(0, 0, 0.5 * GRID.w, GRID.h),
	top_half = hs.geometry(0, 0, GRID.w, 0.5 * GRID.h),
	bottom_half = hs.geometry(0, 0.5 * GRID.h, GRID.w, 0.5 * GRID.h),
}

local M = {}

M.maximizeWindow = function()
	hs.grid.maximizeWindow(hs.window.focusedWindow())
end

M.centerOnScreen = function()
	hs.window.focusedWindow():centerOnScreen(SCREEN)
end

M.leftHalf = function()
	hs.grid.set(hs.window.focusedWindow(), REGION.left_half, SCREEN)
end

M.rightHalf = function()
	hs.grid.set(hs.window.focusedWindow(), REGION.right_half, SCREEN)
end

M.topHalf = function()
	hs.grid.set(hs.window.focusedWindow(), REGION.top_half, SCREEN)
end

M.bottomHalf = function()
	hs.grid.set(hs.window.focusedWindow(), REGION.bottom_half, SCREEN)
end

return M
