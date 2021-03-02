filetype plugin indent on
syntax enable

" Mappings
let mapleader = ","

noremap <silent> j gj
noremap <silent> k gk

noremap <Space> :

" <CR> after search clears highlight
" disables using <CR> to move down
" add a second <CR> to re-enable it
nnoremap <CR> :noh<CR>

noremap <C-q> <C-w>q
noremap <C-h> <C-w><C-h>
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>
tnoremap <C-h> <C-w><C-h>
tnoremap <C-j> <C-w><C-j>
tnoremap <C-k> <C-w><C-k>
tnoremap <C-l> <C-w><C-l>

nmap <leader>b :Buffers<CR>

nmap <C-\> :NERDTreeToggle<CR>

nmap <silent> <leader>l <Plug>DashSearch
nmap <leader>t :bel term<CR>

nmap <leader>w :w<CR>
nmap <leader>wq :wq<CR>

nmap <leader>gc :Gcommit<CR>
nmap <leader>gs :Gstatus<CR><C-w>L
nmap <leader>gp :Gpush<CR>
nmap <leader>gb :Gbranch<CR>

nmap <leader>p :Project<CR>

nmap <leader>f :Files<CR>
nmap <leader><C-t> :Tags<CR>
nmap <leader><C-f> :Rg<CR>

nmap <leader>d :ALEGoToDefinition<CR>
nmap <leader>r :ALEFindReferences<CR>

" Quick resizing for terminal
tnoremap <leader>1 <C-w>:res 10<CR>
tnoremap <leader>2 <C-w>:res 20<CR>

" alt + arrow support for terminal
tnoremap <silent> <M-left> <Esc><Left>
tnoremap <silent> <M-right> <Esc><Right>
tnoremap <silent> <M-BS> <Esc><BS>

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>

" TODO workaround for the following bug:
"   https://github.com/vim/vim/issues/4738
nmap gx yiW:!open <cWORD><CR> <C-r>" & <CR><CR>

" disable background color erase (BCE) and redraw after 1 line of scroll
" workaround for vim bug enabling BCE for terminals that dont' support it
" kovidgoyal/kitty#108, microsoft/terminal#832
"
" Also sets ttyfast, which improves smoothness of redrawing but is only
" on by default for certain values of `term`, excluding `xterm-kitty`.
if &term == 'xterm-kitty'
set t_ut= | set ttyscroll=1
endif

let g:lightline = {
\   'colorscheme': 'nord',
\   'active': {
\       'left': [
\           [ 'mode', 'paste' ],
\           [ 'gitbranch', 'readonly', 'relativepath', 'modified' ]
\       ],
\       'right': [ [ 'lineinfo' ], [ 'project' ] ]
\   },
\   'component_function': {
\       'project': 'CurrentProject',
\       'gitbranch': 'fugitive#head',
\   },
\ }

function! CurrentProject()
  " the current directory, relative to ~/dev/
  return fnamemodify(getcwd(), ':~:s?\~\/dev\/??')
endfunction

let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'python': ['flake8', 'pyls'],
\   'javascript': ['eslint']
\ }

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'python': ['black', 'isort'],
\   'javascript': ['prettier'],
\   'go': ['goimports']
\ }

" extended by ftplugin
let g:ale_pattern_options = {}

let g:localvimrc_whitelist = [$HOME.'/dev/[^/]\+/.lvimrc']

let g:vue_pre_processors = []

function! DockerTransform(cmd)
  " Use `test` as the Compose service, unless `b:test_service` is set
  let l:service = exists('b:test_service') ? b:test_service : 'test'
  return 'docker-compose run --service-ports '.l:service.' '.a:cmd
endfunction

