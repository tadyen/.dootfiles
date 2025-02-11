vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- cmd shortcuts
vim.keymap.set("n", "<leader>ls", vim.cmd.Ex)
vim.keymap.set("n", "<leader>git", vim.cmd.Git)

-- move selected lines
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv")

-- copy selected lines
vim.keymap.set("v", "<A-S-Down>", ":co '><CR>gv=gv")
vim.keymap.set("v", "<A-S-Up>", ":co '<-1<CR>gv=gv")

-- keep cursor centered in sreen during search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "n", "Nzzzv")


