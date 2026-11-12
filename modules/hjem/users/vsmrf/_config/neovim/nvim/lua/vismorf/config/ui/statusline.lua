local group = vim.api.nvim_create_augroup("vismorf/statusline", {})
StatusLine = {}

vim.o.laststatus = 3
vim.o.showcmdloc = "statusline"

vim.o.showmode = false

function StatusLine.git()
	local head = vim.b.gitsigns_head
	if not head then
		return ""
	end

	return string.format(" [@%s]", head)
end

function StatusLine.file_name()
	local file_name = vim.fn.expand("%:t")
	local parent_dir = vim.fn.expand("%:p:h:t")

	--fixme: `vim folder` results in folder/folder but `vim folder/` doesn't return desired result. Assuming folder exists
	return string.format(" %%#StatusLineFileName#%s/%s%%*", parent_dir, file_name)
end

function StatusLine.diagnostics_error()
	local errorCount = vim.diagnostic.count(0)
	local icon = vim.diagnostic.config().signs.text[vim.diagnostic.severity.ERROR]
	if not errorCount[vim.diagnostic.severity.ERROR] then
		return ""
	end
	return string.format(" %%#StatusLineError#%s%%* ", (errorCount[vim.diagnostic.severity.ERROR] .. icon))
end

function StatusLine.lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	if clients[1] == nil then
		return " %#StatusLineError#no lsp %*"
	end

	local client_name = clients[1].name

	if clients[1]:is_stopped() then
		return string.format("%%#StatusLineError#%s %%* ", client_name)
	end
	return string.format("%%#StatusLineOk#%s %%* ", client_name)
end

function StatusLine.render()
	if vim.o.filetype == "help" then
		return table.concat({
			" %h",
			" %m%=",
			" %l:%c",
			" ",
		})
	end
	return table.concat({
		StatusLine.git(),
		StatusLine.file_name(),
		" %h%r",
		" %m%=%S%=",

		StatusLine.diagnostics_error(),
		StatusLine.lsp_status(),
		" %l:%c ",
	})
end

vim.api.nvim_create_autocmd({ "UiEnter", "WinEnter" }, {
	group = group,
	callback = function()
		local win = vim.api.nvim_get_current_win()

		if vim.api.nvim_win_get_config(win).relative ~= "" then
			vim.o.statusline = " "
			return
		end

		vim.o.statusline = "%!v:lua.StatusLine.render()"
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "GitSignsUpdate",
	callback = function()
		vim.defer_fn(function()
			vim.cmd.redrawstatus()
		end, 300)
	end,
})
