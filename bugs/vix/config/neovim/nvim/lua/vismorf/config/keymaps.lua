local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- map("t", "<c-e>", "<C-\\><C-n>", opts) -- go to normal mode in terminal
-- map("n", "<M-t>", ":term<cr>", opts)

map("n", "<esc>", ":noh<cr>", opts)

map({ "n", "v", "x" }, "<leader>y", '"+y', opts)
map({ "n", "v", "x" }, "<leader>d", '"+d', opts)
map("n", "<leader>cc", "gcc", { remap = true, silent = true })
map("v", "<leader>c", "gc", { remap = true, silent = true })

-- Navigate between windows using Ctrl + h/j/k/l
map({ "n", "v", "i" }, "<C-h>", "<esc><C-w>h", opts)
map({ "n", "v", "i" }, "<C-j>", "<esc><C-w>j", opts)
map({ "n", "v", "i" }, "<C-k>", "<esc><C-w>k", opts)
map({ "n", "v", "i" }, "<C-l>", "<esc><C-w>l", opts)

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")

map("n", "H", "Hzz", opts)
map("n", "L", "Lzz", opts)

vim.cmd("cnoremap <c-k> <c-p>")
vim.cmd("cnoremap <c-j> <c-n>")

map({ "n", "v" }, "<leader>w", "<esc>:FlipVirtualText<cr>", {})
