## Rogue for macOS（日英・カラー対応版 Rogue 5.4.5jec.050）

Rogue（ローグ）は1980年に作られた最初期のRPGの一つで、一文字で表現されたキャラクター、プレイするたびにランダムに作られる迷宮などが特徴です。

このパッケージは、Rogue 5.4.x 系をもとに、ソースの大まかな形やゲームの流れを Rogue 5.4.4 に近い形で保ちながら、UTF-8による日本語／英語表示、カラー表示、macOS向けのビルド修正を加えたものです。Homebrewには英語版Rogueのパッケージがすでに存在しているため、こちらのパッケージは `jrogue` という名前にしています。

現在の版では、日本語版と英語版を別々にビルドするのではなく、1つの実行ファイルで表示言語を切り替えられます。`ROGUE_LANG=ja` または `ROGUE_LANG=en` で起動時の言語を指定でき、ゲーム中のオプション画面でも `language` を変更できます。プレイヤー名やアイテムの呼び名など、ユーザーが入力した文字列はUTF-8文字列として保存されます。

表示言語は実行時に決まり、`ROGUE_LANG` が指定されていない場合は `LC_ALL`、`LC_MESSAGES`、`LANG` を参照し、日本語ロケールでは日本語、それ以外では英語になります。Homebrewのインストール時に `--with-japanese` または `--with-english` を指定すると、ロケールに関係なく初期言語を固定できます。

ここにあるのはターミナルで使うCUI版です。クリック操作のみで起動できるGUI版については、下記のURLを参照してください。  
https://leopard-gecko.github.io/jrogue/

## 必要環境

