let s:api_url = "http://api.github.com"

function! interfaces#github#Authentication()
	exe "!curl -u " . g:tissue_username . " " . s:api_url . "/user"
endfunction
