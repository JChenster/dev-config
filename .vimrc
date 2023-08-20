" ******************************************************************************
" vim essentials
" ******************************************************************************

" source plug ins
so ~/.vim/plugins.vim

" infer filetype
if has('filetype')
  filetype indent plugin on
endif

" syntax highlighting
if has('syntax')
  syntax on
endif

" Indentation settings for using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab

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
map ; :

" entering next line of comment should not continue comment
autocmd BufNewFile,BufRead * set formatoptions-=c formatoptions-=r formatoptions-=o

set noswapfile

" ******************************************************************************
" navigation
" ******************************************************************************

" home row escape
inoremap kj <Esc>

" warp speed
nnoremap J 10j
nnoremap K 10k

" ******************************************************************************
" visuals
" ******************************************************************************

set t_Co=256
colorscheme torte
set number

" highlight column 80
set colorcolumn=80
highlight ColorColumn ctermbg=yellow guibg=yellow

" crosshair
set cursorline
hi CursorLine cterm=none ctermbg=239
set cursorcolumn
hi CursorColumn term=reverse ctermbg=239

" status line
set laststatus=2
set statusline=
set statusline +=%F                             "file path
set statusline +=\ [%{&filetype}]               "file type
set statusline +=\ %m%*                         "modified flag
set statusline +=%=Line:(%4l%*                  "current line
set statusline +=\/%L)%*                        "total lines
set statusline +=%=\ \ \ \ Column:%3v\%*        "virtual column number

" enter to remove highlighting
nnoremap <CR> :noh<CR>

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" highlight search
set hlsearch "Highlights search terms"
set incsearch "Highlights search terms as you type them"

" ******************************************************************************
" formatting
" ******************************************************************************

" highlight trailing whitespace
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" remove trailing whitespace
nnoremap <C-y> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" commenting and uncommenting
autocmd Filetype cpp,go let b:comment_token="//"
autocmd Filetype python,zsh,sh,make let b:comment_token="#"
autocmd Filetype vim let b:comment_token="\""

" ******************************************************************************
" vim essentials
" ******************************************************************************

" source plug ins
so ~/.vim/plugins.vim

" infer filetype
if has('filetype')
  filetype indent plugin on
endif

" syntax highlighting
if has('syntax')
  syntax on
endif

" Indentation settings for using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab

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
map ; :

" entering next line of comment should not continue comment
autocmd BufNewFile,BufRead * set formatoptions-=c formatoptions-=r formatoptions-=o

" ******************************************************************************
" navigation
" ******************************************************************************

" home row escape
inoremap kj <Esc>

" warp speed
nnoremap J 10j
nnoremap K 10k

" ******************************************************************************
" visuals
" ******************************************************************************

set t_Co=256
colorscheme torte
set number

" highlight column 80
set colorcolumn=80
highlight ColorColumn ctermbg=yellow guibg=yellow

" crosshair
set cursorline
hi CursorLine cterm=none ctermbg=239
set cursorcolumn
hi CursorColumn term=reverse ctermbg=239

" status line
set laststatus=2
set statusline=
set statusline +=%F                             "file path
set statusline +=\ [%{&filetype}]               "file type
set statusline +=\ %m%*                         "modified flag
set statusline +=%=Line:(%4l%*                  "current line
set statusline +=\/%L)%*                        "total lines
set statusline +=%=\ \ \ \ Column:%3v\%*        "virtual column number

" enter to remove highlighting
nnoremap <CR> :noh<CR>

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
" highlight search
set hlsearch "Highlights search terms"
set incsearch "Highlights search terms as you type them"

" ******************************************************************************
" formatting
" ******************************************************************************

" highlight trailing whitespace
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" remove trailing whitespace
nnoremap <C-y> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" commenting and uncommenting
autocmd Filetype cpp,go let b:comment_token="//"
autocmd Filetype python,zsh,sh,make let b:comment_token="#"
autocmd Filetype vim let b:comment_token="\""

