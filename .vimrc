"------------------------------------------------------------------------------
" VIM-PLUG - keep this at the top
"------------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'

" Dependency for telescope
Plug 'nvim-lua/plenary.nvim'

" A slick popup window for switching between files and buffers
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }

" My current color scheme
Plug 'sainnhe/edge'

" This allows you to render markdown in realtime in a browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'

" Nerdtree is one of the main file browsers for vim. I don't use this very
" often (I prefer absolute paths or telescope), but I thought it wouldn't hurt
" to be familiar with.
Plug 'preservim/nerdtree'

" neovim's builtin LSP. Yes, I find it confusing that you have to install
" something to get the builtin LSP also. I previously used COC and liked it.
Plug 'neovim/nvim-lspconfig'
" nvim-cmp provides autocompletion and...
Plug 'hrsh7th/nvim-cmp'
" connects to the LSP using cmp-nvim-lsp
Plug 'hrsh7th/cmp-nvim-lsp'
" These next two are needed for when an autocompletion item actually selected.
" This is called a "snippet" that is actually inserted into your buffer.
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap-python'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'nvim-treesitter/nvim-treesitter'
" I'm using Neovim's builtin lspconfig in my init.vim file for Rust, Lua, and
" Python. Keeping this here for now in case I need it.
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_global_extensions = [
"   \ 'coc-tsserver',
"   \ 'coc-kotlin'
"   \ ]
call plug#end()

"------------------------------------------------------------------------------
" BASICS
"------------------------------------------------------------------------------
let mapleader = " "

set termguicolors

set wildmenu
set wildmode=longest:full,full

" Use new regular expression engine
set re=0

" Replace tabs with spaces
set tabstop=2
set expandtab
set shiftwidth=2

" Backspace config
set backspace=indent,eol,start

" Show line numbers
set relativenumber
set number

" Highlight search results
set hlsearch

" Syntax highlighting - from the plugin "sainnhe/edge"
colorscheme edge

"------------------------------------------------------------------------------
" ALIASES
"------------------------------------------------------------------------------
:command Q qall
:command W w
:command Wq wqall

"------------------------------------------------------------------------------
" KEY REMAPS
"------------------------------------------------------------------------------
"" LSP from COC
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
" nmap <leader>a  <Plug>(coc-codeaction-cursor)
" inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Display the full file path of the current buffer
nnoremap <leader>w :echo expand('%:p')<CR>

" Switch buffers quickly. This is useful for when you only have a few
" open. Otherwise, using the Telescope mappings below are easier.
nnoremap <leader>n <cmd>bn<cr>
nnoremap <leader>p <cmd>bp<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Use <leader>x to close any buffer (or vim if it is the last buffer)
nnoremap <leader>x :call CloseBufferOrVim()<CR>
nnoremap <leader>m :call ToggleLineNumbers()<CR>

" Markdown Preview
nnoremap <leader>mp <Plug>MarkdownPreviewToggle

"------------------------------------------------------------------------------
" PLUGIN CONFIG - More in init.nvim
"------------------------------------------------------------------------------
" Enable Treesitter Folding
" (the rest of the configuration is in ~/.config/nvim/init.vim)
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufWinEnter * normal! zR

nnoremap <leader>mf :NERDTreeFocus<CR>
nnoremap <leader>mt :NERDTreeToggle<CR>

"------------------------------------------------------------------------------
" FUNCTIONS
"------------------------------------------------------------------------------
function! CloseBufferOrVim()
    let num_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
    if num_buffers == 1
        qall
    else
        bdelete
    endif
endfunction

function! ToggleLineNumbers()
    if &number
      set nonu
      set norelativenumber
    else
      set nu
      set relativenumber
    endif
endfunction
