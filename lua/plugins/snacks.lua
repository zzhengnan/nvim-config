return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- bigfile = { enabled = true },
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
		-- indent = { enabled = true },
		-- input = { enabled = true },
		picker = { enabled = true },
		-- notifier = { enabled = true },
		-- quickfile = { enabled = true },
		-- scope = { enabled = true },
		-- scroll = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
	},
	config = function()
		vim.keymap.set("n", "\\", function()
			Snacks.explorer()
		end, { desc = "Explorer" })
	end,
}
