return {
	{
		"Mofiqul/vscode.nvim",
		priority = 100,
		-- config = function()
		-- 	vim.cmd.colorscheme("vscode")
		-- end,
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
}
