return {
	"numtostr/comment.nvim",
	config = function()
		require("Comment").setup({
			toggler = { line = "<C-/>" },
			opleader = { line = "<C-/>" },
		})
	end,
}
