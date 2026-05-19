local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup()

-- Go：使用 mason 安装的 delve（dlv 在 mason PATH 中）
require("dap-go").setup({
	delve = { detached = vim.fn.has("win32") == 0 },
})

-- 断点 / 停驻图标
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn" })

-- DAP UI 随调试会话自动开关
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
