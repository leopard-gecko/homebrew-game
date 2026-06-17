## Rogue for macOS（日英・カラー対応版 Rogue 5.4.5jec.050）

Rogue（ローグ）は1980年に作られた最初期のRPGの一つで、一文字で表現されたキャラクター、プレイするたびにランダムに作られる迷宮などが特徴です。

このパッケージは、Rogue 5.4.x 系をもとに、ソースの大まかな形やゲームの流れを Rogue 5.4.4 に近い形で保ちながら、UTF-8による日本語／英語表示、カラー表示、macOS向けのビルド修正を加えたものです。Homebrewには英語版Rogueのパッケージがすでに存在しているため、こちらのパッケージは `jrogue` という名前にしています。

1つの実行ファイルで表示言語を切り替えられます。日本語ロケールでは日本語、それ以外では英語になりますが、ゲーム中での切り替えも随時可能です。Homebrew版では、通常版の `jrogue` と、ウィザードモードを有効にした `jrogue-wizard` を別々のFormulaとして用意しています。

ここにあるのはターミナルで使うCUI版です。クリック操作のみで起動できるGUI版については、下記のURLを参照してください。  
https://leopard-gecko.github.io/jrogue/

## 必要環境

[Homebrew](http://brew.sh/index_ja.html)

## インストール方法

まずtapを追加し、通常版をインストールします。

```sh
brew tap leopard-gecko/game
brew trust leopard-gecko/game
brew install jrogue
```

通常版の `jrogue` は、現代のターミナルで遊びやすい初期設定でビルドされます。初期状態は、カラー有効、通路の角を止まらずに進む、識別の巻き物は1種類、プレイ中のカーソルは非表示です。普通に遊ぶ場合はこちらがおすすめです。

本来のRogueはモノクロで識別の巻き物は5種類ですが、その設定で遊びたい場合は後で述べる環境変数 `ROGUEOPTS`をあらかじめ指定しておくことで可能です。

ウィザードモードありで遊びたい場合は、次のFormulaをインストールします。`jrogue-wizard` は通常版と同じ設定に加えて、ウィザードモードを有効にしてビルドされます。

```sh
brew install jrogue-wizard
```

遊び方やライセンスなどの各種ドキュメントは、以下のドキュメントディレクトリにインストールされます。Apple Silicon環境では、おおむね次の場所になります。

```sh
/opt/homebrew/share/doc/jrogue/
```

Intel環境では、Homebrewのインストール先に応じて次の場所になります。

```sh
/usr/local/share/doc/jrogue/
```

主なドキュメントは以下の通りです。

- `rogue_ja.txt`：日本語の案内書
- `rogue_en.txt`：英語の案内書
- `rogue_ja.html`：日本語HTML版の案内書
- `rogue_en.html`：英語HTML版の案内書
- `README_ja.txt`：ソースからビルドする場合の日本語補足説明
- `README_en.txt`：ソースからビルドする場合の英語補足説明
- `LICENSE.TXT`：ライセンス

manページは、実行ファイル名に合わせて `jrogue.6`、`jrogue-wizard.6` としてインストールされます。

## Formulaの種類

Homebrewのカスタムインストールオプションは使わず、用途別にFormulaを分けています。

| Formula | 実行コマンド | 初期設定 |
| ------- | ------------ | -------- |
| `jrogue` | `jrogue` | カラー有効、`passgo` 有効、識別の巻き物1種類、プレイ中のカーソル非表示 |
| `jrogue-wizard` | `jrogue-wizard` | `jrogue` と同じ便利設定に加えて、ウィザードモードあり |


## 起動方法

通常版は次のように起動します。

```sh
jrogue
```


ウィザードモードありの版は、次のように起動します。

```sh
jrogue-wizard
```

英語表示で起動したい場合は、環境変数 `ROGUE_LANG` を指定します。

```sh
ROGUE_LANG=en jrogue
```

日本語表示で起動したい場合は、次のようにします。

```sh
ROGUE_LANG=ja jrogue
```

保存したゲームを再開する場合は、次のようにします。

```sh
jrogue -r
```

現在のスコアを表示する場合は、次のようにします。

```sh
jrogue -s
```

`jrogue-wizard` を使う場合は、上記の `jrogue` を `jrogue-wizard` に読み替えてください。

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

ソースから直接ビルドする場合は、`./configure` で初期設定を指定できます。例えば、実行ファイル名を `jrogue` にして便利設定を有効にする場合は `./configure --program=jrogue --modern`、初期言語を日本語に固定する場合は `./configure --default-language=ja`、英語に固定する場合は `./configure --default-language=en` を使います。Makefileには互換用として `make japanese`、`make english`、`make modern`、`make wizard`、`make modern-wizard` も残されています。

## 環境変数 ROGUEOPTS

ゲーム内オプションは、環境変数 `ROGUEOPTS` でも設定できます。

例えば、カラー表示、通路の角を止まらずに進む設定、識別の巻き物を1種類にまとめる設定、簡潔なメッセージ表示を有効にし、表示言語を日本語、プレイヤー名を「ブルー・ミーニー」、好きな果物を「🍏 」にしたい場合は、`.zshrc` に以下のように追記します。

```sh
export ROGUEOPTS="passgo,color,idscrl,terse,language=ja,name=ブルー・ミーニー,fruit=🍏 "
```

ターミナルでは絵文字の後の文字が重なって表示されることがあるので、絵文字の後に空白スペースを一つ入れるのがおすすめです。

Rogue本来に近い設定で遊びたい場合は、ゲームを始める前に以下のように指定します。

```sh
export ROGUEOPTS="nocolor,nopassgo,noidscrl,cursor"
```

この設定では、カラー無効、`passgo` 無効、識別の巻き物5種類、プレイ中のカーソル表示ありになります。

この版で追加・変更されている主なオプションは以下の通りです。

- `color`：カラーで表示します。`nocolor` を指定すると無効になります。
- `cursor`：プレイ中のカーソルを表示します。`nocursor` を指定するとプレイ中のカーソルを隠します。
- `idscrl`：識別の巻き物を1種類にまとめます。`noidscrl` を指定するとRogue本来に近い5種類になります。ゲーム開始後は変更できません。
- `language=ja` / `language=en`：表示する言語を指定します。

詳細は付属の案内書の「オプション」の項目を参照してください。

## セーブファイル、スコアファイル、ロックファイル

 `jrogue.save`、`jrogue.scr`、`jrogue.lck` がカレントディレクトリに保存されます。

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

以下のように `.zshrc` に記述すると、書類フォルダへの移動に加え、日本語表示、カラー表示、カーソル無効、識別の巻き物が１種類、簡潔表示、通路を止まらずに進む設定で起動し、ゲーム終了後にもう一度遊ぶかを尋ねるようになります。

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
