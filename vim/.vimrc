set nocompatible
filetype off
set rtp+=~/.local/share/vim/
set rtp+=~/.local/share/vim/after

" Load vim-plug
if empty(glob("~/.local/share/vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/vim/plugged')
"Plug 'SirVer/ultisnips'
Plug 'bling/vim-bufferline'
Plug 'itchyny/lightline.vim'
"Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'AndrewRadev/linediff.vim'
call plug#end()

" Vim settings
"packloadall
filetype plugin indent on
syntax on
"set noshowmode
set virtualedit=all
set autoindent
set smartindent
set smartcase
set showmatch
set tabstop=4
set shiftwidth=4
set number relativenumber
set backspace=indent,eol,start
set path+=**
set background=dark
set t_Co=256
set undofile
set viminfo+=n~/.cache/vim/viminfo
set undodir=~/.cache/vim/undo
set spelllang=it,en_us
if system('uname -s') == "Darwin\n"
  "OSX
  set clipboard=unnamed 
else
  "Linux
  set clipboard=unnamedplus
endif
set encoding=UTF-8
set mouse=a
set hls
set incsearch
" fancy cmdline completion
set wildmenu

"inoremaps
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"cnoremap
"sudo edit
cnoremap w!!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!

"remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" netrw
let g:netrw_home=$XDG_CACHE_HOME.'/vim'

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'modified'],
      \             [ 'bufferline'] ]
      \ },
      \ 'component': {
      \   'bufferline': '%{bufferline#refresh_status()}%{g:bufferline_status_info.before}%#TabLineSel#%{g:bufferline_status_info.current}%#LightLineLeft_active_3#%{g:bufferline_status_info.after}'
      \ }
  \ }

"bufferline
let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''

"vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_view_use_temp_files = 1
let g:vimtex_compiler_latexmk = {
	\ 'build_dir' : 'build',
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

"ultrasnip
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=[$XDG_DATA_HOME . "/vim/ultisnips"]

"NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

function! OscCopy()
	let encodedText=@"
	let encodedText=substitute(encodedText, '\', '\\\\', "g")
	let encodedText=substitute(encodedText, "'", "'\\\\''", "g")
	let executeCmd="echo -n '".encodedText."' | base64 | tr -d '\\n'"
	let encodedText=system(executeCmd)
	if $TMUX != ""
		"tmux
		let executeCmd='echo -en "\x1bPtmux;\x1b\x1b]52;;'.encodedText.'\x1b\x1b\\\\\x1b\\" > /dev/tty'
	else
		let executeCmd='echo -en "\x1b]52;;'.encodedText.'\x1b\\" > /dev/tty'
	endif
	call system(executeCmd)
	redraw!
endfunction
command! OscCopy :call OscCopy()

