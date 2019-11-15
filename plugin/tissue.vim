" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    tissue.vim                                         :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: alngo <alngo@student.42.fr>                +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2019/10/31 17:58:56 by alngo             #+#    #+#              "
"    Updated: 2019/11/15 08:40:45 by alngo            ###   ########.fr        "
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

if !exists("g:tissue_python")
	if has("python")
		let g:tissue_python = 0
	elseif has("python3")
		let g:tissue_python = 1
	else
		let g:tissue_python = -1
		function! s:TissueRequirePython()
			echohl "Error: Required vim compiled with +python or +python3"
		endfunction
		command! -nargs=0 TissueToggle call s:TissueRequirePython()
		finish
	endif
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

if !exists("g:tissue_username")
	let g:tissue_username = utils#git#getUsername()
endif

if !exists("g:tissue_reposname")
	let g:tissue_reposname = utils#git#getReposname(g:tissue_target)
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

let g:loaded_tissue = 1

command! -nargs=0 TissueToggle call tissue#TissueToggle()
