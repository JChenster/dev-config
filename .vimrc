" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" visuals
set t_Co=256
colorscheme torte
set number
" highlight column 80
set colorcolumn=80
highlight ColorColumn ctermbg=yellow guibg=yellow
" highlight current pos
set cursorline
highlight CursorLine cterm=NONE ctermbg=cyan ctermfg=black guibg=gray guifg=black
set cursorcolumn
highlight CursorColumn cterm=NONE ctermbg=cyan ctermfg=black guibg=gray guifg=black
" status line
set laststatus=2
set statusline +=%F                     "file path
set statusline +=\ %m%*                 "modified flag
set statusline +=%=\ Line:(%4l%*        "current line
set statusline +=\/%L)%*                "total lines
set statusline +=\ Column:%4v\%*        "virtual column number
set relativenumber

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" highlight trailing whitespace
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" remove trailing whitespace
nnoremap <C-y> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" highlight search
set hlsearch "Highlights search terms"
set incsearch "Highlights search terms as you type them"
" enter to remove highlighting
nnoremap <CR> :noh<CR>

" enable use of the mouse for all modes
if has('mouse')
  set mouse=a
endif

" copies the currently selected text to the system clipboard (OSX)
let @c = ':w !pbcopy'
let @p = ':r !pbpaste'

" set leader
let mapleader = "\\"

" semicolon -> colon
nnoremap <leader>; ;
map ; :
