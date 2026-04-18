--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>")

vim.keymap.set("n", "<Backspace>", "<CMD>wa<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
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

vim.keymap.set("n", "<leader>gho", "<CMD>OpenRemote<CR>", { desc = "Open in remote", silent = true })
