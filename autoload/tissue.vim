" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    tissue.vim                                         :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: alngo <alngo@student.42.fr>                +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2019/10/31 18:03:34 by alngo             #+#    #+#              "
"    Updated: 2019/11/20 17:35:03 by alngo            ###   ########.fr        "
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

function! s:SetIssuePerPage()
	s:TissueGoToWindow(g:tissue_buf_name)
	setlocal modifiable
	let g:tissue_per_page = winheight(0) / 3 + 5
	setlocal nomodifiable
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

function! s:TissueListIssues()
	if (g:tissue_api == "github")
		call apis#github#listIssues()
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
    setlocal nonumber
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

function! s:Techo(str)
	echom a:str
endfunction

function! s:TissueBufferMapping()
    " Edition
    nnoremap <script> <silent> <buffer> n	:call <sid>Techo("new")<CR>
    nnoremap <script> <silent> <buffer> o	:call <sid>Techo("open")<CR>
    nnoremap <script> <silent> <buffer> e	:call <sid>Techo("edit")<CR>
    nnoremap <script> <silent> <buffer> c	:call <sid>Techo("close")<CR>
    nnoremap <script> <silent> <buffer> d	:call <sid>Techo("delete")<CR>
    " Navigation
    nnoremap <script> <silent> <buffer> k	:call <sid>Techo("up")<CR>
    nnoremap <script> <silent> <buffer> j	:call <sid>Techo("down")<CR>
    " Close window
    nnoremap <script> <silent> <buffer> q       :call <sid>TissueClose()<CR>
    cabbrev  <script> <silent> <buffer> q       :call <sid>TissueClose()
    cabbrev  <script> <silent> <buffer> quit    :call <sid>TissueClose()
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
	silent exe g:tissue_width . "vsplit" . g:tissue_buf_name
	setlocal filetype=__tissue__
	if g:tissue_per_page == 0
		call s:SetIssuePerPage()
	endif
	call s:TissueListIssues()
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
