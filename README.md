## jRogue for macOS （日本語版 Rogue 5.4）
Rouge（ローグ）とは1980年に作られた最初期のRPGの一つで、一文字で表現されたキャラクターやプレイするたびにランダムに作られる迷宮などが特徴です。Rogueの最終版といわれるバージョン5.4を日本語化し、macOS Sierraで問題なく遊べるように調整しHomebrew用のパッケージとしてまとめました。Homebrewには英語版Rogueのパッケージがすでに存在しているため、こちらのパッケージはjRogueという名前にしています。

ここにあるのはターミナルで使うCUI版です。他にクリック操作のみで起動できるGUI版も用意していますが、GUI版については下記のURLを参照してください。  
http://leopardgecko.zouri.jp/rogue.html
## インストール方法
```
$ brew tap leopard-gecko/game
$ brew install jrogue
```
遊び方やライセンスなどの各種ドキュメントは「/usr/local/share/doc/jrogue-5.4.5J/」にインストールされます。

和訳したmanページもインストールされますが、Macの標準の環境では日本語のmanページを適切に表示させることができません。他サイトを参照するなどして日本語に対応させると読むことができるようになります。（標準の環境を変えたくない等の場合は、上記ドキュメント内の「jrogue.cat」がmanページと同じものなので、そちらを参照してください）
## 起動方法
```
$ jrogue
```
・プレイヤーの名前を変えたい場合は「-n」で指定する。
```
$ jrogue -n 名前
```
・GUI版でいうところの「通常」モードで起動したい場合は「-11」を加える。
```
$ jrogue -11
```
その他のオプションは付属のドキュメントを参照してください。

スコアファイル（jrogue.scr）がカレントディレクトリに自動的に作成されます。スコアファイルが作成されるディレクトリを固定したい場合は後述のTipsを参考にしてください。
## 遊び方
詳細は[【運命の洞窟】へのガイド](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E3%82%AC%E3%82%A4%E3%83%89.md)を参照してください。  
また、ゲーム中に「?」をタイプすればコマンドのヘルプを表示できます。

移動などのコマンドは英数モードでないと入力ができませんので注意してください。ゲーム中にテキストを入力するときには「かな」モードで日本語も入力できますが、ゲームの操作に戻ったら英数モードに切り替えてください。
## 環境変数
オプションは環境変数「ROGUEOPTS」で設定することも可能です。  
例えば、GUI版の「通常モード」と同等の設定にしてプレイヤー名をleopardgeckoに指定する場合は、 .bashrc に以下のように追記します。
```sh
export ROGUEOPTS="passgo,color,idscrl,name=leopardgecko"
```
詳細は付属のドキュメントまたは[【運命の洞窟】へのガイド](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E3%82%AC%E3%82%A4%E3%83%89.md)のオプションの項目を参照してください。  
## Tips
スコアファイルはカレントディレクトリに作成される仕様ですが、jRogueを起動する前にスコアファイルがあるディレクトリに移動するのは面倒です。そこで以下のような記述を .bashrc に追加すればjRogueの起動時のみ一時的に書類フォルダに移動するようになるのでスコアファイルを書類フォルダに決め打ちすることができます。引数も普通に使えます。jRogueが終了すれば自動的に元のディレクトリに戻ります。
```sh
function myjrogue() { pushd ~/Documents/; jrogue $@; popd; }
alias jrogue=myjrogue
```
これの応用で、環境変数も含めて以下のように .bashrc に記述すると、GUI版の通常モードの設定かつメッセージが簡潔表示になってゲームがサクサク進み、スコアが書類フォルダに決め打ちになり、ゲームオーバーになっても繰り返しjRogueを遊ぶことが可能になります。Rogueをとことんやりこみたい方にお勧めの設定です。
```sh
export ROGUEOPTS="passgo,color,idscrl,terse"
function myjrogue() {
    pushd ~/Documents/;
    jrogue $@;
    while true;
    do
        clear;
        echo もう一度遊びますか？ \( y または n \);
        read -sn 1 input;
        if [ $input = y ]; then
            jrogue $@;
        elif [ $input = n ];then
            echo それでは、またね。;
            break;
        fi;
    done;
    popd;
}
alias jrogue=myjrogue
```

## 必要環境
[Homebrew](http://brew.sh/index_ja.html)
## 動作確認
macOS High Sierra 10.13
