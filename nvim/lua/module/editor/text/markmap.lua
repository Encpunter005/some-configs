local status_ok, mark = pcall(require, "markmap")

if not status_ok then
	vim.notify("mark not found")
end

mark.setup({
	html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
	hide_toolbar = false, -- (default)
	grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
})
