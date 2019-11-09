function! utils#git#getRemoteURL(target)
	let l:command = "git remote -v |" . "grep " . a:target . "| head -n 1"
	let l:url = system(l:command)
	let l:url = substitute(l:url, a:target . ".*(http://.*) .*", "\1", '')
	return l:url
endfunction
