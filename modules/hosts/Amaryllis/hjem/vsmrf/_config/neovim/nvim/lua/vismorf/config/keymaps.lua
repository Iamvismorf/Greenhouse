-- remap means if a key you map to is itself mapped to something else, that second mapping will also trigger.
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

--todo: https://github.com/saghen/blink.cmp/commit/37c96dc06032b3f128b230b5fb193706535b3811
map("n", ":", "q:i")
map("n", "<esc>", function()
	if vim.fn.getcmdwintype() ~= "" then
		vim.cmd.close()
	else
		vim.cmd.noh()
	end
end, opts)
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

map({ "n", "v", "x" }, "<leader>y", '"+y', opts)
map({ "n", "v", "x" }, "<leader>Y", '"+Y', { remap = true, silent = true })
map({ "n", "v", "x" }, "<leader>d", '"+d', opts)
map({ "n", "v", "x" }, "<leader>D", '"+D', opts)
map("n", "<leader>cc", "gcc", { remap = true, silent = true })
map("v", "<leader>c", "gc", { remap = true, silent = true })

map("n", "ZZ", "<nop>")
map("n", "<C-e>", "<nop>")
map("n", "<C-y>", "<nop>")
map("n", "<C-z>", "<nop>")

map("n", "<leader>x", function()
	require("snacks").bufdelete.delete()
end, opts)

vim.keymap.set("n", "j", function()
	return vim.v.count1 > 1 and ("m`" .. vim.v.count1 .. "j") or "j"
end, { expr = true, desc = "set context mark before moving more than one line down" })
vim.keymap.set("n", "k", function()
	return vim.v.count1 > 1 and ("m`" .. vim.v.count1 .. "k") or "k"
end, { expr = true, desc = "set context mark before moving more than one line up" })

map({ "n", "v", "i" }, "<C-h>", "<esc><C-w>h", opts)
map({ "n", "v", "i" }, "<C-j>", "<esc><C-w>j", opts)
map({ "n", "v", "i" }, "<C-k>", "<esc><C-w>k", opts)
map({ "n", "v", "i" }, "<C-l>", "<esc><C-w>l", opts)

-- map("n", "H", "Hzz", opts)
-- map("n", "L", "Lzz", opts)

map("n", "H", ':lua MiniAnimate.execute_after("scroll", "normal! Hzz")<CR>', opts)
map("n", "L", ':lua MiniAnimate.execute_after("scroll", "normal! Lzz")<CR>', opts)

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
