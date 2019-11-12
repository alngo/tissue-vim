let s:api_url = "https://api.github.com"

function! interfaces#github#Authentication()
	let cmd = "curl -u " . g:tissue_username . ' ' . s:api_url . "/user"
	echo "Enter host password for user " . "'" . g:tissue_username . "':"
	let res = system(cmd)
	"let g:tissue_authenticated = 1
endfunction
