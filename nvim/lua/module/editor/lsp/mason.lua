local servers = {
    "lua_ls",
    "cssls",
    "html",
    "tsserver",
    "templ",
    "pyright",
    "bashls",
    "jsonls",
    "emmet_ls",
    "clangd",
    "cmake",
    "marksman",
    "yamlls",
    "jdtls",
    "bashls",
    "vimls",
    "volar",
    "rust_analyzer",
    "gopls",
}

local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    vim.notify("lspconfig not found")
    return
end

local opts = {}


for _, server in ipairs(servers) do
    opts = {
        on_attach = require("module.editor.lsp.handlers").on_attach,
        capabilities = require("module.editor.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "module.editor.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup { opts }
end

-- Automatically open lsp-inlayhints
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(0, true)
        end
        -- whatever other lsp config you want
    end
})
