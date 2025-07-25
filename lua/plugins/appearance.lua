return {
	{
		"Mofiqul/vscode.nvim",
		priority = 100,
		config = function()
			vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "vscode",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						-- 0: Just file name
						-- 1: Relative path
						-- 2: Absolute path
						path = 0,
					},
				},
				lualine_x = { "branch", "diff", "diagnostics" },
				lualine_y = { "location" },
				lualine_z = {},
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}
