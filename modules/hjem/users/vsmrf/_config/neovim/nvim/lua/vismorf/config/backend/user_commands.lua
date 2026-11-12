--todo: create replace all user command using vimgrep and cdo

--usefull flags:
-- I - don't ignore case
-- g - global
-- c - confirm

vim.api.nvim_create_user_command("RestroreLastSession", function()
	local last_session = vim.fn.stdpath("state") .. "/sessions/" .. vim.fn.getcwd():gsub("/", "%%") .. ".vim"
	if vim.fn.filereadable(last_session) == 1 then
		vim.cmd.source(vim.fn.fnameescape(last_session))
	end
end, {})
