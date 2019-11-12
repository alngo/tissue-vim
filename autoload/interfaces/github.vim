let s:api_url = "https://api.github.com"

function! interfaces#github#Authentication()
	let cmd = "!curl -u " . g:tissue_username . ' ' . s:api_url . "/user"
	exe cmd
	let g:tissue_authenticated = 1
endfunction
