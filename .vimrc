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

" imports
autocmd Filetype cpp,c iabbrev <buffer> ;i #include
autocmd Filetype python iabbrev <buffer> ;i import

" print
autocmd Filetype cpp iabbrev <buffer> ;p std::cout <<  << std::endl;<ESC>5b3l<c-r>=Eatchar('\s')<CR>
autocmd Filetype python iabbrev <buffer> ;p print()<ESC>h

" for loops
autocmd Filetype cpp,c iabbrev <buffer> ;f for(int i = 0; i <z; i++) {<CR><CR>}<Esc>?z<CR>x
autocmd Filetype python iabbrev <buffer> ;f for i in range():<ESC>hh

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

" holy grail of alignment
" automatically split a function's args onto separate lines
" and align them with the first arg
function! Align()
    let next_arg='^f,lr'
    let linebreak="\<CR>"

    " find the second arg and insert line break
    :call feedkeys(next_arg)
    :call feedkeys(linebreak)

    " line up the second arg with the first
    :call feedkeys('^k^jd^^"ay$k^"by$j$p^vkf,F(jr ^d$"ap^')

    " find the next args and insert line break
    " repeat 20 times (works for up to 20 args)
    let i = 0
    while i < 20
        call feedkeys(next_arg)
        call feedkeys(linebreak)
        let i += 1
    endwhile
endfunction
nnoremap <leader>a :call Align()<CR>

" backspace into previous line
nnoremap <leader>b ^d0i<BS><ESC>

" MAC ONLY
" holy grail copy and paste
vmap <leader>c :w !pbcopy<CR><CR>
nmap <leader>c :w !pbcopy<CR><CR>
map <leader>p :r !pbpaste<CR>

" commenting and uncommenting
autocmd Filetype cpp,go let b:comment_token="//"
autocmd Filetype python,zsh,sh,make let b:comment_token="#"
autocmd Filetype vim let b:comment_token="\""

function! Comment(comment_token)
    execute printf(":substitute/^/%s/e | noh", escape(a:comment_token, '/\'))
endfunction
noremap <leader>co :call Comment(b:comment_token)<CR>

function! Uncomment(comment_token)
    execute printf(":substitute/^%s//e | noh", escape(a:comment_token, '/\'))
endfunction
noremap <leader>u :call Uncomment(b:comment_token)<CR>

" see local changes
command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <leader>do :DiffOrig<cr>
nnoremap <leader>dq :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

" execute current file
autocmd FileType python nnoremap <leader>e :!python3 <C-r>%<CR>
autocmd FileType sh nnoremap <leader>e :!./<C-r>%<CR>

" find word under cursor
nnoremap <leader>f :execute printf('/%s', escape(expand("<cword>"), '/\'))<CR>

" use grep aliases
let $BASH_ENV = "~/.portable_aliases"

command! -nargs=+ Grep execute '!gr <args>'
command! -nargs=+ GrepFile execute '!grf <args>'

" Grep for the word under the cursor
nnoremap <leader>g :Grep <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>gf :GrepFile <c-r>=expand("<cword>")<cr><cr>

" git stuff
nnoremap <leader>gd :!git diff <C-r>%<CR>
nnoremap <leader>gs :!git status<CR>

" add space to visual selection
vnoremap <leader><leader> : norm I <CR>
" repeat that
nmap <leader>. gv  <CR>

" insert new line below / above without leaving normal mode
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j

" re-source vim
nmap <leader>s :source ~/.vimrc<CR><CR>:echo "re-sourced vimrc"<CR>
" section comments
function! SectionComment()
    call feedkeys("o# \<Esc>78a*\<Esc>")
endfunction
nnoremap <leader>sc :call SectionComment()<CR>

function! FixSectionComment(comment_token)
    execute printf(":s/\#/%s/e | noh", escape(a:comment_token, '/\'))
endfunction
nnoremap <leader>sf :call FixSectionComment(b:comment_token)<CR>

" easily toggle spellcheck
nnoremap <leader>sp :set spell!<CR>

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
