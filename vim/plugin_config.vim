"" Airline config {
    " Enable the list of buffers
    let g:airline#extensions#tabline#enabled = 1
    " Show just the filename in the buffer line
    let g:airline#extensions#tabline#fnamemod = ':.'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#left_sep = ''
    let g:airline#extensions#tabline#left_alt_sep = ''
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    let g:airline#extensions#tabline#buffer_idx_mode = 1

    let g:airline#extensions#branch#enabled = 1

    let g:airline#extensions#ale#enabled = 1

    let g:airline_theme='lucius'
    let g:airline#extensions#ycm#enabled = 1
    let g:airline#extensions#ycm#error_symbol = 'E:'
    let g:airline#extensions#ycm#warning_symbol = 'W:'
"" }


"" Rainbow Parantheses {
    let g:rainbow_active = 1
    let g:rainbow_conf = {
	\	'guifgs': ['royalblue1', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['32', '208', '34', '196'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
        \               'cmake': 0,
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\	}
	\}
"" }


""  YouCompleteMe {
    let g:ycm_autoclose_preview_window_after_completion = 1
    " Typescript completion
    if !exists("g:ycm_semantic_triggers")
        let g:ycm_semantic_triggers = {}
    endif
    let g:ycm_python_binary_path = '/usr/bin/python3'
    let g:ycm_server_python_interpreter = '/usr/bin/python3'

    " Make YCM work with python packages from virtual environments
    let g:ycm_python_interpreter_path = ''
    let g:ycm_python_sys_path = []
    let g:ycm_extra_conf_vim_data = [
                \  'g:ycm_python_interpreter_path',
                \  'g:ycm_python_sys_path'
                \]
    let g:ycm_global_ycm_extra_conf = '~/.vim/global_extra_conf.py'
"" }


"" Ultisnips and some YouCompleteMe {
    " Make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion    = ['<Tab>', '<Down>']
    let g:ycm_key_list_previous_completion  = ['<S-Tab>', '<Up>']

    " Better key bindings for UltiSnipsExpandTrigger
    let g:UltiSnipsExpandTrigger        = "<C-e>"
    let g:UltiSnipsJumpForwardTrigger   = "<C-j>"
    let g:UltiSnipsJumpBackwardTrigger  = "<C-z>"
"" }


"" IndentGuides {
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 4
    let g:indent_guides_start_level = 1
    let g:indent_guides_auto_colors = 0
    augroup Group1
        autocmd!
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=NONE ctermbg=NONE
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#252525 ctermbg=235 " #073642 ctermbg=235
    augroup END
"" }


"" ALE Asynchronous Lint Engine {
    "let g:ale_set_balloons = 1
    let g:ale_linters = {
            \'cpp': ['gcc'],
            \'python': ['flake8'],
            \}
    let g:ale_fixers = {
    \   'cpp': ['clang-format'],
    \   'python': ['black'],
    \}

    let g:ale_c_parse_compile_commands=1
    let g:ale_linters_explicit=1
    let g:ale_echo_msg_format='%linter%: %code: %%s'
"" }


"" MarkdownPreview {
    let g:mkdp_browser = 'brave-browser'
    let g:mkdp_auto_close = 0
"" }


"" NeoSolarized {
    " Set to 1 to enable transparent background
    let g:neosolarized_termtrans = 0
"" }

"" vim-commentary {
    augroup VimCommentary
        autocmd!
        autocmd FileType cmake setlocal commentstring=\#\ %s
        autocmd FileType cpp setlocal commentstring=//\ %s
    augroup END
"" }
