function! python#py#init()
	if g:tissue_python == 1
		exe 'py3file ' . escape(g:plugin_path, ' ') . '/python/github.py'
	elseif g:tissue_python == 0
		exe 'pyfile ' . escape(g:plugin_path, ' ') . '/python/github.py'
	endif
endfunction

function python#py#checkAuth(res)
	let l:res = a:res
	if g:tissue_python == 1
		python3 checkAuth()
	elseif g:tissue_python == 0
		python checkAuth()
	endif
endfunction


function python#py#getIssues(res)
	let l:res = a:res
	if g:tissue_python == 1
		python3 checkIssues()
	elseif g:tissue_python == 0
		python checkTsse	()
	endif
