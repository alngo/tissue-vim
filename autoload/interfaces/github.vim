let s:api_url = "https://api.github.com"

function! interfaces#github#Authentication()
	let cmd = "!curl -u " . g:tissue_username . ' ' . s:api_url . "/user"
	call debug#log#echom(cmd)
	exe cmd
endfunction
