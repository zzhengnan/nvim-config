return {
	{
		"Mofiqul/vscode.nvim",
		priority = 100,
		config = function()
			vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		-- config = function()
		-- 	vim.cmd.colorscheme("kanagawa")
		-- end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		-- config = function()
		-- 	vim.cmd.colorscheme("catppuccin")
		-- end,
	},
}
