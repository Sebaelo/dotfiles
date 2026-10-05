-- Remove newline comments
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})

-- Highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "Visual",
			timeout = 100,
		})
	end,
})

-- Make terminal split not show up in tabline
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.bo.buflisted = false
	end,
})
