return {
	{
		"zenbones-theme/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyobones")
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},

	-- {
	-- 	"Mofiqul/vscode.nvim",
	-- 	priority = 100,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("vscode")
	-- 	end,
	-- },

	-- {
	-- 	"webhooked/kanso.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("kanso-ink")
	-- 	end,
	-- },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				-- theme = "vscode",
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
						-- 3: Absolute path, with ~ as home directory
						-- 4: File name and parent dir, with ~ as home directory
						path = 4,
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
