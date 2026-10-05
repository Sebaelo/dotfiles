return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"tailwindcss",
				"ts_ls",
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, { desc = "Hover documentation", buffer = event.buf })

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = event.buf })

				vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references", buffer = event.buf })

				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = event.buf })

				vim.keymap.set("n", "<leader>ca", function()
					vim.lsp.buf.code_action({
						filter = function(action)
							return not action.disabled
						end,
					})
				end, { buffer = event.buf, desc = "Code actions" })

				vim.keymap.set("n", "<leader>dn", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, { buffer = event.buf, desc = "Go to next diagnostic" })

				vim.keymap.set("n", "<leader>dp", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, { buffer = event.buf, desc = "Go to previous diagnostic" })

				vim.lsp.document_color.enable(true, { bufnr = event.buf }, { style = "virtual" })
			end,
		})

		vim.diagnostic.config({
			severity_sort = true,
			underline = false,
			-- not sure if i want to keep signs on or off...
			signs = false,
			update_in_insert = false,
			float = {
				border = "rounded",
				source = "if_many",
				header = "",
			},
		})
	end,
}
