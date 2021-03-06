syntax on
filetype plugin indent on
if has("gui_macvim")
    set guifont=Menlo:h12
    set guitablabel=%t
    set transparency=5
    set guioptions-=T
endif

let g:languagetool_jar='/usr/share/java/languagetool/languagetool-commandline.jar'
let g:flake8_cmd='flake8-python2'
set spelllang=en
let g:languagetool_win_height=10
"关闭与vi兼容模:
"式
set nocompatible
"防止一些有关modelines的安全漏洞
set modelines=0
set foldlevel=99
"设置tab键为4个空格
set tabstop=2
"当行之间交错时使用4个空格
set shiftwidth=2
set softtabstop=2
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set hidden
set visualbell
set cursorline
"set cursorcolumn
set ttyfast
set ruler
set nolist
set backspace=indent,eol,start
set laststatus=2
"显示相对行号
"set relativenumber
set number
set tag=tags;../tags;../../tags;../../../tags;../../../../../tags;../../../../../../tags;../../../../../../../../tags;
"打开智能缩进。这个是vi三种缩进中最聪明的一种。对写程序很方便
"
set cindent shiftwidth=4
"nmap <C-h> <Esc>:noh<cr>
""ctrl-c，打开vi自带的简易计算器
imap <C-c> <C-R>=
nmap <silent><C-n> :bn<cr>
"ctrl-p 切换到上一缓冲区
"nmap <silent><C-p> :bp<cr>
""ctrl-l 显示所有缓冲区
nmap <C-l> :ls<cr>

