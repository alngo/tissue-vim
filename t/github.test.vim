source t/helpers/setup.vim

describe 'github authentification'
	it 'tissue_authenticated should match 0'
		let l:res = '{"message": "Bad credentials"}'
		if g:tissue_python == 1
			python3 checkAuth()
		elseif g:tissue_python == 0
			python checkAuth()
		endif
		Expect g:tissue_authenticated == 0
	end

	it 'tissue_authenticated should match 1'
		let l:res = '{"login": "userlogin"}'
		if g:tissue_python == 1
			python3 checkAuth()
		elseif g:tissue_python == 0
			python checkAuth()
		endif
		Expect g:tissue_authenticated == 1
	end
end
