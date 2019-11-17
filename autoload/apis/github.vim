let s:api_url = "https://api.github.com"

function! apis#github#Authentication()
	let cmd = "curl --silent -u " . g:tissue_username . ' ' . s:api_url . "/user"
	echo "Enter host password for user " . "'" . g:tissue_username . "':"
	let res = utils#curl#handleRes(system(cmd))
	call python#py#checkAuth(res)
endfunction

" GET method
function! apis#github#getIssues()
	let cmd = "curl --silent --request GET --url '" . s:api_url . "/repos/" . g:tissue_username . "/" . g:tissue_reposname . "/issues?page=" . g:tissue_page . "&per_page=" . g:tissue_per_page . "&state=" . g:tissue_state . "'"
	let res = utils#curl#handleRes(system(cmd))
	call pythons#py#getIssues()
endfunction
