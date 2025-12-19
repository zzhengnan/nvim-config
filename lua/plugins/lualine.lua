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
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(s)
							return mode_map[s] or s
						end,
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						-- 0: Just file name
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with ~ as home directory
						-- 4: File name and parent dir, with ~ as home directory
						path = 4,
						file_status = true, -- Displays file status (readonly status, modified status)
					},
				},
				lualine_x = { nil },
				lualine_y = { nil },
				lualine_z = { "location" },
			},
		},
	},
}
