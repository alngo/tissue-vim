let s:api_url = "http://api.github.com"

function! interface#github#Authentication()
	exe "!curl -u" . g:tissue_username . s:api_url . "/user"
endfunction
