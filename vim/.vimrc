set nocompatible

function! CreateDirIfNotExists(dir)
	if !isdirectory(a:dir)
		call mkdir(a:dir,"p")
	endif
endfunction

function! TouchFileIfNotExists(file)
	if !filereadable(a:file)
		call writefile([], a:file)
	endif
endfunction

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
nnoremap <C-k> :call OscCopy()<CR>

filetype off
call CreateDirIfNotExists($HOME . "/.local/share/vim/after")
set rtp+=~/.local/share/vim/
set rtp+=~/.local/share/vim/after

" Load vim-plug
if empty(glob("~/.local/share/vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/vim/plugged')
Plug 'bling/vim-bufferline'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/gv.vim'
Plug 'preservim/nerdtree'
Plug 'AndrewRadev/linediff.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'ajh17/vimcompletesme'
Plug 'hotwatermorning/auto-git-diff'
call plug#end()

" Vim settings
"packloadall
filetype plugin indent on
syntax on
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
call TouchFileIfNotExists($XDG_CACHE_HOME . "/vim/viminfo")
set viminfo+=n~/.cache/vim/viminfo
call CreateDirIfNotExists($XDG_DATA_HOME . "/vim/undo/")
let &undodir=$XDG_DATA_HOME . "/vim/undo/"
set spelllang=it,en_us
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed 
else
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

"NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"fzf
nnoremap <silent> <C-p> :Files<CR>

"clangd
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif
