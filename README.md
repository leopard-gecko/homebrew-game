## jRogue（日本語版 Rogue 5.4）for macOS
Rouge（ローグ）とは1980年に作られた最初期のRPGの一つで、一文字で表現されたキャラクターやプレイするたびにランダムに作られる迷宮などが特徴です。Rogueの最終版といわれるバージョン5.4を日本語化し、macOS Sierraで遊べるようにしてみました。ここにあるのはHomebrew用パッケージの説明ですが、他にGUI版もあります。詳しくは下記のURLを参照してください。

http://leopardgecko.zouri.jp/rogue.html
## インストール方法
```
$ brew tap leopard-gecko/game
$ brew install jrogue
```
ガイドやライセンスなどの各種ドキュメントは「/usr/local/share/doc/jrogue-5.4.5J/」にインストールされます。

和訳したmanページもインストールされますが、Macの標準の環境では日本語のmanページを適切に表示させることができません。他サイトを参照するなどして日本語に対応させると読むことができるようになります。（標準の環境を変えたくない等の場合は、上記ドキュメント内の「jrogue.cat」がmanページと同じものなので、そちらを参照してください）
## 必要環境
[Homebrew](http://brew.sh/index_ja.html)
## 動作確認
macOS Sierra 10.12.2
