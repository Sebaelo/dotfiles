return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					vim.keymap.set("n", "<leader>gn", gitsigns.next_hunk, { buffer = bufnr, desc = "Next git change" })

					vim.keymap.set(
						"n",
						"<leader>gp",
						gitsigns.prev_hunk,
						{ buffer = bufnr, desc = "Previous git change" }
					)

					vim.keymap.set(
						"n",
						"<leader>gP",
						gitsigns.preview_hunk,
						{ buffer = bufnr, desc = "Git preview change" }
					)

					vim.keymap.set(
						"n",
						"<leader>gR",
						gitsigns.reset_hunk,
						{ buffer = bufnr, desc = "Git reset changes" }
					)
				end,
			})
		end,
	},

	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup({
				default_mappings = {
					ours = "o",
					theirs = "t",
					none = "0",
					both = "b",
					next = "n",
					prev = "p",
				},
			})

			vim.keymap.set("n", "<leader>gc", "<cmd>GitConflictRefresh<cr>", { desc = "Refresh git conflicts" })
		end,
	},
}
