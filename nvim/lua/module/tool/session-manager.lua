local status_ok, per = pcall(require, "persistence")
if not status_ok then
	vim.notify("persistence not found!")
	return
end

per.setup({
	dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
	options = { "buffers", "curdir", "tabpages", "winsize" },
	pre_save = nil,
})

