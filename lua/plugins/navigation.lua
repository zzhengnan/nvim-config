return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				-- 	mappings = {
				-- 	  i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				-- 	},
				--             }

				-- https://stackoverflow.com/a/76991432
				defaults = {
					-- configure to use ripgrep
					vimgrep_arguments = {
						"rg",
						"--follow", -- Follow symbolic links
						"--hidden", -- Search for hidden files
						"--no-heading", -- Don't group matches by each file
						"--with-filename", -- Print the file path with the matched lines
						"--line-number", -- Show line numbers
						"--column", -- Show column numbers
						"--smart-case", -- Smart case search

						-- Exclude some patterns from search
						"--glob=!**/.git/*",
						"--glob=!**/.idea/*",
						"--glob=!**/.vscode/*",
						"--glob=!**/build/*",
						"--glob=!**/dist/*",
						"--glob=!**/yarn.lock",
						"--glob=!**/package-lock.json",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						-- needed to exclude some files & dirs from general search
						-- when not included or specified in .gitignore
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob=!**/.git/*",
							"--glob=!**/.idea/*",
							"--glob=!**/.vscode/*",
							"--glob=!**/build/*",
							"--glob=!**/dist/*",
							"--glob=!**/yarn.lock",
							"--glob=!**/package-lock.json",
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[h]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[k]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[f]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[s]elect telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "current [w]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "by [g]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[d]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[r]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = 'recent files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[<leader>] find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[/] in open files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[n]eovim files" })
		end,
	},
	{
		{
			"nvim-neo-tree/neo-tree.nvim",
			version = "*",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			lazy = false,
			keys = {
				{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
			},
			opts = {
				filesystem = {
					window = {
						mappings = {
							["\\"] = "close_window",
							-- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/163#discussioncomment-2274052
							["h"] = function(state)
								local node = state.tree:get_node()
								if node.type == "directory" and node:is_expanded() then
									require("neo-tree.sources.filesystem").toggle_directory(state, node)
								else
									require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
								end
							end,
							["l"] = function(state)
								local node = state.tree:get_node()
								if node.type == "directory" then
									if not node:is_expanded() then
										require("neo-tree.sources.filesystem").toggle_directory(state, node)
									elseif node:has_children() then
										require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
									end
								end
							end,
						},
					},
					filtered_items = {
						visible = true,
					},
				},
			},
		},
	},
}
