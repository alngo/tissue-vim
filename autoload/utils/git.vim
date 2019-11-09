function! utils#git#getRemoteURL(target)
	let cmd = "git remote -v |" . "grep " . a:target . "| head -n 1"
	let url = system(cmd)
	let url = substitute(url, a:target . ".*(http://.*) .*", "\1", '')
	return url
endfunction