function! Comment(comment_token)
    execute printf(":substitute/^/%s/e | noh", escape(a:comment_token, '/\'))
endfunction
noremap <C-f> :call Comment(b:comment_token)<CR>

function! Uncomment(comment_token)
    execute printf(":substitute/^%s//e | noh", escape(a:comment_token, '/\'))
endfunction
noremap <C-g> :call Uncomment(b:comment_token)<CR>

" ******************************************************************************
" abbrevs
" ******************************************************************************

func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

" create more abbrevs
autocmd Filetype vim iabbrev <buffer> ;a autocmd Filetype  iabbrev <buffer><ESC>3b1h<c-r>=Eatchar('\s')<CR>

" multi-line comments
autocmd Filetype cpp,c iabbrev <buffer> ;c /*<CR><CR><BS>*/<Up>
autocmd Filetype python iabbrev <buffer> ;c """<CR><CR>"""<Up><ESC><BS>

" print
autocmd Filetype cpp iabbrev <buffer> ;p std::cout <<  << std::endl;<ESC>5b3l<c-r>=Eatchar('\s')<CR>i
autocmd Filetype python iabbrev <buffer> ;p print()<ESC>h

" c style for loop
autocmd Filetype cpp,c iabbrev <buffer> ;f for(int i = 0; i <z; i++) {<CR><CR>}<Esc>?z<CR>xi

" ******************************************************************************
" leader commands
" ******************************************************************************
" set leader
let mapleader = " "

" since we remapped ; -> :
nnoremap <leader>; ;

" buffer stuff
nnoremap <leader>l :ls<CR>
nnoremap <leader>1 :b1<CR>
nnoremap <leader>2 :b2<CR>
nnoremap <leader>3 :b3<CR>
nnoremap <leader>4 :b4<CR>
nnoremap <leader>5 :b5<CR>
nnoremap <leader>6 :b6<CR>
nnoremap <leader>7 :b7<CR>
nnoremap <leader>8 :b8<CR>
nnoremap <leader>9 :b9<CR>

" wrap a long comment across 2 lines (repeat if needed)
autocmd FileType cpp,go nnoremap <leader>w o//k080lF Dj$p
autocmd FileType python,zsh,sh,make nnoremap <leader>w oX#k080lF Dj$p
autocmd FileType vim nnoremap <leader>w oX"k080lF Dj$p

" see local changes
command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dq :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

" re-source vim
nnoremap <leader>s :source ~/.vimrc<CR>:echo "re-sourced vimrc"<CR>
" section comments
function! SectionComment()
    call feedkeys("o# \<Esc>78a*\<Esc>")
endfunction
nnoremap <leader>sc :call SectionComment()<CR>

function! FixSectionComment(comment_token)
    execute printf(":s/\#/%s/e | noh", escape(a:comment_token, '/\'))
endfunction
nnoremap <leader>sf :call FixSectionComment(b:comment_token)<CR>

" truncate all characters after 80 chars
function! TruncateLine()
    if strlen(getline(".")) > 80
        call feedkeys("^81ld$")
    endif
endfunction
nnoremap <leader>t :call TruncateLine()<CR>

" ******************************************************************************
" hype stuff
" ******************************************************************************

highlight UsageSearch cterm=underline

" Highlight the word under the cursor if it is a variable.
let g:usage_highlighting = 0
" I know it seems weird to exclude constants and identifiers but this is just a
" result of how our weird syntax classification works. Variables seem to be the
" only things _not_ identified. Constants and identifiers are something else.
let g:no_highlight_groups=["Statement", "Comment", "Type", "PreProc", "Constant", "Identifier"]
function! s:UsageHighlightUnderCursor()
    let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

    if (index(g:no_highlight_groups, l:syntaxgroup) == -1)
        exe printf('match UsageSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
        let g:usage_highlighting = 1
    else
        if (g:usage_highlighting == 1)
            exe 'match UsageSearch /\V\<\>/'
            let g:usage_highlighting = 0
        endif
    endif
endfunction

autocmd FileType * autocmd CursorMoved * call s:UsageHighlightUnderCursor()

" set shell to interactive so we can use bash aliases
set shellcmdflag=-ic

command! -nargs=+ Grep execute '!gr <args>'
command! -nargs=+ GrepFile execute '!grf <args>'

" Grep for the word under the cursor
nnoremap <leader>g :Grep <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>gf :GrepFile <c-r>=expand("<cword>")<cr><cr>


function! Comment(comment_token)
    execute printf(":substitute/^/%s/e | noh", escape(a:comment_token, '/\'))
endfunction
noremap <C-f> :call Comment(b:comment_token)<CR>

function! Uncomment(comment_token)
    execute printf(":substitute/^%s//e | noh", escape(a:comment_token, '/\'))
endfunction
noremap <C-g> :call Uncomment(b:comment_token)<CR>

" ******************************************************************************
" abbrevs
" ******************************************************************************

func! Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

" create more abbrevs
autocmd Filetype vim iabbrev <buffer> ;a autocmd Filetype  iabbrev <buffer><ESC>3b1h<c-r>=Eatchar('\s')<CR>

" multi-line comments
autocmd Filetype cpp,c iabbrev <buffer> ;c /*<CR><CR><BS>*/<Up>
autocmd Filetype python iabbrev <buffer> ;c """<CR><CR>"""<Up><ESC><BS>

" print
autocmd Filetype cpp iabbrev <buffer> ;p std::cout <<  << std::endl;<ESC>5b3l<c-r>=Eatchar('\s')<CR>i
autocmd Filetype python iabbrev <buffer> ;p print()<ESC>h

" c style for loop
autocmd Filetype cpp,c iabbrev <buffer> ;f for(int i = 0; i <z; i++) {<CR><CR>}<Esc>?z<CR>xi

" ******************************************************************************
" leader commands
" ******************************************************************************
" set leader
let mapleader = " "

" since we remapped ; -> :
nnoremap <leader>; ;

" buffer stuff
nnoremap <leader>l :ls<CR>
nnoremap <leader>1 :b1<CR>
nnoremap <leader>2 :b2<CR>
nnoremap <leader>3 :b3<CR>
nnoremap <leader>4 :b4<CR>
nnoremap <leader>5 :b5<CR>
nnoremap <leader>6 :b6<CR>
nnoremap <leader>7 :b7<CR>
nnoremap <leader>8 :b8<CR>
nnoremap <leader>9 :b9<CR>

" see local changes
command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dq :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

" set shell to interactive so we can use bash aliases
set shellcmdflag=-ic

command! -nargs=+ Grep execute '!gr <args>'
command! -nargs=+ GrepFile execute '!grf <args>'

" Grep for the word under the cursor
nnoremap <leader>g :Grep <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>gf :GrepFile <c-r>=expand("<cword>")<cr><cr>

" insert new line below / above without leaving normal mode
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j

" re-source vim
nnoremap <leader>s :source ~/.vimrc<CR>:echo "re-sourced vimrc"<CR>
" section comments
function! SectionComment()
    call feedkeys("o# \<Esc>78a*\<Esc>")
endfunction
nnoremap <leader>sc :call SectionComment()<CR>

function! FixSectionComment(comment_token)
    execute printf(":s/\#/%s/e | noh", escape(a:comment_token, '/\'))
endfunction
nnoremap <leader>sf :call FixSectionComment(b:comment_token)<CR>

" truncate all characters after 80 chars
function! TruncateLine()
    if strlen(getline(".")) > 80
        call feedkeys("^81ld$")
    endif
endfunction
nnoremap <leader>t :call TruncateLine()<CR>

" wrap a long comment across 2 lines (repeat if needed)
autocmd FileType cpp,go nnoremap <leader>w o//k080lF Dj$p
autocmd FileType python,zsh,sh,make nnoremap <leader>w oX#k080lF Dj$p
autocmd FileType vim nnoremap <leader>w oX"k080lF Dj$p

" ******************************************************************************
" hype stuff
" ******************************************************************************

highlight UsageSearch cterm=underline

" Highlight the word under the cursor if it is a variable.
let g:usage_highlighting = 0
" I know it seems weird to exclude constants and identifiers but this is just a
" result of how our weird syntax classification works. Variables seem to be the
" only things _not_ identified. Constants and identifiers are something else.
let g:no_highlight_groups=["Statement", "Comment", "Type", "PreProc", "Constant", "Identifier"]
function! s:UsageHighlightUnderCursor()
    let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

    if (index(g:no_highlight_groups, l:syntaxgroup) == -1)
        exe printf('match UsageSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
        let g:usage_highlighting = 1
    else
        if (g:usage_highlighting == 1)
            exe 'match UsageSearch /\V\<\>/'
            let g:usage_highlighting = 0
        endif
    endif
endfunction

autocmd FileType * autocmd CursorMoved * call s:UsageHighlightUnderCursor()

" git hype
