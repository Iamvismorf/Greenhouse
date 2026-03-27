local group = vim.api.nvim_create_augroup("vismorf/statusline", { clear = true })
StatusLine = {}

local colors = require("zen.colors").get()
local palette = colors.palette
local highlights = {
	StatusLineFileName = { fg = palette.rose },
	StatusLineError = { fg = palette.diag_error },
	StatusLineOk = { fg = palette.diag_ok },
}
for h, o in pairs(highlights) do
	vim.api.nvim_set_hl(0, h, o)
end

vim.o.laststatus = 3
vim.o.cmdheight = 0

-- Thank you Maria
vim.o.showmode = false
function StatusLine.mode()
	local mode_to_str = {
		["n"] = "NORMAL",
		["no"] = "OP-PENDING",
		["nov"] = "OP-PENDING",
		["noV"] = "OP-PENDING",
		["no\22"] = "OP-PENDING",
		["niI"] = "NORMAL",
		["niR"] = "NORMAL",
		["niV"] = "NORMAL",
		["nt"] = "NORMAL",
		["ntT"] = "NORMAL",
		["v"] = "VISUAL",
		["vs"] = "VISUAL",
		["V"] = "VISUAL",
		["Vs"] = "VISUAL",
		["\22"] = "VISUAL",
		["\22s"] = "VISUAL",
		["s"] = "SELECT",
		["S"] = "SELECT",
		["\19"] = "SELECT",
		["i"] = "INSERT",
		["ic"] = "INSERT",
		["ix"] = "INSERT",
		["R"] = "REPLACE",
		["Rc"] = "REPLACE",
		["Rx"] = "REPLACE",
		["Rv"] = "VIRT REPLACE",
		["Rvc"] = "VIRT REPLACE",
		["Rvx"] = "VIRT REPLACE",
		["c"] = "COMMAND",
		["cv"] = "VIM EX",
		["ce"] = "EX",
		["r"] = "PROMPT",
		["rm"] = "MORE",
		["r?"] = "CONFIRM",
		["!"] = "SHELL",
		["t"] = "TERMINAL",
	}
	local mode = mode_to_str[vim.api.nvim_get_mode().mode] or "UNKNOWN"
	return string.format(" -- %s -- ", mode)
end

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

	-- return table.concat({ parent_dir, "/", file_name })
	return string.format(" %%#StatusLineFileName#%s/%s%%#StatusLine# ", parent_dir, file_name)
end

function StatusLine.diagnostics_error()
	local errorCount = vim.diagnostic.count(0)
	if not errorCount[vim.diagnostic.severity.ERROR] then
		return ""
	end
	return string.format(" %%#StatusLineError#%s%%#StatusLine# ", (errorCount[vim.diagnostic.severity.ERROR] .. ""))
end

function StatusLine.search_info()
	local search_result = vim.fn.searchcount()
	if search_result.total == 0 or vim.v.hlsearch == 0 then -- works meh
		return ""
	end

	return string.format(" [%s/%s] ", search_result.current, search_result.total)
end

local client_info = {
	name = nil,
	is_stopped = nil,
}
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local id = args.data.client_id
		client_info = {
			name = vim.lsp.get_client_by_id(id).name,
			status = vim.lsp.get_client_by_id(id).is_stopped(),
		}
		vim.cmd.redrawstatus()
	end,
})
vim.api.nvim_create_autocmd("LspDetach", {
	group = group,
	callback = function(args)
		local id = args.data.client_id
		client_info = {
			name = vim.lsp.get_client_by_id(id).name,
			is_stopped = vim.lsp.get_client_by_id(id).is_stopped(),
		}
		vim.cmd.redrawstatus()
	end,
})
function StatusLine.lsp_status()
	local str
	if client_info.is_stopped == nil and client_info.name == nil then
		return " no lsp :( "
	end
	if client_info.is_stopped then
		str = " %%#StatusLineError#%s "
	else
		str = " %%#StatusLineOk#%s "
	end
	return string.format(str .. "%%#StatusLine# ", client_info.name)
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
		StatusLine.mode(),
		StatusLine.git(),
		StatusLine.file_name(),
		" %h%r",
		" %m%=",

		StatusLine.diagnostics_error(),
		StatusLine.lsp_status(),
		StatusLine.search_info(),
		" %l:%c ",
	})
end

vim.o.statusline = "%!v:lua.StatusLine.render()"

vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "GitSignsUpdate",
	callback = function()
		vim.cmd.redrawstatus()
	end,
})
