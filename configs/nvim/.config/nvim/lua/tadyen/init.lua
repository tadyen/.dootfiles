require("tadyen.set")

require("tadyen.remap")
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
require("tadyen.lazy_init")
require("tadyen.colour")

local augroup = vim.api.nvim_create_augroup
local tadyenGroup = augroup('tadyen', {})

