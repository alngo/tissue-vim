source t/helpers/setup.vim

describe 'default variables'
	if executable('git') < 1
		SKIP 'Git is not available.'
	endif

	it 'tissue_target should match origin'
		Expect g:tissue_target == "origin"
	end
	it 'tissue_api should match '
		Expect g:tissue_api == "github"
	end
	it 'tissue_width should match 60'
		Expect g:tissue_width == 60
	end
	it 'tissue_buf_name should match __tissue__'
		Expect g:tissue_buf_name == "__tissue__"
	end
	it 'tissue_status_line should match 1'
		Expect g:tissue_status_line == 1
	end
	it 'tissue_username should match username'
		let l:username = system("git config user.name | head -n 1")
		Expect g:tissue_username == l:username
	end
	it 'tissue_authentication should match 1'
		Expect g:tissue_authentication == 1
	end
	it 'tissue_authenticated should match 0'
		Expect g:tissue_authenticated == 0
	end
end
