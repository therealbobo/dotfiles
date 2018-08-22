"execute pathogen#infect()
" autocmd vimenter * NERDTree

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-bufferline'
Plugin 'xolox/vim-misc'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/ZoomWin'
Plugin 'fatih/vim-go'
Plugin 'ryanoasis/vim-devicons'

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


"inoremaps
	inoremap jk <ESC>
	inoremap JK <ESC>


"nmap
	nmap <F8> :TagbarToggle<CR>
	nmap <F9> :NERDTreeToggle<CR>
	nmap <F7> :SyntasticCheck<CR>
	nmap <S-F7> :SyntasticReset<CR>


"statusline
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*


"syntastic
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1
	let g:syntastic_check_on_open = 0
	let g:syntastic_check_on_wq = 0
	let g:syntastic_java_javac_classpath = "/home/robi/vim_workspace/**"
	" let g:syntastic_error_symbol = "✗"
	" let g:syntastic_warning_symbol = "⚠"


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
