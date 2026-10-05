return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local show_hidden = false
		local show_ignored = false

		local function find_files_toggle(default_text)
			require("telescope.builtin").find_files({
				hidden = show_hidden,
				no_ignore = show_ignored,
				default_text = default_text,
				prompt_title = "Find Files"
					.. (show_hidden and " [hidden]" or "")
					.. (show_ignored and " [ignored]" or ""),
			})
		end

		local function toggle_ignored()
			local action_state = require("telescope.actions.state")
			local line = action_state.get_current_line()
			show_ignored = not show_ignored
			find_files_toggle(line)
		end

		local function toggle_hidden()
			local action_state = require("telescope.actions.state")
			local line = action_state.get_current_line()
			show_hidden = not show_hidden
			find_files_toggle(line)
		end

		require("telescope").setup({
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					flex = {
						flip_columns = 120,
					},
				},
				mappings = {
					i = {
						["<A-i>"] = toggle_ignored,
						["<A-h>"] = toggle_hidden,
					},
					n = {
						["<A-i>"] = toggle_ignored,
						["<A-h>"] = toggle_hidden,
					},
				},
				extensions = {
					fzf = {},
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find files" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Grep files" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keybinds" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search word under cursor" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help tags" })
		vim.keymap.set("n", "<leader>sd", function()
			builtin.diagnostics({
				attach_mappings = function(_, map)
					local function diagnostic_float()
						require("telescope.actions").select_default(_)
						vim.schedule(vim.diagnostic.open_float)
					end

					map("i", "<CR>", diagnostic_float)
					map("n", "<CR>", diagnostic_float)

					return true
				end,
			})
		end, { desc = "Search diagnostics" })
	end,
}
