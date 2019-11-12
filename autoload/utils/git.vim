function! utils#git#getRemoteURL(target)
	let cmd = "git remote -v |" . "grep " . a:target . "| head -n 1"
	let url = system(cmd)
	let url = substitute(url, "\s(https://.*)\s", "\1", '')
	return url
endfunction

function! utils#git#getUsername()
	let username = system("git config user.name | head -n 1")
	return trim(username)
endfunction
