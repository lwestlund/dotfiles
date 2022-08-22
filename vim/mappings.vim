"" Set leader key and configure leader mappings {
    " Close current buffer and move to previous one
    nmap <silent> <leader>bq :bp <BAR> bd #<CR>

    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

"imap <Leader>e ä
"imap <Leader>a å
"imap <Leader>o ö
"imap <Leader>E Ä
"imap <Leader>A Å
"imap <Leader>O Ö
" }

"" Use arrow keys to resize splits {
    nnoremap <silent> <Up>    :resize +2<CR>
    nnoremap <silent> <Down>    :resize -2<CR>
    nnoremap <silent> <Left>    :vertical resize +2<CR>
    nnoremap <silent> <Right> :vertical resize -2<CR>
"" }

"" <Space> to turn off search highlight {
    nmap <silent> <Space> :nohlsearch<Bar>:echo<CR>
        "Clear highlighting of search when pressing Space
"" }


"" <F2> to write and compile TeX {
    map <F2> :call WriteCompileTex()<CR>
"" }

"" <F6> to toggle spell check {
    map <F6> :setlocal spell! <CR>


"" Navigate buffers with tab, shift-tab {
    nmap <silent> <Tab> :bnext!<CR>
    nmap <silent> <S-Tab> :bprevious!<CR>
"" }


"" Alternative escape key {
    imap jk <Esc>
    "vmap jk <Esc>
"" }


"" Movement {
    nnoremap j gj
    nnoremap k gk

    " Navigate splits
    nmap <silent> <C-S-k> :wincmd k<CR>
    nmap <silent> <C-S-h> :wincmd h<CR>
    nmap <silent> <C-S-j> :wincmd j<CR>
    nmap <silent> <C-S-l> :wincmd l<CR>

    nnoremap <BS> {
    onoremap <BS> {
    nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
    onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
"" }


"" Save with 'S' {
    nnoremap S :w<CR>
"" }


"" Insert empty lines without insert mode {
    nnoremap t o<ESC>k
    nnoremap T O<ESC>j
"" }

"" YouCompleteMe {
    nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
    nnoremap <leader>fi :YcmCompleter FixIt<CR>
    nnoremap <leader>go :YcmCompleter GoTo<CR>
    nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>gt :YcmCompleter GetType<CR>
"" }

"" clang-format {
    nmap <C-c> :call ClangFormatCpp()<CR>

    vmap <C-c> :pyfile /usr/share/vim/addons/syntax/clang-format.py<CR>
"" }

"" Fzy find {
    nnoremap <silent> <leader>e :call FzyCommand("rg --no-messages --files", ":e ")<CR>
    nnoremap <silent> <leader>v :call FzyCommand("rg --no-messages --files", ":vs ")<CR>
    nnoremap <silent> <leader>s :call FzyCommand("rg --no-messages --files", ":sp ")<CR>
"" }
