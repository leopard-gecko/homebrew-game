## Rogue for macOS （日本語／英語切り替え・カラー対応版）

Rogueとは1980年に作られた最初期のRPGの一つで、一文字で表現されたキャラクターやプレイするたびにランダムに作られる迷宮などが特徴です。非常に古いものなのですがなんとも言えない独特の味があり、今遊んでも楽しめるものだと思います。

ここで配布しているパッケージは、Rogueのオリジナル系統の最終形である**バージョン5.4**と、クローン系統の最終形である**クローン・バージョン3**（以下、**Clone III**と表記）です。

Rogueの本流と言うべきバージョンは5.4であり当サイトでもメインとして推していますが、日本ではデータ分離版ローグなどのクローン２の系統が主流です。Clone IIIは日本語版クローン２とほぼ同じ使い勝手のため、従来の日本語版に慣れ親しんでいる方にはClone IIIがおすすめです。

それぞれ、UTF-8による日本語・英語表示切り替え、日本語や絵文字の入力機能、カラー表示、macOS向けの修正などを加えています。Homebrewの公式リポジトリに英語版Rogueのパッケージがすでに存在しているため、こちらのパッケージは `jrogue`  、`jrogue-clone`という名前にしています。

日本語環境では日本語表示、それ以外では英語表示になりますが、環境変数での指定やゲーム中の言語切り替えも可能です。

ここにあるのはターミナルで使うCUI版です。クリック操作のみで起動できるGUI版については、下記のURLを参照してください。5.4とClone IIIの違いについても記載しています。  
https://leopard-gecko.github.io/jrogue/

## 必要環境

