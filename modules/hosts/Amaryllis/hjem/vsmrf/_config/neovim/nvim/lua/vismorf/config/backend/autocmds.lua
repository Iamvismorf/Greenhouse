-- vim.api.nvim_create_autocmd("BufWinEnter", {
-- 	pattern = "*",
-- 	callback = function(event)
-- 		if vim.bo[event.buf].filetype == "help" then
-- 			vim.bo[event.buf].buflisted = true
-- 			vim.cmd.only()
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
	callback = function()
		local session_dir = vim.fn.stdpath("state") .. "/sessions/"
		local session_path = session_dir .. vim.fn.getcwd():gsub("/", "%%") .. ".vim"
		local buf_number = #vim.fn.getbufinfo({ buflisted = true })

		vim.fn.mkdir(session_dir, "p")

		if buf_number <= 1 or vim.fn.getcwd() == vim.fn.expand("~") then
			return
		end

		vim.cmd("mks! " .. vim.fn.fnameescape(session_path))
	end,
})
