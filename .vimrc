"色の設定
syntax enable

set t_Co=256
"colorscheme molokai
"colorscheme twilight
"colorscheme hybrid
"colorscheme iceberg
"set background=dark

"番号の色
" - icebergの時
"highlight LineNr ctermfg=156
" - twilightの時
highlight LineNr ctermfg=166

"コメント色の設定"
hi Comment ctermfg=249

"タブ/インデントの設定


"set expandtab     " タブ入力を複数の空白入力に置き換える
"set tabstop=4     " 画面上でタブ文字が占める幅
"set shiftwidth=4  " 自動インデントでずれる幅
"set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
"set autoindent    " 改行時に前の行のインデントを継続する
"set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set noautoindent

"ファイル関連の設定
filetype on
filetype indent on
filetype plugin on
"画面表示の設定


set number         " 行番号を表示する
set cursorline     " カーソル行の背景色を変える
"set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
set showmatch      " 対応する括弧を強調表示
set helpheight=999 " ヘルプを画面いっぱいに開く
"set list  "タブ、空白、改行の可視化
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

" 全角スペースをハイライト表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif


" ファイル処理関連の設定


set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない


"マウスの入力を受け付ける
"set mouse=a

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

