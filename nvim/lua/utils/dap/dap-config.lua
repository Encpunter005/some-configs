local M = {}

local function config_dapi_and_sign()
    local icons = require('config').icons
    local dap_breakpoint = {
        error = {
            text = icons.dap.Breakpoint,
            texthl = "LspDiagnosticsSignError",
            linehl = "",
            numhl = "",
        },
        rejected = {
            text = icons.dap.BreakpointRejected,
            texthl = "LspDiagnosticsSignHint",
            linehl = "",
            numhl = "",
        },
        stopped = {
            text = icons.diagnostics.Info,
            texthl = "LspDiagnosticsSignInformation",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "LspDiagnosticsSignInformation",
        },
    }

    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function config_dapui()
    local dap, dapui                                      = require "dap", require "dapui"

    local debug_open                                      = function()
        dapui.open()
        vim.api.nvim_command("DapVirtualTextEnable")
        vim.api.nvim_command("NvimTreeClose")
    end
    local debug_close                                     = function()
        dap.repl.close()
        dapui.close()
        vim.api.nvim_command("DapVirtualTextDisable")
        -- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
    end

    dap.listeners.after.event_initialized["dapui_config"] = function()
        debug_open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        debug_close()
    end
    dap.listeners.before.event_exited["dapui_config"]     = function()
        debug_close()
    end
    dap.listeners.before.disconnect["dapui_config"]       = function()
        debug_close()
    end
end

local function config_debuggers()
    local dap = require "dap"
    -- TODO: wait dap-ui for fixing temrinal layout
    -- the "30" of "30vsplit: doesn't work
    dap.defaults.fallback.terminal_win_cmd = '30vsplit new' -- this will be overrided by dapui
    -- dap.set_log_level("DEBUG")

    -- load from json file
    require('dap.ext.vscode').load_launchjs(nil, { cppdbg = { 'cpp' } })
    -- config per launage

    require("module.dap.dap-cpp")
    require("module.dap.dap-python")
end

function M.setup()
    config_dapi_and_sign()
    config_dapui()
    config_debuggers() -- Debugger
end

return M
