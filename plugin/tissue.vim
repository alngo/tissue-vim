" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    tissue.vim                                         :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: alngo <alngo@student.42.fr>                +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2019/10/31 17:58:56 by alngo             #+#    #+#              "
"    Updated: 2019/11/09 12:07:29 by alngo            ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" ============================================================================
" File: tissue.vim
" Description: vim global plugin for issues managment on github
" Maintainer: alngo <alngo@student.42.fr>
" License: MIT License
" ============================================================================

if exists('g:loaded_tissue') || &cp
  finish
endif

if v:version < '801'
	function! s:TissueRequireVim8()
		echohl "Tissue unavailable: require Vim 8.1+"
	endfunction
	command! -nargs=0 TissueToggle call s:TissueRequireVim8()
	finish
endif

if executable('git') < 1
	function! s:TissueNoGit()
		echohl "Tissue unavailable: require a git"
	endfunction
	command! -nargs=0 TissueToggle call s:TissueNoGit()
	finish
endif

if !exists("g:tissue_target")
	let g:tissue_target = "origin"
endif

if !exists("g:tissue_api")
	let g:tissue_url = utils#git#getRemoteURL(g:tissue_target)
	if match(g:tissue_url, "github") != -1
		let g:tissue_api = "github"
	elseif match(g:tissue_url, "gitlab") != -1
		let g:tissue_api = "gitlab"
	else
		let g:tissue_api = ""
		function! s:TissueNoRepository()
			echom "Tissue unavailable: require a github repository+"
		endfunction
		command! -nargs=0 TissueToggle call s:TissueNoRepository()
		finish
	endif
endif

if !exists("g:tissue_username")
	let g:tissue_username = system("git config user.name | head -n 1")
endif

let g:loaded_tissue = 1

command! -nargs=0 TissueToggle call tissue#TissueToggle()