function! PersistStrategy(cmd)
  if !exists("g:test#vimterminal_buffer") || !bufexists(g:test#vimterminal_buffer)
      belowright 20 new
      let g:test#vimterminal_buffer =
          \ term_start(&shell, {'term_finish': 'close', 'curwin': 1})
      wincmd p
  endif

  call term_sendkeys(g:test#vimterminal_buffer, a:cmd . "\<CR>")
endfunction

function! LightlineReload()
  " Calling these three functions will reload lightline:
  " https://github.com/itchyny/lightline.vim/issues/241
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

function! WipeoutHiddenBuffers()
  " modified from: https://stackoverflow.com/a/7321131

  " from :help tabpagebuflist, gets a list of all buffers in all tabs
  let tablist = []
  for i in range(tabpagenr('$'))
      call extend(tablist, tabpagebuflist(i + 1))
  endfor

  " below originally inspired by Hara Krishna Dara and Keith Roberts
  " http://tech.groups.yahoo.com/group/vim/message/56425
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
      if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
      " bufno exists, isn't modified, and is hidden
          silent exec 'bwipeout' i
          let nWipeouts = nWipeouts + 1
      endif
  endfor
  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

function! s:ChangeBranch(branch)
  execute '!git checkout ' . a:branch
  " TODO move to a git post-checkout hook instead
  execute '!rg --files | ctags -R --links=no -L -'
endfunction

function! s:ChangeProject(project)
  execute 'lcd ~/dev/' . a:project
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#custom_strategies = {'persist': function('PersistStrategy')}
let g:test#strategy = 'persist'

let g:livepreview_previewer = 'open -a Preview'

" no completion preview, only insert longest common text
set completeopt=menu,longest
" use ALE for completion
set omnifunc=ale#completion#OmniFunc
" stop comments on newlines
set formatoptions-=cro
" set vert divider character to <space>
set fillchars+=vert:\ 
" backspace across lines
set backspace=2
" line numbers
set number
" lightline shows the mode
set noshowmode
" wrap on newline only, for notes
set linebreak
" always show a status line
set laststatus=2
" default tab configuration, overridden by ftplugin
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" prevent splits from auto-resizing
set noequalalways
" search as you type, case-insensitive, highlight search
set incsearch hlsearch ignorecase
" hide scrollbars, use copy-on-select
set guioptions=a

" auto-read changed files
set autoread

" Colors and fonts
set guifont=Monaco:h16
set termguicolors
colorscheme nord

" Hide ~ at end of buffer by setting to bg color
" highlight EndOfBuffer ctermfg=bg guifg=bg

" Auto-reload ~/.vimrc
augroup vimrc-reload
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

" Highlight the current line
augroup CurBufferHighlight
autocmd!
autocmd WinEnter * set cul
autocmd WinLeave * set nocul
augroup END

" Enable limelight for distraction-free writing
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Set nonumber in terminal buffers to prevent bad line wrapping
autocmd! TerminalOpen * setlocal nonumber

" Preemptively rehighlight .vue files
autocmd! FileType vuejs syntax sync fromstart

" Treat *.svelte as HTML
autocmd! BufNewFile,BufRead *.svelte set ft=html

" Spell check emails and commit messages
autocmd! FileType email,gitcommit setlocal spell spelllang=en_us

" Custom commands
command! Vimrc tabe ~/.vimrc
command! LightlineReload call LightlineReload()
command! WipeoutHiddenBuffers call WipeoutHiddenBuffers()
command! PrettyJson %!python -m json.tool
command! -nargs=1 DiffBranch rightbel vsp | exec ":Gedit " . <q-args> . ":" . @%
command! ALEDisableFixBuffer let b:ale_fix_on_save=0
command! ALEEnableFixBuffer  let b:ale_fix_on_save=1

command! -bang Project call fzf#run({
          \ 'source': 'ls -d ~/dev/*/ | xargs -n 1 basename',
          \ 'sink': function('s:ChangeProject'),
          \ 'options': ['--prompt', 'Project> '],
          \ 'right': 30
          \ })

" from: https://vi.stackexchange.com/a/15991
command! -bang Gbranch call fzf#run({
          \ 'source': 'git for-each-ref --format="%(refname:short)" refs/heads',
          \ 'sink': function('s:ChangeBranch'),
          \ 'options': ['--prompt', 'Branch> '],
          \ 'down': '~40%'
          \ })

command! -bang Pylist exec '%s/\(.\+\)$\n/"\1",' | normal ^i[$a]

" Redefine Rg command to add `--hidden -g '!.git'`
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --hidden -g "!.git" --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
