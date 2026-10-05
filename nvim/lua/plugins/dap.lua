return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"igorlfs/nvim-dap-view",
	},
	config = function()
		local dap = require("dap")
		local dapview = require("dap-view")

		dapview.setup({})

		dap.listeners.after.event_initialized["dapview"] = function()
			dapview.open()
		end
		dap.listeners.before.event_terminated["dapview"] = function()
			dapview.close()
		end

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue debugging" })
		vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate debugging session" })
		vim.keymap.set("n", "<leader>dv", dapview.toggle, { desc = "Toggle debug view" })

		local function enable_debug_keys()
			vim.keymap.set("n", "<Down>", dap.step_over, { desc = "Step over" })
			vim.keymap.set("n", "<Right>", dap.step_into, { desc = "Step into" })
			vim.keymap.set("n", "<Left>", dap.step_out, { desc = "Step out" })
		end

		local function disable_debug_keys()
			pcall(vim.keymap.del, "n", "<Down>")
			pcall(vim.keymap.del, "n", "<Right>")
			pcall(vim.keymap.del, "n", "<Left>")
		end

		dap.listeners.after.event_initialized["debug_keys"] = enable_debug_keys
		dap.listeners.before.event_terminated["debug_keys"] = disable_debug_keys
	end,
}
