function! utils#curl#handleRes(res)
	let res = matchstr(a:res, '{.*}')
	return res
endfunction
