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
		local keymaps = {
			{
				"\\",
				function()
					Snacks.explorer()
				end,
				"Explorer",
			},
			{
				"<leader>f",
				function()
					Snacks.picker.files()
				end,
				"Files",
			},
			{
				"<leader><space>",
				function()
					Snacks.picker.buffers()
				end,
				"Buffers",
			},
			{
				"<leader>l",
				function()
					Snacks.lazygit({})
				end,
				"Lazygit",
			},
			{
				"<leader>op",
				function()
					Snacks.picker.projects()
				end,
				"Projects",
			},
			{
				"<leader>s.",
				function()
					Snacks.picker.recent()
				end,
				"Recent files",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				"Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				"Grep current word",
			},
			{
				"<leader>sr",
				function()
					Snacks.picker.resume()
				end,
				"Resume",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				"Help",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				"Keymaps",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				"LSP symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				"LSP workspace symbols",
			},
			{
				'<leader>s"',
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},

			{
				"<leader>su",
				function()
					Snacks.picker.undo()
				end,
				desc = "Undo history",
			},
		}
		for _, map in ipairs(keymaps) do
			vim.keymap.set("n", map[1], map[2], { desc = map[3] })
		end
	end,
}
