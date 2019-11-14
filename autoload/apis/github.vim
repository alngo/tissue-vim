let s:api_url = "https://api.github.com"

exe 'py3file ' . escape(g:plugin_path, ' ') . '/apis/github.py'

function! apis#github#Authentication()
	let cmd = "curl -u " . g:tissue_username . ' ' . s:api_url . "/user"
	echo "Enter host password for user " . "'" . g:tissue_username . "':"
	let l:res = system(cmd)
	python3 checkAuthentification()
endfunction
