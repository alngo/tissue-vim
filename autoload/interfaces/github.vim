let s:api_url = "http://api.github.com"

function! interfaces#github#Authentication()
	let l:basic_authentication = "!curl -u " . g:tissue_username . " " . s:api_url . "/user"
	let res = system(l:basic_authentication)
	debug#log#echom(res);

endfunction
