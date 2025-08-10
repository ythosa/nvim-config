---@type ChadrcConfig
local M = {}

M.base46 = {
	-- theme = "material-darker",
  theme = "tokyonight",
  -- theme = "yoru",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

return M
