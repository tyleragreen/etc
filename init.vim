set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua << EOF
-- We save this in the lua directory so that nvim doesn't pick it up automatically
local init_lua = vim.env.HOME .. '/.config/nvim/lua/init.lua'
package.path = package.path .. ';' .. init_lua
require("init")
EOF
