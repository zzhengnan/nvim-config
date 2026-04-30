return {
	{
		"Mofiqul/vscode.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
			})
			vim.cmd.colorscheme("vscode")
		end,
	},
}
