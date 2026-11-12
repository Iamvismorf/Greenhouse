--todo: bug with gg
return {
	"statuscol.nvim",
	after = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			relculright = true,
			segments = {
				{
					-- sign = { namespace = { "diagnostic" }, maxwidth = 1, colwidth = 2 },
					sign = { maxwidth = 1, colwidth = 2 },
				},
				-- adopted from https://github.com/mcauley-penney/nvim/blob/main/lua/plugins.lua#L766. Also handles line wrap
				{
					text = {
						"%=",
						function(args)
							local mode = vim.fn.mode()
							local normalised_mode = vim.fn.strtrans(mode):lower():gsub("%W", "")

							local line = builtin.lnumfunc(args)
							if args.virtnum < 0 then
								return "-"
							end
							if args.virtnum > 0 then
								local num_wraps = vim.api.nvim_win_text_height(args.win, {
									start_row = args.lnum - 1,
									end_row = args.lnum - 1,
								})["all"] - 1
								if args.virtnum == num_wraps then
									-- line = "└"
									line = "┕"
								else
									line = "│"
									-- line = "┝"
								end
							end

							if normalised_mode == "v" then
								local selected_region = vim.fn.getregionpos(
									vim.fn.getpos("v"),
									vim.fn.getpos("."),
									{ eol = true, type = mode }
								)
								local s, e = selected_region[1][1], selected_region[#selected_region][2]

								local win_info = vim.fn.getwininfo(args.win)[1]
								local offset = win_info.winrow + win_info.winbar - 1 --extra spaces from tabline and winbar
								local winline = vim.fn.screenpos(args.win, args.lnum, 1).row
									- offset
									-- - win_info.winrow
									-- - win_info.winbar
									-- + 1
									+ args.virtnum

								-- normalised here means in "window" coordinate system
								local norm_s_row = vim.fn.screenpos(args.win, s[2], s[3]).row - offset
								local norm_e_row = vim.fn.screenpos(args.win, e[2], e[3]).row - offset

								if args.lnum >= s[2] and args.lnum <= e[2] then
									line = "%#LineNr#" .. line
								end

								if winline >= norm_s_row and winline <= norm_e_row then
									line = line:gsub("%%#LineNr#", "")
									return "%#CursorLineNr#" .. line
								end
							end
							return line
						end,
						" ",
					},
					condition = {
						function(args)
							return args.rnu or args.nu
						end,
					},
				},
				{
					sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 2 },
				},
			},
		})
	end,
}
