return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Next changed hunk" })
				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Previous changed hunk" })

				-- Stage/unstage
				map("n", "<leader>gha", gitsigns.stage_hunk, { desc = "Stage/unstage hunk" })
				map("v", "<leader>gha", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Stage/unstage hunk" })
				map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Reset hunk" })
				map("v", "<leader>ghr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Reset hunk" })
				-- map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
				-- map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })

				-- Blame
				map("n", "<leader>ghb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Blame line" })
				map("n", "<leader>gb", gitsigns.blame, { desc = "Blame" })

				-- Diff
				map("n", "<leader>ghp", gitsigns.preview_hunk, { desc = "Preview hunk" })
				-- map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff against index" })
				map("n", "<leader>gd", function()
					gitsigns.diffthis("HEAD")
				end, { desc = "Diff against last commit" })
				map("n", "<leader>gq", gitsigns.setqflist, { desc = "View all changed hunks" })
				-- map("n", "<leader>gQ", function()
				-- 	gitsigns.setqflist("all")
				-- end, { desc = "View all changed hunks across repo" })
			end,
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)

			-- 'q' to quit blame window
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "gitsigns-blame",
				callback = function(ev)
					vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = ev.buf })
				end,
			})
		end,
	},
}
