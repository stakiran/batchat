# batchat
素の Windows でチャットを実現する遊び。

バッチファイルと Powershell で実現できた（つもりでいる）。

## 要件
- Windows 7+
- Powershell が動作すること

## 使い方
- (1) client_view.bat、client_post.bat、post.bat を同じフォルダ内に配置する
- (2) client_view.bat で投稿メッセージ（新着分）を閲覧する
- (3) client_post.bat でメッセージを投稿する

## その他のファイルについて
- chatdata.txt …… 書き込まれたメッセージが保存される。
- post.bat …… client_post.bat から呼ばれる「メッセージを書き込む」処理を行うバッチ。
- cannon.bat …… 指定間隔でメッセージを投稿し続けるテスト用バッチ。
  - sleep.exe …… cannon.bat から呼び出すスリープコマンド。
  - sleep.c …… sleep.exe のソース。

## 実装の話

### 新着メッセージ表示（client_view）
Powershell の Get-Content を用いて tail -f コマンド的なことを実現しているだけ。

### メッセージ投稿（client_post）
基本的に追記リダイレクト( `echo hogehoge >> file1.txt`)でメッセージを書き込んでいるだけ。ただし排他制御が必要なのでロックファイルを使用している。またフォーマットとして日付時刻とユーザー名を付与させてみた。

投稿処理は post.bat で行い、client_post.bat は post.bat を無限ループで対話的に呼び出すだけ。

### cannon.bat について
地味に一番苦労した。

やりたかったのは「短時間のランダムなスリープ」をはさんだ無限ループ中でメッセージを投稿することなのだが、以下のようなやり方になった。

- 乱数は `%random%` を使用
- 遅延展開が無いと `set /a ` の計算がしくじるので `setlocal EnableDelayedExpansion` で有効にしている
- 剰余の計算は `%%`
- ミリ秒レベルのスリープは C でコンパイルした実行ファイルを使用
  - 他の方法(スクリプト系)だと実行時オーバーヘッドが大きすぎる

## License
[MIT License](LICENSE)

## Author
[stakiran](https://github.com/stakiran)
