return {
	{
		"Mofiqul/vscode.nvim",
		-- priority = 100,
		config = function()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
			})
			vim.cmd.colorscheme("vscode")

			-- Match gutter color to VS Code
			-- TODO: Move into gitsigns.lua
			vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#487E02" })
			vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#1B81A8" })
			vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#94151B" })
		end,
	},
}
