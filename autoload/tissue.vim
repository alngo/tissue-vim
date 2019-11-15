" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    tissue.vim                                         :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: alngo <alngo@student.42.fr>                +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2019/10/31 18:03:34 by alngo             #+#    #+#              "
"    Updated: 2019/11/15 09:14:22 by alngo            ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

" ============================================================================
" File: tissue.vim
" Description: vim global plugin for issues managment on github
" Maintainer: alngo <alngo@student.42.fr>
" License: MIT License
" ============================================================================

"{{{ 	Initialization
scriptencoding = utf-8

let g:plugin_path = escape(expand('<sfile>:p:h'), '\')

if !exists("g:tissue_width")
	let g:tissue_width = 60
endif
if !exists("g:tissue_buf_name")
	let g:tissue_buf_name ="__tissue__"
endif
if !exists("g:tissue_status_line")
	let g:tissue_status_line = 1
endif
if !exists("g:tissue_authentication")
	let g:tissue_authentication = 0
	let g:tissue_authenticated = 0
	if get(g:, "tissue_username", "null") != "null"
		let g:tissue_authentication = 1
		let g:tissue_authenticated = 0
	endif
endif
if !exists("g:tissue_page")
	let g:tissue_page = 0
endif
if !exists("g:tissue_per_page")
	let g:tissue_per_page = 10
endif
if !exists("g:tissue_state")
	let g:tissue_state ="all"
endif

if g:tissue_python != -1
	call python#py#init()
endif
"}}}

"{{{	Utility functions
function! s:TissueIsVisible()
    if bufwinnr(bufnr(g:tissue_buf_name)) != -1
        return 1
    else
        return 0
    endif
endfunction

function! s:TissueGoToWindow(name)
    if bufwinnr(bufnr(a:name)) != -1
        exe bufwinnr(bufnr(a:name)) . "wincmd w"
        return 1
    else
        return 0
    endif
endfunction

function! s:TissueAuthentication()
	if g:tissue_authentication == 1 && g:tissue_authenticated == 0
		if (g:tissue_api == "github")
			call apis#github#Authentication()
		elseif (g:tissue_api == "gitlab")
			echom ("Gitlab is not supported yet")
		else
			echom ("Other is not supported yet")
		endif
	endif
endfunction

function! s:TissueDisplayIssues()
	if (g:tissue_api == "github")
		call apis#github#getIssues()
	elseif (g:tissue_api == "gitlab")
		echom ("Gitlab is not supported yet")
	else
		echom ("Other is not supported yet")
	endif
endfunction
"}}}

"{{{	Mapping and settings
function! s:TissueBufferSetting()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal nolist
    setlocal norelativenumber
    setlocal nowrap
    call s:TissueBufferSyntax()
    call s:TissueBufferMapping()
    call s:TissueBufferStatusLine()
endfunction

function! s:TissueBufferSyntax()
    let b:current_syntax = 'tissue'
    " Build syntax
    " syn match [name] [regexp]
    " hi def link [name] keycolor
endfunction

function! s:TissueBufferMapping()
    nnoremap <script> <silent> <buffer> q             :call <sid>TissueClose()<CR>
    cabbrev  <script> <silent> <buffer> q             call <sid>TissueClose()
    cabbrev  <script> <silent> <buffer> quit          call <sid>TissueClose()
endfunction

function! s:TissueBufferStatusLine()
	if (g:tissue_status_line == 1)
		let &l:statusline = "target URL" . g:tissue_url
	endif
endfunction
"}}}

"{{{ Window management
function! s:TissueToggle()
    if s:TissueIsVisible()
        call s:TissueClose()
    else
        call s:TissueOpen()
    endif
endfunction

function! s:TissueClose()
    if s:TissueGoToWindow(g:tissue_buf_name)
        quit
    endif
endfunction

function! s:TissueOpen()
	call s:TissueAuthentication()
	call s:TissueDisplayIssues()
	silent exe g:tissue_width . "vsplit" . g:tissue_buf_name
	setlocal filetype=__tissue__
endfunction
"}}}

"{{{ Misc
function! tissue#TissueToggle()
	call s:TissueToggle()
endfunction

augroup TissueAutoCmd
    autocmd!
    autocmd Filetype __tissue__ call s:TissueBufferSetting()
augroup END
"}}}
