vim.o.foldcolumn = "0"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- return {
-- 	{
-- 		"nvim-ufo",
-- 		after = function()
-- 			require("ufo").setup({
-- 				provider_selector = function(bufnr, filetype, buftype)
-- 					return { "treesitter", "indent" }
-- 				end,
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"promise-async",
-- 		dep_of = { "nvim-ufo" },
-- 	},
-- }
