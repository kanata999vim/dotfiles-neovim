"----------------------------------------------------------
" ヘルプの日本語化
"----------------------------------------------------------
"help JP
set helplang=ja

"----------------------------------------------------------
" 日本語を自動OFF
" fcitx-remote -s imname で、これは imname で特定される入力メソッドに切り替わります。
" 使用中の入力メソッドに対する正しい imname は、
" fcitx-diagnose を実行し、 "## インプットメソッド:" セクションで確認することができます。
"----------------------------------------------------------
inoremap <silent> <Esc> <Esc>:call system('fcitx5-remote -s keyboard-us')<CR>

"----------------------------------------------------------
" 折りたたみ無効化
"----------------------------------------------------------
let g:markdown_folding_disabled = 1

"----------------------------------------------------------
" 余白
"----------------------------------------------------------
augroup numberwidth
    autocmd!
    autocmd BufEnter,WinEnter,BufWinEnter * let &l:numberwidth = len(line("$")) + 3
augroup END

"----------------------------------------------------------
"スワップファイル（.swp）の出力場所を設定する
"----------------------------------------------------------
set directory=~/.vim/tmp

"----------------------------------------------------------
" カラー設定
"----------------------------------------------------------
"colorscheme
autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
autocmd ColorScheme * highlight Comment ctermfg=141 guifg=#af87ff
autocmd ColorScheme * highlight CocUnusedHighlight ctermfg=117 ctermbg=239 guifg=#8be9fd guibg=#44475a

"----------------------------------------------------------
" アイコン表示
"----------------------------------------------------------
" アイコン表示の設定
"set guifont=Cica:h16
"set printfont=Cica:h12
"set ambiwidth=double
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12

"----------------------------------------------------------
" キーの反応時間を短縮
"----------------------------------------------------------
set timeoutlen=1000 ttimeoutlen=0

"----------------------------------------------------------
"" ステータスラインの設定
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する


"----------------------------------------------------------
" 文字
"----------------------------------------------------------
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 "
" 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

"Insert mode movekey bind
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
nnoremap <Right> <C-l>

"x,sでヤンクしない
nnoremap x "_x
nnoremap s "_s

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=2 " 画面上でタブ文字が占める幅
set softtabstop=2 "
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent "
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2 " smartindentで増減する幅
" 不可視文字を表示する場合
" set list

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><esc><esc> :<C-u>set nohlsearch!<CR>



"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ "
"カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カー??ルラインをハイライト

if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif


"行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"バックスペースキーの有効化
set backspace=indent,eol,start

" 改行コードの自動認識
set fileformats=unix,dos,mac

"----------------------------------------------------------
" カッコ・タグの対応
"----------------------------------------------------------
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

"----------------------------------------------------------
"クリップボードからのペースト
"----------------------------------------------------------
" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
if &term =~ "xterm"
	let &t_SI .= "\e[?2004h"
	let &t_EI .= "\e[?2004l"
	let &pastetoggle = "\e[201~"

	function XTermPasteBegin(ret)
		set paste
		return a:ret
	endfunction

	inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"----------------------------------------------------------
" ヤンクした内容をクリップボードへコピー
"----------------------------------------------------------
if has("clipboard")
	set clipboard=unnamedplus
endif


"----------------------------------------------------------
" memo
"----------------------------------------------------------
cnoremap memo<CR> <C-u>call EditDailyMemo()<CR>
function! EditDailyMemo()
	let l:daily_memo_dir = $DAILY_MEMO_DIR
	let l:memo_dir = l:daily_memo_dir.'/'.strftime('%Y/%m')
	let l:memo_file = l:memo_dir.'/'.strftime('%d').'.md'
	call mkdir(l:memo_dir, 'p')
	execute "vnew + ".l:memo_file
	" execute "normal \<c-w>35<"
endfunction


"----------------------------------------------------------
" vim-plug
"----------------------------------------------------------

call plug#begin((has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged'))

Plug 'itchyny/lightline.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-jp/vimdoc-ja'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'inkarkat/vim-SyntaxRange'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'reireias/vim-cheatsheet'
Plug 'simeji/winresizer'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
" npm install -g pyright intelephense typescript-language-server typescript
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" jsxのSyntax
Plug 'pangloss/vim-javascript'  " dependency plugin
Plug 'maxmellon/vim-jsx-pretty'

" テキストオブジェクトの拡張
Plug 'kana/vim-textobj-user'
" ファイル全体
" ae, ie
Plug 'kana/vim-textobj-entire'
" 関数内
" af, if
Plug  'kana/vim-textobj-function'
" アンダースコアの間
" a_, i_
Plug  'kana/vim-textobj-underscore'
" 日本語に対応している単語
" aW, iW
Plug 'deton/textobj-nonblankchars.vim'

" gitの変更箇所を左側に表示
Plug 'airblade/vim-gitgutter'

" PHPのインデント
Plug '2072/PHP-Indenting-for-VIm'

" twigのシンタックスハイライト
Plug 'nelsyeung/twig.vim'

" table編集
Plug 'dhruvasagar/vim-table-mode'

" ファイルツリーの色
Plug 'lambdalisue/glyph-palette.vim'

" プロジェクトごとの設定(インデントなど)
Plug 'editorconfig/editorconfig-vim'
"----------------------------------------------------------
" 下記のようなファイルをプロジェクトルートに置くことで、
" プロジェクトごとに設定を変更できる
"
" .editorconfig
" ---------------
" root = true
"
" [*]
" indent_style = space
" indent_size = 2
"
" [*.md]
" indent_size = 4
"
"----------------------------------------------------------


call plug#end()

"----------------------------------------------------------
"
" plugin setting
"
"----------------------------------------------------------

"----------------------------------------------------------
" lightLine
"----------------------------------------------------------
let g:lightline = {
            \ 'colorscheme': 'dracula',
            \ 'component': {
                \   'readonly': '%{&readonly?"":""}',
                \ },
                \ 'separator':    { 'left': '', 'right': '' },
                \ 'subseparator': { 'left': '', 'right': '' },
                \ }

"----------------------------------------------------------
" NERDTree
"----------------------------------------------------------
autocmd VimEnter * execute 'NERDTree'
"autocmd ColorScheme * highlight NERDTreeFlags ctermfg=44 ctermbg=NONE
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>
" ファイルを開いたらNERDTreeを閉じる
let g:NERDTreeQuitOnOpen = 1
" 隠しファイルを表示
let g:NERDTreeShowHidden = 1
augroup vimrc_nerdtree
    autocmd!
    " 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
    autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
augroup END

"----------------------------------------------------------
" ryanoasis/vim-devicons
"----------------------------------------------------------
" フォルダアイコンの表示をON
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" フォルダアイコンを表示
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

"----------------------------------------------------------
" dracula
"----------------------------------------------------------
let g:dracula_italic = 0
colorscheme dracula

"----------------------------------------------------------
" アイコンに色をつける
"----------------------------------------------------------
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

"----------------------------------------------------------
" reireias/vim-cheatsheet'
"----------------------------------------------------------
let g:cheatsheet#cheat_file = '~/.config/nvim/.cheatsheet.md'

"----------------------------------------------------------
" vim-gitgutter
"----------------------------------------------------------
nmap <silent> <C-g><C-n> <Plug>GitGutterNextHunk
nmap <silent> <C-g><C-p> <Plug>GitGutterPrevHunk

"----------------------------------------------------------
" coc.nvim
"----------------------------------------------------------
" gd で関数定義を開く
nmap <silent> gd :CocCommand tsserver.goToSourceDefinition<CR>
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
