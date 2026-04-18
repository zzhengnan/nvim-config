-- Highlight when yanking text
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Close diff tab with `q`. BufWinEnter fires before diff mode is set, so defer the check by 100ms
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(ev)
		vim.defer_fn(function()
			if vim.wo.diff then
				vim.keymap.set("n", "q", "<cmd>tabclose<cr>", { buffer = ev.buf })
			end
		end, 100)
	end,
})
