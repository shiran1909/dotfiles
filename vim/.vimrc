" Set compatibility to vim only
set nocompatible

" Always show current positon
set ruler

" Turn on syntax highlighting
syntax on
filetype plugin indent on

" Colorscheme
set background=dark
colorscheme nord
let g:one_allow_italics=1

" Enable italicised comments in vim
highlight Comment cterm=italic

" Turn off modelines
set modelines=0

" hightlight search and ignore and smart case when searching
set hlsearch
set ignorecase
set smartcase
set incsearch

" set the max textwidth
" set textwidth=80

" set tab width
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noshiftround
set smarttab

" make tab into space
set expandtab

" auto indent
set autoindent
set smartindent
set cindent

" Don't redraw while executing macros
set lazyredraw

" for regular expressions turn magic on
set magic

" Display 5 lines above/bellow the cursor when scrolling with a mouse
set scrolloff=5

" show and highlight matching pairs of brackets
set matchpairs+=<:>

" display different types of white spaces
set list
set listchars=tab:>\ ,trail:*,extends:#,nbsp:.
" Show line number
set number relativenumber

" automatic toggling between line number modes
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

highlight LineNr ctermfg=green
" highlight CursorLineNr ctermbg=black ctermfg=white cterm=bold

" key map
inoremap jk  <ESC>

" set status line display
set laststatus=2
hi StatusLine ctermfg=NONE ctermbg=red cterm=NONE
hi StatusLineNC ctermfg=black ctermbg=red cterm=NONE
hi User1 ctermfg=NONE ctermbg=red
hi User2 ctermfg=black ctermbg=blue
" hi User3 ctermfg=black ctermbg=blue
" hi User4 ctermfg=black ctermbg=cyan

" set statusline+=		" Padding
" set statusline=%=%1* 		" Switch to right-side
" set statusline+=\ \ 		" Padding
" set statusline+=%f 			" Path to the file (short)
" set statusline+=\ %2*\ 		" Padding & switch colour
" set statusline+=%l 		    " Current line
" set statusline+=\  		    " Padding
" set statusline+=of		    " of text
" set statusline+=\  		    " Padding
" set statusline+=%L 		    " Current line
" set statusline+=\  		    " Padding

set statusline=%F%m%r%h%w%=\ [ft=%Y]\ %{\"[fenc=\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}\ [ff=%{&ff}]\ [asc=%03.3b]\ [hex=%02.2B]\ [pos=%04l,%04v][%p%%]\ [lines=%L]

" Encoding
set encoding=utf-8

" fix common backspace problems
set backspace=indent,eol,start

" toggling fcitx between en and zh
let g:input_toggle=1
function! Fcitx2en()
    let s:input_status=system("fcitx-remote")
    if s:input_status==2
        let g:input_toggle=1
        let l:a=system("fcitx-remote -c")
    endif
endfunction

function! Fcitx2zh()
    let s:input_status=system("fcitx-remote")
    if s:input_status!=2 && g:input_toggle==1
        let l:a=system("fcitx-remote -o")
        let g:input_toggle=0
    endif
endfunction

set ttimeoutlen=150
autocmd InsertLeave * call Fcitx2en()

" auto complete
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
"inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

function CloseBracket()
    if match(getline(line('.') + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endfunction

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col -2] == "\\"
        return a:char
    elseif line[col -1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
    endif
endfunction