[Homebrew](http://brew.sh/index_ja.html)

## インストール方法

tapを追加してインストールします。5.4版は以下の通りです。

```sh
brew tap leopard-gecko/game
brew trust leopard-gecko/game
brew install jrogue
```

5.4版の実行コマンドは `jrogue` です。Homebrew版では遊びやすい初期設定でビルドされます。デフォルトではカラー表示ありで識別の巻き物は１種類になります。本来の歴史的な5.4の設定で遊びたい場合は、後述の環境変数 `ROGUEOPTS`で設定することができます。

Clone III版をインストールする場合は、最後の行を次のようにします。

```sh
brew install jrogue-clone
```

Clone III版の実行コマンドは `jrogue-clone` になります。デフォルトではカラー表示ありで走る時に曲がり角で止まらない設定になります。本来の歴史的なClone IIIの設定で遊びたい場合は、後述の環境変数 `ROGUEOPTS`で設定することができます。

遊び方やライセンスなどの各種ドキュメントは、Homebrewの通常のドキュメントディレクトリにインストールされます。Apple Silicon環境では、おおむね次の場所になります。

```sh
/opt/homebrew/share/doc/jrogue/
```

Rogue Clone III版のドキュメントは、次の場所にインストールされます。

```sh
/opt/homebrew/share/doc/jrogue-clone/
```

Intel環境では、Homebrewのインストール先に応じて `/usr/local/share/doc/` 以下になります。

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

デバッグ用として `jrogue-wizard` というウィザードモードを有効にしたFormulaも用意してありますが、一般向けの機能ではありません。

## 起動方法

次のように起動します。

```sh
jrogue
```

Rogue Clone III版は次のように起動します。

```sh
jrogue-clone
```

5.4版で保存したゲームを再開する場合は、次のようにします。

```sh
jrogue -r
```

Rogue Clone III版で保存したゲームを再開する場合は、次のようにします。

```sh
jrogue-clone rogue-clone.save
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
Rogue Clone III版については、[Clone III用の案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8_clone3.md)を参照してください。  
また、ゲーム中に `?` をタイプすればコマンドのヘルプを表示できます。

移動などのコマンドは英数モードでないと入力できません。ゲーム中にテキストを入力するときには「かな」モードで日本語も入力できますが、ゲームの操作に戻ったら英数モードに切り替えてください。

## 環境変数 ROGUEOPTS

ゲーム内オプションは、環境変数 `ROGUEOPTS` でも設定できます。5.4版とClone III版では共通して使える項目と、片方だけで使う項目があります。

5.4版とClone III版で共通して使う主な項目は以下の通りです。

- `color` / `nocolor`：カラー表示を有効／無効にします。
- `cursor` / `nocursor`：プレイ中のカーソル表示を有効／無効にします。
- `passgo` / `nopassgo`：通路の角で止まらずに進むかどうかを指定します。
- `jump` / `nojump`：走行中の表示を省略するかどうかを指定します。
- `language=ja` / `language=en`：表示する言語を指定します。
- `name=...`：プレイヤー名を指定します。
- `fruit=...`：好きな果物名を指定します。
- `file=...`：セーブファイル名を指定します。

5.4版で使う主な項目は以下の通りです。

- `idscrl` / `noidscrl`：識別の巻き物を1種類にまとめるか、Rogue本来に近い5種類にするかを指定します。ゲーム開始後は変更できません。
- `terse` / `noterse`：メッセージを簡潔にするかどうかを指定します。

Clone III版で使う主な項目は以下の通りです。

- `skull` / `noskull`、または `tombstone` / `notombstone`：死亡時の墓標表示を指定します。
- `askquit` / `noaskquit`：終了時に確認するかどうかを指定します。

5.4版で、カラー表示、通路の角を止まらずに進む設定、識別の巻き物を1種類にまとめる設定、簡潔なメッセージ表示を有効にし、表示言語を日本語、プレイヤー名を「ブルー・ミーニー」、好きな果物を「🍏 」にしたい場合は、`.zshrc` に以下のように追記します。

```sh
export ROGUEOPTS="passgo,color,nocursor,idscrl,terse,language=ja,name=ブルー・ミーニー,fruit=🍏 "
```

Clone III版で、カラー表示、通路の角を止まらずに進む設定、表示言語を日本語、プレイヤー名を「ブルー・ミーニー」、好きな果物を「🍏 」にしたい場合は、以下のように指定します。

```sh
export ROGUEOPTS="passgo,color,nocursor,language=ja,name=ブルー・ミーニー,fruit=🍏 "
```

ターミナルでは絵文字の後の文字が重なって表示されることがあるので、絵文字の後には空白スペースを一つ入れるのがおすすめです。

5.4版を本来の歴史的なRogueに近い設定で遊びたい場合は、以下のように指定します。

```sh
export ROGUEOPTS="nocolor,nopassgo,noidscrl,cursor"
```
この設定では、カラー無効、`passgo` 無効、識別の巻き物5種類、プレイ中のカーソル表示ありになります。ここに `language=en` を加えると英語表示になります。

Clone III版で同様の設定にしたい場合は、以下の通りです。

```sh
export ROGUEOPTS="nocolor,nopassgo,jump,cursor"
```
カラー無効、`passgo` 無効、`jump`有効、プレイ中のカーソル表示ありの設定です。当時のクローン系統では初期設定で`jump`が有効になっているのも特徴の一つです。

詳細は、[【運命の洞窟】への案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8.md)の「オプション」の項目を参照してください。Clone III版については、[Clone III用の案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8_clone3.md)を参照してください。

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

## セーブファイル、スコアファイル、ロックファイル

5.4では `rogue.save`、`rogue.scr`、`rogue.lck` がカレントディレクトリに保存されます。

Rogue Clone IIIでは `rogue-clone.save`、`rogue-clone.scores`、`rogue-clone.lock` です。。

スコアファイルを置く場所を固定したい場合は、Rogueを起動する前に決まったディレクトリへ移動するようにシェル関数を作っておくと便利です。

書類フォルダに移動する例：

```sh
function myjrogue() {
    pushd ~/Documents/ >/dev/null
    jrogue "$@"
    popd >/dev/null
}
alias jrogue=myjrogue
```

スコアファイルの置き場所をGUI版と合わせる場合は、`~/Documents/`を以下のように変更します。
5.4の場合:
```sh
~/Library/Application\ Support/Rogue/5.4
```
Clone IIIの場合:
```sh
~/Library/Application\ Support/Rogue/Clone\ III
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
