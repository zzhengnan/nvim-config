return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = false },
		dashboard = {
			enabled = true,
			preset = {
				header = [[
██╗  ██╗███████╗██╗███╗   ██╗ ██████╗ 
██║  ██║██╔════╝██║████╗  ██║██╔═══██╗
███████║█████╗  ██║██╔██╗ ██║██║   ██║
██╔══██║██╔══╝  ██║██║╚██╗██║██║   ██║
██║  ██║███████╗██║██║ ╚████║╚██████╔╝
╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ]],
			},
		},
		explorer = { enabled = true },
		indent = { enabled = false },
		input = { enabled = false },
		picker = { enabled = true },
		notifier = { enabled = false },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		vim.keymap.set("n", "\\", function()
			Snacks.explorer()
		end, { desc = "Explorer" })

		vim.keymap.set("n", "<leader>l", function()
			Snacks.lazygit({})
		end, { desc = "Lazygit" })
	end,
}
