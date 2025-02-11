-- https://neovim.io/doc/user/quickref.html#option-list
vim.opt.guicursor = ""

-- column numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- cursor opts
vim.opt.concealcursor = "nic"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.guicursor = "v:block,i:ver20,n:hor20,a:blinkwait800-blinkoff400-blinkon250"

-- word wrap
vim.opt.wrap = true
vim.opt.whichwrap = "<,>,[,]"
vim.opt.showbreak = "<> "
local cpo_default = "aAceFs_"
vim.opt.cpo = cpo_default .. "n"    -- put showbreak in line-numbers instead
--testwwrapaverylongstring_sdfsdfhdfjkghdfghdfjkhgjdfkghjkdfhgdfhgjkdfghdfhsdfsdfjsdfjklsdfjklsdfjskldfjklsdfjksldfjklsdfjskldfjskldfjsdklfjskdlfjskldfjskdfljskldfjskldfjskldfjskldfjksldfjskldfjskldfjklsdfjksldfjklsdfvfdsfdsfsdfsdfdsfdfghdfjkghsdfjkghjkdfhgjkdfhgjkdfhgjkdfhgjkdfhgjdfhgkdfhgjdfhgkjdfhgjkdfhgjkdfhgjkdfhgjkdfhgjkdhfgjdfkhgjdkfhgjkdfhgjkdhfgdkfjghdfgjhdkfghdjkfghjkdfghjdkfghdjkfghjkdfghjdfkghdjkfghdjkfghjdfkgdfhgjfsdfsdfsdfsdfsdfdfgjkhdfjghdfghdjfhgjkdfhgdfjhgjkdfhgjkdfhgjkhdfgg

-- backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

