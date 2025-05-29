-- Highlight when yanking text
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

if vim.g.vscode then
	print("For VS Code")
else
	--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	-- https://stackoverflow.com/a/1878984
	vim.opt.tabstop = 4 -- TAB width. Still it is a \t, it's just that Vim will interpret it as having a width of 4
	vim.opt.shiftwidth = 4 -- Indent width
	vim.opt.softtabstop = 4 -- Number of columns for a TAB
	vim.opt.expandtab = true -- Expand TABs to spaces

	vim.g.have_nerd_font = true

	-- See `:help vim.o`
	--  For more options, you can see `:help option-list`

	vim.o.number = true
	vim.o.relativenumber = true

	vim.o.mouse = "a"

	-- Don't show the mode, since it's already in the status line
	vim.o.showmode = false

	-- Sync clipboard between OS and Neovim.
	vim.schedule(function()
		vim.o.clipboard = "unnamedplus"
	end)

	-- Enable break indent
	vim.o.breakindent = true

	-- Save undo history
	vim.o.undofile = true

	vim.o.ignorecase = true
	vim.o.smartcase = true

	-- Keep signcolumn on by default
	vim.o.signcolumn = "yes"

	-- Decrease update time
	vim.o.updatetime = 250

	-- Decrease mapped sequence wait time
	vim.o.timeoutlen = 300

	-- Configure how new splits should be opened
	vim.o.splitright = true
	vim.o.splitbelow = true

	-- Sets how neovim will display certain whitespace characters in the editor.
	--  See `:help 'list'`
	--  and `:help 'listchars'`
	--
	--  Notice listchars is set using `vim.opt` instead of `vim.o`.
	--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
	--   See `:help lua-options`
	--   and `:help lua-options-guide`
	vim.o.list = true
	vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

	-- Preview substitutions live, as you type!
	vim.o.inccommand = "split"

	-- Show which line your cursor is on
	vim.o.cursorline = true

	-- Minimal number of screen lines to keep above and below the cursor.
	vim.o.scrolloff = 10

	-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
	-- instead raise a dialog asking if you wish to save the current file(s)
	-- See `:help 'confirm'`
	vim.o.confirm = true

	-- [[ Basic Keymaps ]]
	--  See `:help vim.keymap.set()`

	-- Clear highlights on search when pressing <Esc> in normal mode
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

	-- Diagnostic keymaps
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "[q]uickfix list" })

	-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
	-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
	-- is not what someone will guess without a bit more experience.
	--
	-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
	-- or just use <C-\><C-n> to exit terminal mode
	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

	--  See `:help wincmd` for a list of all window commands
	vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
	vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
	vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

	vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move half page up and center current line" })
	vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = "Move whole page up and center current line" })
	vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move half page down and center current line" })
	vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = "Move whole page down and center current line" })
	vim.keymap.set("n", "n", "nzz", { desc = "Jump to next match and center current line" })
	vim.keymap.set("n", "N", "Nzz", { desc = "Jump to previous match and center current line" })

	-- https://www.reddit.com/r/neovim/comments/u221as/comment/i5y9zy2/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
	vim.api.nvim_create_user_command("CopyFilePath", function()
		local path = vim.fn.expand("%:p") -- :h expand
		vim.fn.setreg("+", path)
		vim.notify("Copied '" .. path .. "' to the clipboard") -- How's this different from print?
	end, {})

	-- [[ Install `lazy.nvim` plugin manager ]]
	--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			error("Error cloning lazy.nvim:\n" .. out)
		end
	end

	---@type vim.Option
	local rtp = vim.opt.rtp
	rtp:prepend(lazypath)

	-- [[ Configure and install plugins ]]
	require("lazy").setup({
		require("plugins.appearance"),
		require("plugins.blink"),
		require("plugins.conform"),
		require("plugins.git"),
		require("plugins.lsp"),
		require("plugins.navigation"),
		require("plugins.treesitter"),
		require("plugins.whichkey"),

		"ThePrimeagen/vim-be-good",

		{ -- Collection of various small independent plugins/modules
			"echasnovski/mini.nvim",
			config = function()
				-- Better Around/Inside textobjects
				--
				-- Examples:
				--  - va)  - [V]isually select [A]round [)]paren
				--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
				--  - ci'  - [C]hange [I]nside [']quote
				-- require("mini.ai").setup({ n_lines = 500 })

				-- Add/delete/replace surroundings (brackets, quotes, etc.)
				--
				-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				-- - sd'   - [S]urround [D]elete [']quotes
				-- - sr)'  - [S]urround [R]eplace [)] [']
				require("mini.surround").setup()
			end,
		},

		-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
		--
		--  Here are some example plugins that I've included in the Kickstart repository.
		--  Uncomment any of the lines below to enable them (you will need to restart nvim).
		--
		-- require 'kickstart.plugins.debug',
		-- require 'kickstart.plugins.indent_line',
		-- require 'kickstart.plugins.lint',
		-- require 'kickstart.plugins.autopairs',
		-- require 'kickstart.plugins.neo-tree',
		-- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

		-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
		--    This is the easiest way to modularize your config.
		--
		--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
		-- { import = 'custom.plugins' },
		--
		-- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
		-- Or use telescope!
		-- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
		-- you can continue same window with `<space>sr` which resumes last telescope search
	}, {
		ui = {
			-- If you are using a Nerd Font: set icons to an empty table which will use the
			-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
			icons = vim.g.have_nerd_font and {} or {
				cmd = "⌘",
				config = "🛠",
				event = "📅",
				ft = "📂",
				init = "⚙",
				keys = "🗝",
				plugin = "🔌",
				runtime = "💻",
				require = "🌙",
				source = "📄",
				start = "🚀",
				task = "📌",
				lazy = "💤 ",
			},
		},
	})

	-- The line beneath this is called `modeline`. See `:help modeline`
	-- vim: ts=2 sts=2 sw=2 et
end
