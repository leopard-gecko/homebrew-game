## Rogue for macOS（日英・カラー対応版 Rogue 5.4.5jec.050）

Rogue（ローグ）は1980年に作られた最初期のRPGの一つで、一文字で表現されたキャラクター、プレイするたびにランダムに作られる迷宮などが特徴です。

このパッケージは、Rogue 5.4.x 系をもとに、ソースの大まかな形やゲームの流れを Rogue 5.4.4 に近い形で保ちながら、UTF-8による日本語／英語表示、カラー表示、macOS向けのビルド修正を加えたものです。Homebrewには英語版Rogueのパッケージがすでに存在しているため、こちらのパッケージは `jrogue` という名前にしています。

1つの実行ファイルで表示言語を切り替えられます。日本語ロケールでは日本語、それ以外では英語になりますが、ゲーム中での切り替えも随時可能です。

ここにあるのはターミナルで使うCUI版です。クリック操作のみで起動できるGUI版については、下記のURLを参照してください。  
https://leopard-gecko.github.io/jrogue/

## 必要環境

[Homebrew](http://brew.sh/index_ja.html)

## インストール方法

tapを追加してインストールします。

```sh
brew tap leopard-gecko/game
brew trust leopard-gecko/game
brew install jrogue
```

Homebrew版の `jrogue` は、現代のターミナルで遊びやすい初期設定でビルドされます。初期状態はカラー有効、`passgo` 有効、識別の巻き物1種類、プレイ中のカーソル非表示です。普通に遊ぶ場合はこちらがおすすめです。

本来のRogueはモノクロで識別の巻き物は5種類ですが、その設定で遊びたい場合は後で述べる環境変数 `ROGUEOPTS`をあらかじめ指定しておくことで可能です。

遊び方やライセンスなどの各種ドキュメントは、Homebrewの通常のドキュメントディレクトリにインストールされます。Apple Silicon環境では、おおむね次の場所になります。

```sh
/opt/homebrew/share/doc/jrogue/
```

Intel環境では、Homebrewのインストール先に応じて次の場所になります。

```sh
/usr/local/share/doc/jrogue/
```

主なドキュメントは以下の通りです。

- `rogue_ja.txt`：【運命の洞窟】への案内書（日本語）
- `rogue_en.txt`：【運命の洞窟】への案内書（英語）
- `rogue_ja.html`：上記のHTML版（日本語）
- `rogue_en.html`：上記のHTML版（英語）
- `README_ja.txt`：ソースからビルドする場合の補足説明（日本語）
- `README_en.txt`：ソースからビルドする場合の補足説明（英語）
- `LICENSE.TXT`：ライセンス

manページは `jrogue.6` としてインストールされます。

## Formulaについて

通常は `jrogue` をインストールしてください。デバッグ用として `jrogue-wizard` というFormulaもありますが、一般向けの機能ではありません。

## 起動方法

次のように起動します。

```sh
jrogue
```

保存したゲームを再開する場合は、次のようにします。

```sh
jrogue -r
```

現在のスコアを表示する場合は、次のようにします。

```sh
jrogue -s
```
ゲームオーバー時の墓標を表示する場合は、次のようにします。

```sh
jrogue -d
```

## 遊び方

詳細は付属のドキュメント、または[【運命の洞窟】への案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8.md)を参照してください。  
また、ゲーム中に `?` をタイプすればコマンドのヘルプを表示できます。

移動などのコマンドは英数モードでないと入力できません。ゲーム中にテキストを入力するときには「かな」モードで日本語も入力できますが、ゲームの操作に戻ったら英数モードに切り替えてください。

## 表示する言語

表示する言語は、以下の順で決まります。

1. `ROGUE_LANG` が `ja` または `en` の場合は、それを優先します。
2. `ROGUE_LANG` が指定されていない場合は、`LC_ALL`、`LC_MESSAGES`、`LANG` の順にロケールを調べます。日本語ロケールでは日本語、それ以外では英語になります。
3. ゲーム中のオプション画面で `language` を変更すると、以後のメッセージや表示名が選択した言語で再生成されます。

例：

```sh
ROGUE_LANG=ja jrogue
ROGUE_LANG=en jrogue
```

## 環境変数 ROGUEOPTS

ゲーム内オプションは、環境変数 `ROGUEOPTS` でも設定できます。

例えば、カラー表示、通路の角を止まらずに進む設定、識別の巻き物を1種類にまとめる設定、簡潔なメッセージ表示を有効にし、表示言語を日本語、プレイヤー名を「ブルー・ミーニー」、好きな果物を「🍏 」にしたい場合は、`.zshrc` に以下のように追記します。

```sh
export ROGUEOPTS="passgo,color,idscrl,terse,language=ja,name=ブルー・ミーニー,fruit=🍏 "
```

ターミナルでは絵文字の後の文字が重なって表示されることがあるので、絵文字の後には空白スペースを一つ入れるのがおすすめです。

現代的ではない本来のRogueに近い設定で遊びたい場合は、以下のように指定します。

```sh
export ROGUEOPTS="nocolor,nopassgo,noidscrl,cursor"
```

この設定では、カラー無効、`passgo` 無効、識別の巻き物5種類、プレイ中のカーソル表示ありになります。ここに`language=en`を加えると英語表示になり、昔のRogueそのものと言って良い設定になります。

この版で追加されている主なオプションは以下の通りです。

- `color`：カラーで表示します。`nocolor` を指定すると無効になります。
- `cursor`：プレイ中のカーソルを表示します。`nocursor` を指定するとプレイ中のカーソルを隠します。
- `idscrl`：識別の巻き物を1種類にまとめます。`noidscrl` を指定するとRogue本来に近い5種類になります。ゲーム開始後は変更できません。
- `language=ja` / `language=en`：表示する言語を指定します。

詳細は、[【運命の洞窟】への案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8.md)の「オプション」の項目を参照してください。

## セーブファイルとスコアファイル

標準では `jrogue.save`、`jrogue.scr`、`jrogue.lck` を使います。

スコアファイルを置く場所を固定したい場合は、jRogueを起動する前に決まったディレクトリへ移動するようにシェル関数を作っておくと便利です。

例：

```sh
function myjrogue() {
    pushd ~/Documents/ >/dev/null
    jrogue "$@"
    popd >/dev/null
}
alias jrogue=myjrogue
```

## Tips：くり返し遊ぶための設定例

以下のように `.zshrc` に記述すると、書類フォルダに移動し、日本語表示、カラー表示、カーソル無効、識別の巻き物が１種類、簡潔表示、通路を止まらずに進む設定で起動し、ゲーム終了後にもう一度遊ぶかを尋ねるようになります。

```sh
export ROGUEOPTS="passgo,color,nocursor,idscrl,terse,language=ja"

function myjrogue() {
    pushd ~/Documents/ >/dev/null
    while true; do
        jrogue "$@"
        echo "もう一度遊びますか？ (y または n)"
        read -r -k 1 input
        echo
        if [ "$input" = "y" ]; then
            set --
            continue
        else
            echo "それでは、またね。"
            break
        fi
    done
    popd >/dev/null
}
alias jrogue=myjrogue
```

bashの場合は、キー入力部分を次のようにします。

```sh
read -r -n 1 input
```

## 動作確認

macOS Tahoe 26.5
