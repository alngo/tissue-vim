function! python#py#init()
	if g:tissue_python == 1
		exe 'py3file ' . escape(g:plugin_path, ' ') . '/python/github.py'
		"exe 'py3file ' . escape(g:plugin_path, ' ') . '/python/gitlab.py'
	elseif g:tissue_python == 0
		exe 'pyfile ' . escape(g:plugin_path, ' ') . '/python/github.py'
		"exe 'pyfile ' . escape(g:plugin_path, ' ') . '/python/gitlab.py'
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

function python#py#listIssues(res)
	let l:res = a:res
	if g:tissue_python == 1
		python3 listIssues()
	elseif g:tissue_python == 0
		python listIssues()
	endif
endfunction
