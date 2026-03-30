--todo: add keybind to disable this and change to the directory of the current file and add keybind to reactivate??
--feat: cache init directory so when disable cd into it
local M = {}

M.defaults = {
	rootmarkers = { ".envrc", ".gitignore", ".git" },
	ignoreDirs = { "%.git*", ".direnv" }, -- don't find root for files that are in these directories
}
local cached_roots = {}
local last_dir = nil
local last_root = nil

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.defaults, opts or {})

	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function(ev)
			local buf = vim.bo[ev.buf]
			local current_file = ev.file
			local parent_dir = vim.fs.dirname(current_file)

			if buf.buftype ~= "" then
				return
			end
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

return M
