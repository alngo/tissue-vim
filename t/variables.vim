source t/helpers/setup.vim

describe 'default variables'
	it 'tissue_api should match github'
		echohl g:tissue_url	
		Expect g:tissue_api == "github"
	end
	it 'tissue_python should match 1'
		Expect g:tissue_python == 1
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
	it 'tissue_username should match {username}'
		Expect g:tissue_status_line == ${username}
	end
	it 'tissue_authentication should match 0'
		Expect g:tissue_status_line == 0
	end
end
