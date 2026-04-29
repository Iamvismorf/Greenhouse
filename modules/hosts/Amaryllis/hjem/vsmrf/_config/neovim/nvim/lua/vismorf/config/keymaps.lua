-- remap means if a key you map to is itself mapped to something else, that second mapping will also trigger.
local map = vim.keymap.set

--todo: highlights from %s not available
map("n", ":", "q:i")
map("n", "<esc>", function()
	if vim.fn.getcmdwintype() ~= "" then
		vim.cmd.close()
	else
		vim.cmd.noh()
	end
end)
vim.api.nvim_create_autocmd("CmdwinEnter", {
	callback = function()
		vim.api.nvim_win_set_config(0, {
			relative = "laststatus",
			width = vim.o.columns,
			height = vim.o.cmdwinheight,
			col = 0,
			row = 0,
		})
	end,
})

map("n", "<leader>o", "]<space>", { remap = true })
map("n", "<leader>O", "[<space>", { remap = true })

map({ "n", "v", "x" }, "<leader>y", '"+y')
map({ "n", "v", "x" }, "<leader>Y", '"+Y', { remap = true })
map({ "n", "v", "x" }, "<leader>d", '"+d')
map({ "n", "v", "x" }, "<leader>D", '"+D')
map("n", "<leader>cc", "gcc", { remap = true })
map("v", "<leader>c", "gc", { remap = true })

map("n", "ZZ", "<nop>")
map("n", "<C-e>", "<nop>")
map("n", "<C-y>", "<nop>")
map("n", "<C-z>", "<nop>")

map("n", "<leader>x", function()
	require("snacks").bufdelete.delete()
end)

map("n", "j", function()
	return vim.v.count1 > 1 and ("m`" .. vim.v.count1 .. "j") or "j"
end, { expr = true })
map("n", "k", function()
	return vim.v.count1 > 1 and ("m`" .. vim.v.count1 .. "k") or "k"
end, { expr = true })

map({ "n", "v", "i" }, "<C-h>", "<esc><C-w>h")
map({ "n", "v", "i" }, "<C-j>", "<esc><C-w>j")
map({ "n", "v", "i" }, "<C-k>", "<esc><C-w>k")
map({ "n", "v", "i" }, "<C-l>", "<esc><C-w>l")

-- map("n", "H", "Hzz", opts)
-- map("n", "L", "Lzz", opts)

map("n", "H", ':lua MiniAnimate.execute_after("scroll", "normal! Hzz")<CR>', { silent = true })
map("n", "L", ':lua MiniAnimate.execute_after("scroll", "normal! Lzz")<CR>', { silent = true })

vim.cmd("cnoremap <c-k> <c-p>")
vim.cmd("cnoremap <c-j> <c-n>")

map({ "n", "v" }, "<leader>w", function()
	if
		vim.diagnostic.config().virtual_text --[[ and vim.diagnostic.config().underline  ]]
	then
		vim.diagnostic.config({
			-- virtual_lines = false,
			virtual_text = false,
			-- underline = false,
		})
	else
		vim.diagnostic.config({
			-- virtual_text = { source = "if_many" },
			virtual_text = true,
			-- virtual_lines = true,
			-- underline = true,
		})
	end
end)
