require("lze").load({
	{ import = "vismorf.cmp" },
	{ import = "vismorf.format" },
})
require("vismorf.config")
require("vismorf.plugins")
require("vismorf.lsp")
-- local file = vim.api.nvim_buf_get_name(0)
-- local is_dir = vim.fn.isdirectory(file) == 1
--
-- if is_dir then
-- 	vim.cmd.cd(file)
-- end
