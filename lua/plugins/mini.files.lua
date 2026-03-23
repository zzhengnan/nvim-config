return {
	"nvim-mini/mini.files",
	config = function()
		require("mini.files").setup()
		vim.keymap.set("n", "-", function()
			require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		end)
	end,
}
