return {
	{
		"Mofiqul/vscode.nvim",
		priority = 100,
		config = function()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
			})
			vim.cmd.colorscheme("vscode")
		end,
	},
}
