"execute pathogen#infect()
" autocmd vimenter * NERDTree

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/ZoomWin'
Plugin 'ryanoasis/vim-devicons'
"Latex plugins
Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'

call vundle#end()
filetype plugin indent on

"vim settings
	set autoindent
	set smartindent
	"set nu
	set number relativenumber
	set showmatch
	syntax on
	set backspace=indent,eol,start
	set path+=**
	set list lcs=tab:\|\ 
	set background=dark
	set t_Co=256
	set undofile
	set undodir=~/.vim/undodir


"inoremaps
	inoremap jk <ESC>
	inoremap JK <ESC>


"nmap
"nmap <F8> :TagbarToggle<CR>
	nmap <F9> :NERDTreeToggle<CR>
	nmap <F7> :SyntasticCheck<CR>
	nmap <S-F7> :SyntasticReset<CR>

"cnoremap
	cnoremap w!!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!

"remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


"statusline
"	set statusline+=%#warningmsg#
"	set statusline+=%{SyntasticStatuslineFlag()}
"	set statusline+=%*


let g:bufferline_echo=0


"airline
	let g:airline#extensions#bufferline#enabled = 1
	let g:airline_powerline_fonts=1
	" let g:airline_solarized_db='dark'
	let g:airline_theme='luna'
	" let g:airline#extensions#tabline#enabled=1
	let g:airline#extensions#tabline#show_splits = 1 "enable/disable displaying open splits per tab (only when tabs are opened). >
	let g:airline#extensions#tabline#show_buffers = 1 " enable/disable displaying buffers with a single tab
	let g:airline#extensions#tabline#tab_nr_type = 1 " tab number


"vim-devincos
	set encoding=UTF-8


"vimtex
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
	set conceallevel=1
	let g:tex_conceal='abdmg'
"ultrasnip
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsJumpForwardTrigger = '<tab>'
	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'


"system clipboard
	set clipboard=unnamedplus
