let s:api_url = "https://api.github.com"

if g:tissue_python == 1
	exe 'py3file ' . escape(g:plugin_path, ' ') . '/apis/github.py'
elseif g:tissue_python == 0
	exe 'pyfile ' . escape(g:plugin_path, ' ') . '/apis/github.py'
endif

function! apis#github#Authentication()
	let cmd = "curl -u " . g:tissue_username . ' ' . s:api_url . "/user"
	echo "Enter host password for user " . "'" . g:tissue_username . "':"
	let l:res = system(cmd)
	if g:tissue_python == 1
		python3 checkAuthentification()
	elseif g:tissue_python == 0
		python checkAuthentification()
	endif
endfunction
