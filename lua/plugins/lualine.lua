-- https://github.com/benfrain/neovim/blob/main/lua/setup/lualine.lua
local mode_map = {
	["NORMAL"] = "N",
	-- ["O-PENDING"] = "N?",
	["INSERT"] = "I",
	["VISUAL"] = "V",
	["V-BLOCK"] = "VB",
	["V-LINE"] = "VL",
	-- ["V-REPLACE"] = "VR",
	["REPLACE"] = "R",
	-- ["COMMAND"] = "!",
	-- ["SHELL"] = "SH",
	["TERMINAL"] = "T",
	-- ["EX"] = "X",
	-- ["S-BLOCK"] = "SB",
	-- ["S-LINE"] = "SL",
	-- ["SELECT"] = "S",
	-- ["CONFIRM"] = "Y?",
	-- ["MORE"] = "M",
}

return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "vscode",
			},
			sections = {
				-- 	lualine_a = {
				-- 		{
				-- 			"mode",
				-- 			fmt = function(s)
				-- 				return mode_map[s] or s
				-- 			end,
				-- 		},
				-- 	},
				lualine_b = { "branch" },
				lualine_c = { "windows" },
				lualine_x = { "diagnostics" },
				lualine_y = { nil },
				lualine_z = { "location" },
			},
		},
	},
}
