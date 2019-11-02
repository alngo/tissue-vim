" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    tissue.vim                                         :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: alngo <alngo@student.42.fr>                +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2019/10/31 18:03:34 by alngo             #+#    #+#              "
"    Updated: 2019/11/02 18:59:11 by alngo            ###   ########.fr        "
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

let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

if !exists("g:tissue_python")
	if has("python3")
		let g:tissue_python = 1
	else
		let g:tissue_python = 2
	endif
endif
if !exists("g:tissue_width")
	let g:tissue_width = 60
endif
if !exists("g:tissue_buf_name")
	let g:tissue_buf_name = "__tissue__"
endif
if !exists("g:tissue_status_line")
	let g:tissue_status_line = 1
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
"}}}

"{{{	Mapping and Settings
function! s:TissueBufferSetting()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal nolist
    setlocal nonumber
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
		let &l:statusline = "custom status line *TODO*"
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
	exe g:tissue_width . "vsplit" . g:tissue_buf_name
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
