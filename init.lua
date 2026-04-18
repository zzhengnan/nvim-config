-- :source % to run current file
-- :lua with visual selection to run just the selection

-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

require("autocmds")
require("user_commands")
require("keymaps")
require("options")

if vim.g.vscode then
	-- Yank to system clipboard when in VS Code
	-- https://github.com/vscode-neovim/vscode-neovim/issues/298#issuecomment-1636762241
	vim.opt.clipboard:append("unnamedplus")
	return
else
	if vim.fn.has("win32") == 1 then
		-- Use cmd as the shell so that external calls to git can be found. This is a workaround and ideally should be removed
		vim.opt.shell = "cmd.exe"
	end

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
		{ import = "plugins" },
	})

	-- The line beneath this is called `modeline`. See `:help modeline`
	-- vim: ts=2 sts=2 sw=2 et
end
