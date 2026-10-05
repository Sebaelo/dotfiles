return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter").install({
			"lua",
			"javascript",
			"typescript",
			"json",
			"tsx",
			"markdown",
			"markdown_inline",
		})

		-- Enable highlights after nvim-treesitter.configs has been deprecated
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