[Homebrew](http://brew.sh/index_ja.html)

## インストール方法

```sh
brew tap leopard-gecko/game
brew install jrogue
```

通常の `brew install jrogue` では、歴史的な本来のRogueに近い初期設定でビルドされます。初期状態はカラー無効、`passgo` 無効、識別の巻き物5種類、プレイ中のカーソル表示ありです。

カラー有効、`passgo` 有効、識別の巻き物1種類、プレイ中のカーソル非表示を初期設定にしたい場合は、次のようにインストールします。普通に遊ぶ場合はこちらがおすすめです。

```sh
brew install jrogue --with-modern-settings
```

遊び方やライセンスなどの各種ドキュメントは、Homebrewの通常のドキュメントディレクトリにインストールされます。Apple Silicon環境では、おおむね次の場所になります。

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

manページは `jrogue.6` としてインストールされます。

## インストール時のオプション

以下のコマンドで、指定できるインストールオプションを確認できます。

```sh
brew options jrogue
```

例：

```sh
brew install jrogue --with-modern-settings
brew install jrogue --with-japanese
brew install jrogue --with-english
brew install jrogue --with-wizardmode
brew install jrogue --with-modern-settings --with-japanese
brew install jrogue --with-modern-settings --with-wizardmode
```

- `--with-modern-settings` は、現代のターミナルで遊びやすい初期設定でビルドするためのオプションです。初期状態がカラー表示、`passgo` 有効、識別の巻き物1種類、プレイ中のカーソル非表示になります。表示言語は固定されず、通常ビルドと同じく `ROGUE_LANG` またはロケールで決まります。Homebrew formulaの内部では `./configure --modern` に対応します。
- `--with-japanese` は、`ROGUE_LANG` を指定しない場合でも、日本語を初期言語として起動するようにビルドするためのオプションです。Homebrew formulaの内部では `./configure --default-language=ja` に対応します。日本語環境をお使いの方は自動で日本語表記になるため、通常はこれを指定する必要はありません。
- `--with-english` は、`ROGUE_LANG` を指定しない場合でも、英語を初期言語として起動するようにビルドするためのオプションです。Homebrew formulaの内部では `./configure --default-language=en` に対応します。英語環境をお使いの方は通常これを指定する必要はありません。
- `--with-wizardmode` は、ウィザードモードありでビルドするためのオプションです。Homebrew formulaの内部では `./configure --wizard` に対応します。これは基本的にデバッグ用のモードなので、詳細はここには記載しません。

`--with-japanese` と `--with-english` は同時には指定できません。`--with-modern-settings` や `--with-wizardmode` と組み合わせた場合は、Homebrew formula側で対応する `./configure` オプションを同時に指定してビルドします。

以前の版にあった `--without-bg2black` と `--without-invcursor` は、この版では使いません。背景色は `color` オプションが有効なときだけ黒系の背景に切り替わり、カーソル表示はゲーム内オプションの `cursor` で変更できます。

## 起動方法

```sh
jrogue
```

プレイヤーの名前を変えたい場合は、`-n` で指定します。

```sh
jrogue -n 名前
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

## 遊び方

詳細は付属のドキュメント、または[【運命の洞窟】への案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8.md)を参照してください。  
また、ゲーム中に `?` をタイプすればコマンドのヘルプを表示できます。

移動などのコマンドは英数モードでないと入力できません。ゲーム中にテキストを入力するときには「かな」モードで日本語も入力できますが、ゲームの操作に戻ったら英数モードに切り替えてください。

## 表示する言語

表示する言語は、以下の順で決まります。

1. `ROGUE_LANG` が `ja` または `en` の場合は、それを優先します。
2. `ROGUE_LANG` が指定されていない場合、`--with-japanese` ビルドでは日本語、`--with-english` ビルドでは英語が初期言語になります。
3. `ROGUE_LANG` が指定されておらず、言語固定ビルドでもない場合は、`LC_ALL`、`LC_MESSAGES`、`LANG` の順にロケールを調べます。日本語ロケールでは日本語、それ以外では英語になります。
4. ゲーム中のオプション画面で `language` を変更すると、以後のメッセージや表示名が選択した言語で再生成されます。

例：

```sh
ROGUE_LANG=ja jrogue
ROGUE_LANG=en jrogue
```

ソースから直接ビルドする場合は、`./configure` で初期設定を指定できます。例えば、実行ファイル名を `jrogue` にして便利設定を有効にする場合は `./configure --program=jrogue --modern`、初期言語を日本語に固定する場合は `./configure --default-language=ja`、英語に固定する場合は `./configure --default-language=en` を使います。Homebrewでは、それぞれ `--with-modern-settings`、`--with-japanese`、`--with-english` に対応します。Makefileには互換用として `make japanese`、`make english`、`make modern`、`make wizard`、`make modern-wizard` も残されています。

## 環境変数 ROGUEOPTS

ゲーム内オプションは、環境変数 `ROGUEOPTS` でも設定できます。

例えば、通常ビルドのまま、カラー表示、通路の角を止まらずに進む設定、識別の巻き物を1種類にまとめる設定、簡潔なメッセージ表示を有効にし、表示言語を日本語、プレイヤー名を「ブルー・ミーニー」、好きな果物を「🍏 」にしたい場合は、`.zshrc` に以下のように追記します。

```sh
export ROGUEOPTS="passgo,color,idscrl,terse,language=ja,name=ブルー・ミーニー,fruit=🍏 "
```

ターミナルでは絵文字の後の文字が重なって表示されることがあるので、絵文字の後に空白スペースを一つ入れるのがおすすめです。

この版で追加・変更されている主なオプションは以下の通りです。

- `color`：カラーで表示します。通常ビルドでは無効、`--with-modern-settings` では有効が初期値です。
- `cursor`：プレイ中のカーソルを表示します。通常ビルドでは有効、`--with-modern-settings` では `@` を見やすくするため無効が初期値です。
- `idscrl`：識別の巻き物を1種類にまとめます。ゲーム開始後は変更できません。通常ビルドでは無効、`--with-modern-settings` では有効が初期値です。
- `language=ja` / `language=en`：表示する言語を指定します。

詳細は付属の案内書の「オプション」の項目を参照してください。

## セーブファイルとスコアファイル

Homebrew版では `./configure --program=jrogue` でビルドされるため、デフォルトのファイル名は以下の通りです。

- セーブファイル：`jrogue.save`
- スコアファイル：`jrogue.scr`
- ロックファイル：`jrogue.lck`

ソースから何も指定せずにビルドした場合は、実行ファイル名が `rogue` になり、各ファイル名も `rogue.save`、`rogue.scr`、`rogue.lck` になります。`./configure --program=名前` または `make PROGRAM=名前` を使うと、実行ファイル名に連動して標準のセーブファイル、スコアファイル、ロックファイル名も変わります。必要に応じて、`./configure --save-file=ファイル名`、`--score-file=ファイル名`、`--lock-file=ファイル名` で個別に指定することもできます。

これらは基本的にカレントディレクトリに作成されます。スコアファイルを置く場所を固定したい場合は、jRogueを起動する前に決まったディレクトリへ移動するようにシェル関数を作っておくと便利です。

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

以下のように `.zshrc` に記述すると、通常ビルドでも、日本語表示、カラー表示、カーソル無効、識別の巻き物が１種類、簡潔表示、通路を止まらずに進む設定で起動し、ゲーム終了後にもう一度遊ぶかを尋ねるようになります。

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
