Winbar = {}

function Winbar.file_name()
	local file_name = vim.fn.expand("%:t")
	local parent_dir = vim.fn.expand("%:p:h:t")
	local icon, color = require("nvim-web-devicons").get_icon(file_name, vim.fn.expand("%:e"), { default = true })

	icon = "%#" .. color .. "#" .. icon .. "%*"

	if vim.fn.isdirectory(vim.fn.expand("%:p")) == 1 or (file_name == "") then
		return ""
	end

	return string.format("%s %%#WinbarFileName#%s/%s", icon, parent_dir, file_name)
end
function Winbar.icon()
	local icon, color = require("nvim-web-devicons").get_icon_by_filetype(vim.fn.expand("%:e"))
	if color == nil or icon == nil then
		return
	end
	return "%#" .. color .. "#" .. icon .. "%*"
end

function Winbar.render()
	return table.concat({
		"%=",
		"%m ",
		Winbar.file_name(),
	})
end

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		-- vim.print(vim.api.nvim_win_get_config(0))
		local wins = vim.api.nvim_tabpage_list_wins(0)
		wins = vim.tbl_filter(function(win)
			return vim.api.nvim_win_get_config(win).relative == "" and vim.fn.win_gettype(win) ~= "command"
		end, wins)

		if #wins <= 1 then
			vim.o.winbar = ""
			return
		end

		vim.o.winbar = "%=%m %{%v:lua.Winbar.file_name()%}%="
	end,
})
