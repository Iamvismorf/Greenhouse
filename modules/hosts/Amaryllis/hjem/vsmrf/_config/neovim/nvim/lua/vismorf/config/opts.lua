-- vim.api.nvim_create_autocmd("BufWinEnter", {
-- 	pattern = "*",
-- 	callback = function(event)
-- 		if vim.bo[event.buf].filetype == "help" then
-- 			vim.bo[event.buf].buflisted = true
-- 			vim.cmd.only()
-- 		end
-- 	end,
-- })
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.winborder = "single"
vim.o.laststatus = 3

vim.o.numberwidth = 3
vim.o.statuscolumn = ""
-- vim.o.scrolloff = 8
-- vim.o.sidescrolloff = 8

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.o.winbar = " "
-- local events = { "VimEnter", "BufEnter", "BufModifiedSet", "WinEnter", "WinLeave" }
-- vim.api.nvim_create_autocmd(events, {
-- 	callback = function()
-- 		vim.opt_local.winbar = "%{%v:lua.require'nvim-navic'.get_location()%} %= %m%t"
-- 		if vim.bo.filetype == "neo-tree" then
-- 			vim.opt_local.winbar = nil
-- 		end
-- 	end,
-- })
-- vim.o.winbar = "%=%m %t"

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "neo-tree" },
	callback = function()
		require("ufo").detach()
		vim.opt_local.foldenable = false
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.winbar = nil
	end,
})
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		vim.cmd("cle")
	end,
})
