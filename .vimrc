" Tyler Green
" .vimrc

" Set search highlight color
hi Search ctermfg=Black ctermbg=Yellow

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" Syntax highlighting
syntax on
colorscheme desert

" Replace tabs with spaces
set tabstop=2
set expandtab
set shiftwidth=2

" Show line numbers
set nu

" Highlight search results
set hlsearch

" Enable auto-indent
set autoindent

" Always show status line
set laststatus=2

" Status line setup
if has('statusline')
  set statusline=%#Question#                   " set highlighting
  set statusline+=%-2.2n\                      " buffer number
  set statusline+=%#WarningMsg#                " set highlighting
  set statusline+=%f\                          " file name
  set statusline+=%#Question#                  " set highlighting
  set statusline+=%h%m%r%w\                    " flags
  set statusline+=%{strlen(&ft)?&ft:'none'},   " file type
  set statusline+=%{(&fenc==\"\"?&enc:&fenc)}, " encoding
  set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")} " BOM
  set statusline+=%{&fileformat},              " file format
  set statusline+=%{&spelllang},               " language of spelling checker
  set statusline+=%{SyntaxItem()}              " syntax highlight group under cursor
  set statusline+=%=                           " ident to the right
  set statusline+=0x%-8B\                      " character code under cursor
  set statusline+=%-7.(%l,%c%V%)\ %<%P         " cursor position/offset
endif

" Aliases
:command Q q
:command W w
