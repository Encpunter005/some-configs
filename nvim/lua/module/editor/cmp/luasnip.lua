local luasnip_loader = require("luasnip.loaders.from_vscode")

local snippet_path = vim.fn.stdpath("config") .. "/my-snippets/"
if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
	vim.opt.rtp:append(snippet_path)
end

require("luasnip").config.setup({
	region_check_events = "CursorHold,InsertLeave,InsertEnter",
	delete_check_events = "TextChanged,InsertEnter",
})

require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip.loaders.from_snipmate").lazy_load()
