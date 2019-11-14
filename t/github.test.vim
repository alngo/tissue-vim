source t/helpers/setup.vim

describe 'github authentification'
	it 'tissue_authenticated should match 0'
		let l:res = '{"message": "Bad credentials"}'
		python3 checkAuthentification()
		Expect g:tissue_authenticated == 0
	end

	it 'tissue_authenticated should match 1'
		let l:res = '{"login": "userlogin"}'
		python3 checkAuthentification()
		Expect g:tissue_authenticated == 1
	end
end
