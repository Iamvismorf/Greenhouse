-- make shift j and shift k to move between buffers
local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- map("t", "<c-e>", "<C-\\><C-n>", opts) -- go to normal mode in terminal
-- map("n", "<M-t>", ":term<cr>", opts)

map("n", "<esc>", ":noh<cr>", opts)
map("n", "<leader>o", "]<space>", { remap = true })
map("n", "<leader>O", "[<space>", { remap = true })

map({ "n", "v", "x" }, "<leader>y", '"+y', opts)
map({ "n", "v", "x" }, "<leader>d", '"+d', opts)
map({ "n", "v", "x" }, "<leader>Y", '"+Y', opts)
map({ "n", "v", "x" }, "<leader>D", '"+D', opts)
map("n", "<leader>cc", "gcc", { remap = true, silent = true })
map("v", "<leader>c", "gc", { remap = true, silent = true })

vim.keymap.set("n", "j", function()
	return vim.v.count1 > 1 and ("m`" .. vim.v.count1 .. "j") or "j"
end, { expr = true, desc = "set context mark before moving more than one line down" })
vim.keymap.set("n", "k", function()
	return vim.v.count1 > 1 and ("m`" .. vim.v.count1 .. "k") or "k"
end, { expr = true, desc = "set context mark before moving more than one line up" })

-- Navigate between windows using Ctrl + h/j/k/l
map({ "n", "v", "i" }, "<C-h>", "<esc><C-w>h", opts)
map({ "n", "v", "i" }, "<C-j>", "<esc><C-w>j", opts)
map({ "n", "v", "i" }, "<C-k>", "<esc><C-w>k", opts)
map({ "n", "v", "i" }, "<C-l>", "<esc><C-w>l", opts)

-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")
-- map("n", "<C-f>", "<C-f>zz")
-- map("n", "<C-b>", "<C-b>zz")

map("n", "H", "Hzz", opts)
map("n", "L", "Lzz", opts)

vim.cmd("cnoremap <c-k> <c-p>")
vim.cmd("cnoremap <c-j> <c-n>")

map({ "n", "v" }, "<leader>w", "<esc>:FlipVirtualText<cr>", {})
