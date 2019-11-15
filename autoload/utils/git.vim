function! utils#git#getRemoteURL(target)
	let cmd = "git remote -v |" . "grep " . a:target . "| head -n 1"
	let url = system(cmd)
	let url = matchstr(url, "https://.*.git")
	return url
endfunction

function! utils#git#getUsername()
	let username = system("git config user.name | head -n 1")
	return trim(username)
endfunction

function! utils#git#getReposname(target)
	let remote_url = utils#git#getRemoteURL(a:target)
	let cmd = "echo " . remote_url . " | rev | cut -d '/' -f1 | rev | cut -d '.' -f1"
	let reposname = system(cmd)
	return trim(reposname)
endfunction
