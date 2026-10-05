return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.files").setup({
			windows = {
				width_focus = 999,
			},
			mappings = {
				go_in = "L",
				go_in_plus = "l",
			},
		})

		vim.keymap.set("n", "<leader>e", function()
			local file_explorer = require("mini.files")
			local buffer_name = vim.api.nvim_buf_get_name(0)

			if not file_explorer.close() then
				file_explorer.open(buffer_name, false)
			end
		end, { desc = "Toggle file explorer" })

		-- Get function name with treesitter to be able to display it in the statusline
		local function_types = {
			function_declaration = true,
			function_definition = true,
			method_declaration = true,
		}

		local function get_function_name()
			local ok, node = pcall(vim.treesitter.get_node)
			if not ok or not node then
				return ""
			end

			while node do
				if function_types[node:type()] then
					local name_node = node:field("name")[1]
					if name_node then
						return "󰊕 " .. vim.treesitter.get_node_text(name_node, 0)
					end
				end
				node = node:parent()
			end

			return ""
		end

		require("mini.statusline").setup({
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 999 })
					local git = MiniStatusline.section_git({ trunc_width = 40 })
					local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
					local filename = MiniStatusline.section_filename({ trunc_width = 999 })
					local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
					local location = "%2l:%-2v %P"

					local function_name = get_function_name()

					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
						"%<",
						{ hl = "", strings = { filename } },
						"%=",
						{ hl = "", strings = { function_name, search, location } },
					})
				end,
			},
		})

		-- require("mini.icons").setup()

		require("mini.tabline").setup()

		vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = "#89b4fb", underline = true })
		vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = "#89b4fb" })
		vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = "#89b4fb" })
		vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { fg = "#89b4fb", underline = true, italic = true })
		vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", { fg = "#89b4fb", italic = true })
		vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { fg = "#89b4fb", italic = true })
	end,
}
