" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    tissue.vim                                         :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: alngo <alngo@student.42.fr>                +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2019/10/31 17:58:56 by alngo             #+#    #+#              "
"    Updated: 2019/11/02 18:19:12 by alngo            ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" ============================================================================
" File: tissue.vim
" Description: vim global plugin for issues managment on github
" Maintainer: alngo <alngo@student.42.fr>
" License: -license
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

if !has('python') && !has('python3')
	function! s:TissueRequirePython()
		echohl "Error: Required vim compiled with +python or +python3"
	endfunction
	command! -nargs=0 TissueToggle call s:TissueRequirePython()
	finish
endif

let g:loaded_tissue = 1

command! -nargs=0 TissueToggle call tissue#TissueToggle()
