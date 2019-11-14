let s:api_url = "https://api.github.com"

function! apis#github#Authentication()
	let cmd = "curl -u " . g:tissue_username . ' ' . s:api_url . "/user"
	echo "Enter host password for user " . "'" . g:tissue_username . "':"
	let res = system(cmd)
	call python#py#checkAuth(res, "github")
endfunction
