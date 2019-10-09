setlocal spell
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

let cwd = getcwd()
	"let isGitPresent = system('ls | grep -q .git')
"if v:shell_error == 1
"	silent !git show -q --format=short
"endif
