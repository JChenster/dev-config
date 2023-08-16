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

" nav stuff
inoremap kj <Esc>
nnoremap J 10j
nnoremap K 10k

" visuals
set t_Co=256
colorscheme torte
set number
" highlight column 80
set colorcolumn=80
highlight ColorColumn ctermbg=yellow guibg=yellow
" highlight current pos
set cursorline
highlight CursorLine cterm=NONE ctermbg=gray ctermfg=black guibg=gray guifg=black
set cursorcolumn
highlight CursorColumn cterm=NONE ctermbg=gray ctermfg=black guibg=gray guifg=black
" status line
set laststatus=2
set statusline=
set statusline +=%F                             "file path
set statusline +=\ [%{&filetype}]               "file type
set statusline +=\ %m%*                         "modified flag
set statusline +=%=Line:(%4l%*                  "current line
set statusline +=\/%L)%*                        "total lines
set statusline +=%=\ \ \ \ Column:%3v\%*        "virtual column number

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

" MAC ONLY
" holy grail copy and paste
vmap <C-c> :w !pbcopy<CR><CR>
nmap <C-c> :w !pbcopy<CR><CR>
map <C-p> :r !pbpaste<CR>

" semicolon -> colon
nnoremap <leader>; ;
map ; :

" commenting and uncommenting
autocmd Filetype cpp,go let b:comment_token="//"
autocmd Filetype python,zsh,sh,make let b:comment_token="#"
autocmd Filetype vim let b:comment_token="\""
noremap <C-f> :call Comment(b:comment_token)<CR>
noremap <C-g> :call Uncomment(b:comment_token)<CR>

function! Comment(comment_token)
    execute printf(":substitute/^/%s/e | noh", escape(a:comment_token, '/\'))
endfunction

function! Uncomment(comment_token)
    execute printf(":substitute/^%s//e | noh", escape(a:comment_token, '/\'))
endfunction

" abbrevs
func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc
" multi-line c comment
iabbrev com /*<CR><CR>*/<Up>
" print statements
iabbrev ;c std::cout <<  << std::endl;<esc>5b3l<c-r>=Eatchar('\s')<CR>
" c style for loop
:iabbrev forii for(let i = 0; i <z; i++) {<CR><CR>}<Esc>?z<CR>xi

" ******************************************************************************
" LEADER COMMANDS
" ******************************************************************************
" set leader
let mapleader = " "

" see local changes
command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dq :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

nnoremap <leader>s :source ~/.vimrc<CR>

" source plug ins
so ~/.vim/plugins.vim