"用于cscope，当用cscope创建了tags后，在你光标所在的函数上
""按ctrl-] ctrl-[会跳转到该函数的调用处
map <C-]><C-[> :cs f 3 <cword><cr>

colorscheme elflord
"colorscheme molokai
"colorscheme desert
"colorscheme peachpuff
"colorscheme torte
"colorscheme morning
"colorscheme koehler
"colorscheme murphy
"colorscheme delek
"colorscheme ron

"au BufWinLeave * silent mkview
"au BufWinEnter * silent loadview
autocmd FileType python setlocal foldmethod=indent
autocmd FileType python set omnifunc=pythoncomplete#Complete
set t_Co=256
let g:Powerline_symbols='unicode'
let g:Powerline_theme='default'
let g:fencview_autodetect = 1
set background=dark
" 设置编码
"set enc=utf-8
" 设置文件编码
set fenc=utf-8
"set mmp=1000
"set mm=1000
"set mmt=10000
set fencs=utf-8,ucs-bom,gb2312,cp936,gbk,gb18030,big5,euc-jp,euc-kr,latin1


let g:pydiction_location = '/usr/share/pydiction/complete-dict'
"set backupcopy=auto
"setlocal backupcopy=auto
set background=dark

"let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
"call pathogen#infect()

""""""""""""""""""""""""""""""""""""
" " => General Autocommand
""""""""""""""""""""""""""""""""""""
"{{{
" some general completions
autocmd FileType c,cpp iabbrev #i	#include
" autocmd FileType c,cpp,java,sh,perl inoremap {	{<CR>}<Esc>O
autocmd FileType c,cpp,java,perl inoremap {	{<CR>}<Esc>O
autocmd FileType c,cpp,java inoremap <	<><Left>
autocmd FileType sh,perl inoremap ` ``<Left>
autocmd FileType c,cpp,java,sh inoremap ' ''<Left>
autocmd FileType c,cpp,java,sh,perl inoremap " ""<Left>
autocmd FileType c,cpp,java inoremap ( ()<Left>
" autocmd FileType c,cpp,java,sh,perl inoremap [ []<Left>
autocmd FileType c,cpp,java,perl inoremap [ []<Left>
"}}}
"""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""
"{{{
"Open a dummy buffer for paste
map <Leader>q :e ~/buffer<CR>

"Restore cursor to file position in previous editing session
set viminfo='10,f1,<500,:20,/20,h,%,n~/.viminfo

" Buffer - reverse everything ... :)

"Use the arrows to something usefull
"map <Right> :bn<CR>
"map <Left> :bp<CR>
"map <Down> :bdelete<CR>
"}}}
""""""""""""""""""""""""""""""""""""""
" => Files and backup
""""""""""""""""""""""""""""""""""""""
"{{{
"Turn backup off
set nobackup
"set writebackup
set noswapfile
"}}}
"""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""
"{{{
"Enable folding, I find it very useful
"if exists("&foldenable")
"	set foldenable
"endif
"
"if exists("&foldlevel")
"	set foldlevel=0
"endif
"
"set foldmethod=indent
"set foldexpr=<Tab>
"}}}
""""""""""""""""""""""""""""""""""""""""
" => Text option
""""""""""""""""""""""""""""""""""""""""
"{{{
set expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal backspace=2
setlocal smarttab
setlocal lbr
setlocal tw=500
"}}}
""""""""""""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""""""""""""
"{{{
"Auto indent
set autoindent

"Smart indet
set smartindent

"C-style indenting
set cindent

"Wrap line
set wrap
"}}}
""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
""""""""""""""""""""""""""""""""""""""""""
"{{{
map <Leader>sn ]
map <Leader>sp [
map <Leader>sa zg
map <Leader>s? z=
"}}}
""""""""""""""""""""""""""""""""""""""""""""
" => File explorer
""""""""""""""""""""""""""""""""""""""""""""
"{{{
"Split vertically
let g:explVertical=1

"Window size
let g:explWinSize=35

let g:explSplitLeft=1
let g:explSplitBelow=1

"Hide some file
let g:explHideFiles='.*.class$,.*.swp$,.*.pyc$,.*.swo$,.DS_Store$'

"Hide the help thing..
let g:explDetailedHelp=0
"}}}
""""""""""""""""""""""""""""""""""""
"{{{
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplorerMoreThanOne = 0
"let g:miniBufExplModSelTarget = 0
"let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplVSplit = 25
"let g:miniBufExplSplitBelow=1
"let g:bufExplorerSortBy = "name"
"}}}
""""""""""""""""""""""""""""""""""""
" => Mode Changing, Insert, Normal, Commandline, Select, Viusal, Ex
""""""""""""""""""""""""""""""""""""
"{{{
"It can be selected by Ctrl+G in visual mode to implement the effect of mouse.
set selectmode=mouse

"""""""""""""""""""""""""""""""""""""""""
" => Ctags
"""""""""""""""""""""""""""""""""""""""""
"remap C-] to :tjump
nmap <C-]> :tjump <C-R>=expand("<cword>")<CR><CR>
"}}}
""""""""""""""""""""""""""""""""""""
" => Cscope
""""""""""""""""""""""""""""""""""""
"{{{
if has("cscope") && filereadable("cscope.out")
	set csprg=/usr/bin/cscope
	" set cscope quickfix, not very convenient
	"set csqf=s-,c-,d-,i-,t-,e-
	" determine the order in which :cstag performs a search, cscope databases are searched first if csto equals 0
	set csto=1
	" use :cstag instead of :tag behavior ++++BUG: remove some lines and turn to Insert Mode
	set nocst
	" display the entire path
	set cspc=0
	" no indicating success or failure when adding a cscope database
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	" reinit all connections, because the first add always gives an error
	cs reset
	" reopen the option
	set csverb

	" use suggestions
	nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
"}}}
""""""""""""""""""""""""""""""""""""
" => Source completion
""""""""""""""""""""""""""""""""""""
"{{{
"options for insert mode completion
set completeopt=menu,longest

"mapping for the completion's easy use
inoremap <expr> <CR>    pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <C-J>   pumvisible()?"\<PageDown>\<C-N>\<C-P>":"\<C-X>\<C-O>"
inoremap <expr> <C-K>   pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<C-K>"
inoremap <expr> <C-U>   pumvisible()?"\<C-E>":"\<C-U>"
"}}}
""""""""""""""""""""""""""""""""""""
" => Quickfix
""""""""""""""""""""""""""""""""""""
"{{{
if has("quickfix")
	autocmd FileType c,cpp,tex map <buffer> <Leader><Space> :write<CR>:make all<CR>:cwindow<CR><C-w>k
	nmap <Leader>cn :cnext<CR>
	nmap <Leader>cp :cprevious<CR>
	nmap <Leader>cw :cw 10<CR>
endif
"}}}
""""""""""""""""""""""""""""""""""""
" => Man pages support
""""""""""""""""""""""""""""""""""""
"{{{
runtime! ftplugin/man.vim
"}}}
""""""""""""""""""""""""""""""""""""
" => Latex
""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""""""""
"{{{
"Select all
nmap <C-a> ggVG

"Insert mode left/right
imap <C-l>  <Right>
imap <C-h>  <Left>

"Remove the Windows ^M
noremap <Leader>m :%s/\r//g<CR>

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

let Tlist_Enable_Fold_Column = 0     "don't show left fold line
let Tlist_WinWidth = 20              "the width of taglist's window
let Tlist_Show_One_File = 1          "allow taglist to show onl tag of current file 
let g:Tb_ForceSyntaxEnable = 1
nmap <silent> <F2>   :MBEToggle<CR>
nmap <silent> <F4>   :TlistToggle<CR>
let g:loaded_matchparen = 1
"}}}
""""""""""""""""""""""""""""""""""""
" => Detect note filetype
""""""""""""""""""""""""""""""""""""
"{{{
augroup filetypedetect
	"Note filetype
	au! BufRead,BufNewFile *.note	setfiletype note
augroup END
"}}}
""""""""""""""""""""""""""""""""""""
" => Detect notes filetype
""""""""""""""""""""""""""""""""""""
"{{{
augroup filetypedetect
	au BufNewFile,BufRead *.notes setf notes
augroup END
"}}}
""""""""""""""""""""""""""""""""""""
" => Encoding related
""""""""""""""""""""""""""""""""""""
"{{{
set encoding=UTF-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set fileencoding=utf-8
"}}}
""""""""""""""""""""""""""""""""""""
" => Winmanager settings
"""""""""""""""""""""""""""""""""""
"{{{
"Winmanager
let g:winManagerWindowLayout = "FileExplorer|BufExplorer"
nmap wm :WMToggle<cr>
nmap <silent> <F8> :WMToggle<cr>
map dt :r !date --rfc-2822<C-V><C-J>-join<cr>

"TagList settings
let Tlist_Use_Right_Window=1   "show taglist in right
let Tlist_Show_One_File=1      "show tags of current file
let Tlist_Show_Menu=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow = 1 
map <silent> <F3> :TlistToggle<cr>
"}}}
""""""""""""""""""""""""""""""""""""
" => vim vundle settings
"""""""""""""""""""""""""""""""""""
"{{{
if isdirectory(expand('~/.vim/bundle/vundle'))
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/Vundle.vim'
    " Automatically opens popup menu for completions.
    Bundle 'vim-scripts/AutoComplPop'
    " A tree explorer plugin for vim.
    Bundle 'scrooloose/nerdtree'
    " Mirror of the official Google go vim support.
    Bundle 'ralph/go.vim'
    " Tab-complete your Python code.
    Bundle 'vim-scripts/Pydiction'
    let g:pydiction_location='~/.vim/after/ftplugin/pydiction/complete-dict'
    " A windows style IDE for Vim 6.0.
    Bundle 'vim-scripts/winmanager'
    " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc).
    Bundle 'vim-scripts/taglist.vim'
    " Vim Markdown runtime files.
    Bundle 'tpope/vim-markdown'
    " Flake8 plugin for Vim.
    "Bundle 'nvie/vim-flake8'
    " powerline
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'tell-k/vim-autoflake'
    Bundle 'tell-k/vim-autopep8'
    "Bundle 'vim-scripts/vim-autoflake'
    "Bundle 'vim-scripts/vim-autopep8'
    "Bundle 'klen/python-mode'
    " compiler plugin for python style checking tool.
    "Bundle 'vim-scripts/pylint.vim'
    "autocmd FileType python compiler pylint
    let g:pylint_show_rate = 0
    let g:pylint_onwrite = 0
    let g:pylint_cwindow = 0
    "Automatically scrolls the window slowly so you can read a file hands-free
    "Bundle 'vim-scripts/autoscroll.vim'
endif
"}}}

""""""""""""""""""""""""""""""""""""
" => vim python settings, from python source
"""""""""""""""""""""""""""""""""""
"{{{
let g:PythonAutoAddImports = 1
" vimrc file for following the coding standards specified in PEP 7 & 8.
"
" To use this file, source it in your own personal .vimrc file (``source
" <filename>``) or, if you don't have a .vimrc file, you can just symlink to it
" (``ln -s <this file> ~/.vimrc``).  All options are protected by autocmds
" (read below for an explanation of the command) so blind sourcing of this file
" is safe and will not affect your settings for non-Python or non-C files.
"
"
" All setting are protected by 'au' ('autocmd') statements.  Only files ending
" in .py or .pyw will trigger the Python settings while files ending in *.c or
" *.h will trigger the C settings.  This makes the file "safe" in terms of only
" adjusting settings for Python and C files.
"
" Only basic settings needed to enforce the style guidelines are set.
" Some suggested options are listed but commented out at the end of this file.

" Number of spaces that a pre-existing tab is equal to.
" For the amount of space used for a new tab use shiftwidth.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=8

" What to use for an indent.
" This will affect Ctrl-T and 'autoindent'.
" Python: 4 spaces
" C: tabs (pre-existing files) or 4 spaces (new files)
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
fu! Select_c_style()
    if search('^\t', 'n', 150)
        set shiftwidth=8
        set noexpandtab
    el 
        set shiftwidth=4
        set expandtab
    en
endf
au BufRead,BufNewFile *.c,*.h call Select_c_style()
au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
" Python: 79 
" C: 79
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
au BufRead,BufNewFile *.c,*.h set formatoptions-=c formatoptions-=o formatoptions-=r

" Use UNIX (\n) line endings.
" Only used for new files so as to not force existing files to change their
" line endings.
" Python: yes
" C: yes
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
"}}}

""""""""""""""""""""""""""""""""""""
" => vim rpm spec settings
"""""""""""""""""""""""""""""""""""
"{{{
" ----------------------------------------------------------------------------
" The following section contains suggested settings.  While in no way required
" to meet coding standards, they are helpful.

" Set the default file encoding to UTF-8: ``set encoding=utf-8``

" Puts a marker at the beginning of the file to differentiate between UTF and
" UCS encoding (WARNING: can trick shells into thinking a text file is actually
" a binary file when executing the text file): ``set bomb``

" For full syntax highlighting:
"``let python_highlight_all=1``
"``syntax on``

" Automatically indent based on file type: ``filetype indent on``
" Keep indentation level from previous line: ``set autoindent``

" Folding based on indentation: ``set foldmethod=indent``

function! SKEL_spec()
        0r /usr/share/vim/current/skeletons/skeleton.spec
        language time en_US
        if $USER != ''
            let login = $USER
        elseif $LOGNAME != ''
            let login = $LOGNAME
        else
            let login = 'unknown'
        endif
        let newline = stridx(login, "\n")
        if newline != -1
            let login = strpart(login, 0, newline)
        endif
        if $HOSTNAME != ''
            let hostname = $HOSTNAME
        else
            let hostname = system('hostname -f')
            if v:shell_error
                let hostname = 'localhost'
            endif
        endif
        let newline = stridx(hostname, "\n")
        if newline != -1
            let hostname = strpart(hostname, 0, newline)
        endif
        exe "%s/specCURRENT_YEAR/" . strftime("%Y") . "/ge" 
        exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
        exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
        exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
        setf spec
endfunction
"}}}
" vim: set fdm=marker:
