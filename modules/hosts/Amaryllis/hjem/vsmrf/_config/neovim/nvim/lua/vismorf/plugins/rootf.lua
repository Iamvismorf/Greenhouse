local M = {}

M.defaults = {
	rootmarkers = { ".envrc", ".gitignore", ".git" },
	ignoreDirs = { "%.git*", ".direnv" }, -- don't find root for files that are in these directories
}
local cached_roots = {}
local augroup = vim.api.nvim_create_augroup("vismorf/rootf", {})
local last_root = nil

function M._enable()
	local last_dir = nil
	vim.o.autochdir = false
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		group = augroup,
		callback = function(ev)
			local buf = vim.bo[ev.buf]
			if buf.buftype ~= "" or vim.fn.win_gettype() ~= "" then
				return
			end

			local current_file = ev.file
			if current_file == "" then
				vim.cmd.edit(vim.fn.getcwd()) -- without this yazi opens in the root instead of the directory.
				current_file = vim.fn.getcwd()
			end
			local parent_dir = vim.fs.dirname(current_file)

			if last_dir == parent_dir then
				cached_roots[current_file] = last_root
				return
			end

			local root = cached_roots[current_file]

			if root == nil then
				local should_ignore = vim.tbl_contains(M.config.ignoreDirs, function(v)
					return string.find(parent_dir, v) ~= nil
				end, { predicate = true })
				if should_ignore then
					return
				end

				root = vim.fs.find(
					M.config.rootmarkers,
					{ upward = true, path = current_file, stop = vim.fn.expand("~") }
				)[1]

				if root == nil then
					return
				end
				root = vim.fs.dirname(root)

				cached_roots[current_file] = root
			end
			last_dir = parent_dir
			last_root = root

			vim.fn.chdir(root)
		end,
	})
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.defaults, opts or {})
	M._enable()

	vim.api.nvim_create_user_command("DisableRootf", function()
		vim.api.nvim_clear_autocmds({ group = augroup })
		vim.o.autochdir = true
	end, {})

	vim.api.nvim_create_user_command("EnableRootf", function()
		M._enable()
		vim.api.nvim_exec_autocmds("BufEnter", { group = augroup })
	end, {})
end

return M
