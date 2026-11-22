## Rogue for macOS （日本語／英語切り替え・カラー対応版）

Rogueとは1980年に作られた最初期のRPGの一つで、一文字で表現されたキャラクターやプレイするたびにランダムに作られる迷宮などが特徴です。非常に古いものなのですがなんとも言えない独特の味があり、いま遊んでも楽しめるものだと思います。

ここでは、Rogueのオリジナル系統の最終形である**バージョン5.4**と、クローン系統の最終形である**クローン・バージョン3**（以下、**Clone III**と表記）を中心に、Rogueの複数のバージョンを配布しています。

Rogueの本流と言うべきバージョンは5.4であり当サイトでもメインとして推していますが、日本ではデータ分離版ローグなどのクローン２の系統が主流です。Clone IIIは日本語版クローン２とほぼ同じ使い勝手のため、従来の日本語版に慣れ親しんでいる方にはClone IIIがおすすめです。

このほか、DOS版Rogue 1.48を参考に再構成した**Rogue DOS Tribute**、初期のRogueを代表するバージョンの一つである**Rogue 3.6**、ゲームシステムが5.4とは異なる**Rogue 5.2**も用意しています。

それぞれ、UTF-8による日本語・英語表示切り替え、日本語や絵文字の入力機能、カラー表示、macOS向けの修正などを加えています。Homebrewの公式リポジトリには英語版Rogueのパッケージがすでに存在するため、ここではバージョンを区別できる `rogue54`、`rogue-c3` などの名前にしています。

通常はOSの言語設定に応じて日本語または英語で表示されます。環境変数 `ROGUEOPTS` による指定や、ゲーム中のオプション画面での言語切り替えも可能です。

ここでは各バージョンのRogueを個別に起動できるほか、5種類のRogueを選んで遊べるターミナル用ランチャー「Rogue for macOS」（`rogue-mac`）も用意しています。ランチャーでは、セーブからの再開やゲーム終了後の再プレイに加え、プレイヤー名やゲーム設定の変更もできます。

クリック操作で利用できるAppleScriptによるGUI版「Rogue for macOS」も公開しています。GUI版とターミナル用ランチャーでは、プレイヤー名、好きな果物、最後に選択したバージョン、各バージョンのゲーム設定を共有しています。セーブファイルやスコアファイルの保存先も共通で、どちらからでも同じ冒険を続けられます。各バージョンの違いについても、以下のサイトで紹介しています。  
https://leopard-gecko.github.io/jrogue/

ソースコードはLinuxにも対応しています。Linuxで使いたい方や、Macでソースコードからビルドしたい方は下記のURLも参照してください。  
https://note.com/leopard_gecko_00/n/nee49f7e7cc3f

## 必要環境

[Homebrew](https://brew.sh/ja/)

## インストール方法

最初にtapを追加します。

```sh
brew tap leopard-gecko/game
brew trust leopard-gecko/game
```

5種類のRogueをまとめてインストールし、メニューから選んで遊んだり、設定を変更したりする場合は、ランチャー `rogue-mac` をインストールします。

```sh
brew install rogue-mac
```

ランチャーのインストール時に、Rogue 5.4.5、Clone III、DOS Tribute、3.6、5.2も依存関係として自動的にインストールされます。起動コマンドは `rogue-mac` です。

ランチャーを使用せず、各バージョンを個別にインストールすることもできます。

| バージョン | インストールコマンド |
| --- | --- |
| Rogue 5.4.5 | `brew install rogue54` |
| Rogue Clone III | `brew install rogue-c3` |
| Rogue DOS Tribute | `brew install rogue-dos` |
| Rogue 3.6 | `brew install rogue36` |
| Rogue 5.2 | `brew install rogue52` |

ランチャーを使用せずに5種類をまとめてインストールする場合は、次のようにします。

```sh
brew install rogue54 rogue-c3 rogue-dos rogue36 rogue52
```

5.4版の実行コマンドは `rogue54` です。デフォルトではカラー表示、通路の角で止まらずに進む設定、識別の巻き物を１種類にまとめる設定が有効で、プレイ中のカーソルは非表示になります。本来の歴史的な5.4の設定で遊びたい場合は、後述の環境変数 `ROGUEOPTS` で設定することができます。

Clone III版の実行コマンドは `rogue-c3` です。デフォルトではカラー表示と通路の角で止まらずに進む設定が有効で、`jump` は無効、プレイ中のカーソルは非表示になります。本来の歴史的なClone IIIの設定で遊びたい場合は、後述の環境変数 `ROGUEOPTS` で設定することができます。

DOS Tribute、3.6、5.2の初期設定については、それぞれのリポジトリのREADMEや案内書をご覧ください。各Formulaは、それぞれのソースコードリポジトリで公開されたReleaseから取得してビルドします。

以前の `jrogue`、`jrogue-clone`、`jrogue-wizard` は、それぞれ `rogue54`、`rogue-c3`、`rogue54-wizard` に名称を変更しました。旧Formulaをインストール済みの場合は、`brew update` の後、必要に応じて `brew migrate jrogue` などで移行してください。実行ファイル名も変わるため、移行後は再インストールをおすすめします。

## 起動方法

### ターミナル用ランチャー（rogue-mac）

`rogue-mac` は、ターミナルからRogueのバージョンを選択して起動し、ゲーム設定も変更できるランチャーです。AppleScriptによるGUI版「Rogue for macOS」と設定やセーブ・スコアファイルの保存先を共有します。

```sh
rogue-mac
```

メインメニューでは次の操作ができます。各選択肢は入力後にReturnで確定します。

| 入力 | 動作 |
| --- | --- |
| `1`〜`5` | 冒険するバージョンを選択 |
| Returnのみ | GUI版またはランチャーで前回選択したバージョンを選択 |
| `P` | プレイヤー名と好きな果物を設定 |
| `G` | 「【運命の洞窟】への案内書」をWebで開く |
| `S` | 各バージョンのゲームモード、表示言語、各種オプションを設定 |
| `Q` | ランチャーを終了 |

メニューには「Return：前回選択した Rogue 3.6 を起動」のように、現在の既定バージョンが表示されます。これは最後に**選択した**バージョンであり、必ずしも最後にゲームを実際に開始したバージョンではありません。

ゲーム設定では、バージョンごとにモダン／クラシック／細かく設定を選べます。カラー表示や曲がり角での動作など、変更できる項目はバージョンによって異なります。GUI版で変更した設定も反映されます。

`G` では案内書のバージョンを `1`〜`5` で選び、標準のWebブラウザで開けます。Returnのみで前回選択したバージョンの案内書を開き、`B` でメインメニューに戻ります。案内書を閲覧しても、ゲームの選択履歴や設定は変更されません。

バージョンを選ぶと、標準のセーブファイルがない場合は新しいゲームを開始し、セーブファイルがある場合は次の操作を選べます。

| 入力 | 動作 |
| --- | --- |
| `R` またはReturn | セーブから再開 |
| `N` | 新しい冒険を始める（既存のセーブは削除しない） |
| `F` | 別のセーブファイルをパスで指定 |
| `Q` | バージョン選択に戻る |

ゲーム終了後は、`Y` で同じバージョンをもう一度起動、`M` でメインメニューに戻る、`N` でランチャーを終了します。`Y` を選んだ場合はセーブファイルの有無を再確認します。終了時には「それでは、またね。」（英語表示では `See you again.`）と表示します。

バージョンを引数で直接指定することもできます。

```sh
rogue-mac 54
rogue-mac clone
rogue-mac dos
rogue-mac 36
rogue-mac 52
```

設定項目や操作方法の詳細については、ランチャーに付属する日本語・英語READMEを参照してください。

### 各バージョンを直接起動する場合

各バージョンをランチャーを使わずに直接起動する場合は、次のコマンドを使用します。

| バージョン | 起動コマンド |
| --- | --- |
| Rogue 5.4.5 | `rogue54` |
| Rogue Clone III | `rogue-c3` |
| Rogue DOS Tribute | `rogue-dos` |
| Rogue 3.6 | `rogue36` |
| Rogue 5.2 | `rogue52` |

セーブしたゲームの再開方法はバージョンによって異なります。5.4版で保存したゲームを再開する場合は、次のようにします。

```sh
rogue54 -r
```

Rogue Clone III版で保存したゲームを再開する場合は、次のようにします。

```sh
rogue-c3 rogue-clone.save
```

5.4版で現在のスコアを表示する場合は、次のようにします。

```sh
rogue54 -s
```

ゲームオーバー時の墓標を表示する場合は、次のようにします。

```sh
rogue54 -d
```

DOS Tribute、3.6、5.2でのセーブ再開やコマンドラインオプションについては、各バージョンのREADMEを参照してください。

## ドキュメント

遊び方やライセンスなどの各種ドキュメントは、Homebrewのドキュメントディレクトリにバージョン別にインストールされます。Apple Silicon環境では、おおむね次の場所になります。

```text
/opt/homebrew/share/doc/
├── rogue-mac/
├── rogue54/
├── rogue-c3/
├── rogue-dos/
├── rogue36/
└── rogue52/
```

Intel環境では、Homebrewのインストール先に応じて `/usr/local/share/doc/` 以下になります。

ランチャーには日本語・英語のREADME（`README_rogue-mac_ja.md`、`README_rogue-mac.md`）が付属します。各ゲームにはREADME、【運命の洞窟】への案内書、ライセンスなどが収録されます。案内書がHTML、TXT、Markdownのどの形式で付属するかは、バージョンによって異なります。5.4、DOS Tributeなどのmanページも、それぞれの実行ファイル名でインストールされます。

## 遊び方

5.4版の詳細は付属のドキュメント、または[【運命の洞窟】への案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8.md)を参照してください。  
Rogue Clone III版については、[Clone III用の案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8_clone3.md)を参照してください。

その他のバージョンについては、それぞれのリポジトリに案内書やREADMEがあります。

- [Rogue DOS Tribute](https://github.com/leopard-gecko/rogue_dos_tribute)
- [Rogue 3.6](https://github.com/leopard-gecko/rogue_3.6_jec)
- [Rogue 5.2](https://github.com/leopard-gecko/rogue_5.2_jec)

また、ゲーム中に `?` をタイプすればコマンドのヘルプを表示できます。

移動などのコマンドは英数モードでないと入力できません。ゲーム中にテキストを入力するときには「かな」モードで日本語も入力できますが、ゲームの操作に戻ったら英数モードに切り替えてください。

## 環境変数 ROGUEOPTS

`rogue-mac` ランチャーを使用する場合は、メニューの `S`（ゲーム設定）から各バージョンのオプションを変更できます。AppleScript版とも設定を共有するため、通常は環境変数を直接編集する必要はありません。新しい冒険を始めるときは共有設定から `ROGUEOPTS` を生成し、セーブから再開するときは原則として言語指定のみを渡して保存済みの設定を優先します。

以下は、`rogue54` や `rogue-c3` などのコマンドでゲームを**直接起動する場合**に使う環境変数 `ROGUEOPTS` の説明です。対応するオプションはバージョンによって異なります。ここでは5.4版とClone III版を説明し、DOS Tribute、3.6、5.2についてはそれぞれの案内書に譲ります。

5.4版とClone III版で共通して使う主な項目は以下の通りです。

- `color` / `nocolor`：カラー表示を有効／無効にします。
- `cursor` / `nocursor`：プレイ中のカーソル表示を有効／無効にします。
- `passgo` / `nopassgo`：通路の角で止まらずに進むかどうかを指定します。
- `jump` / `nojump`：走行中の表示を省略するかどうかを指定します。
- `language=auto` / `language=ja` / `language=en`：表示する言語を指定します。`auto` ではOSの言語設定が反映されます。
- `name=...`：プレイヤー名を指定します。
- `fruit=...`：好きな果物名を指定します。
- `file=...`：セーブファイル名を指定します。
- `tombstone` / `notombstone`：死亡時の画面（5.4版では墓標、Clone III版では骸骨）を表示するかどうかを指定します。

5.4版のみで使う項目は以下の通りです。

- `idscrl` / `noidscrl`：識別の巻き物を1種類にまとめるか、Rogue 5.4の元々の設定である5種類にするかを指定します。ゲーム開始後は変更できません。
- `terse` / `noterse`：メッセージを簡潔にするかどうかを指定します。

Clone III版のみで使う項目は以下の通りです。

- `skull` / `noskull`：死亡時の骸骨表示を指定します。`tombstone` / `notombstone` でも指定できます。
- `askquit` / `noaskquit`：終了時に確認するかどうかを指定します。

5.4版で、カラー表示、通路の角を止まらずに進む設定、識別の巻き物を1種類にまとめる設定、簡潔なメッセージ表示を有効にし、表示言語を日本語、プレイヤー名を「ブルー・ミーニー」、好きな果物を「🍏 」にしたい場合は、起動時に次のように指定できます。

```sh
ROGUEOPTS="passgo,color,nocursor,idscrl,terse,language=ja,name=ブルー・ミーニー,fruit=🍏 " rogue54
```

Clone III版で、カラー表示、通路の角を止まらずに進む設定、表示言語を日本語、プレイヤー名を「ブルー・ミーニー」、好きな果物を「🍏 」にしたい場合は、次のように指定します。

```sh
ROGUEOPTS="passgo,color,nocursor,language=ja,name=ブルー・ミーニー,fruit=🍏 " rogue-c3
```

複数のRogueを使う場合、各ゲーム専用のオプションをすべてのゲームに適用しないように、上の例では起動時のみ `ROGUEOPTS` を指定しています。特定のバージョンだけを使う場合は、`.zshrc` に `export ROGUEOPTS="..."` を書いて常時指定しても構いません。

ターミナルでは絵文字の後の文字が重なって表示されることがあるので、絵文字の後には空白スペースを一つ入れるのがおすすめです。

5.4版を本来の歴史的なRogueに近い設定で遊びたい場合は、以下のように指定します。

```sh
ROGUEOPTS="nocolor,nopassgo,noidscrl,cursor" rogue54
```

この設定では、カラー無効、`passgo` 無効、識別の巻き物5種類、プレイ中のカーソル表示ありになります。ここに `language=en` を加えると英語表示になります。

Clone III版で同様の設定にしたい場合は、以下の通りです。

```sh
ROGUEOPTS="nocolor,nopassgo,jump,cursor" rogue-c3
```

カラー無効、`passgo` 無効、`jump` 有効、プレイ中のカーソル表示ありの設定です。当時のクローン系統では初期設定で `jump` が有効になっているのも特徴の一つです。

詳細は、[【運命の洞窟】への案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8.md)の「オプション」の項目を参照してください。Clone III版については、[Clone III用の案内書](https://github.com/leopard-gecko/homebrew-game/blob/master/%E9%81%8B%E5%91%BD%E3%81%AE%E6%B4%9E%E7%AA%9F%E3%81%B8%E3%81%AE%E6%A1%88%E5%86%85%E6%9B%B8_clone3.md)を参照してください。

## セーブファイル、スコアファイル、ロックファイル

今回のFormulaでは、各バージョンで次のファイル名を使用します。

| バージョン | セーブファイル | スコアファイル | ロックファイル |
| --- | --- | --- | --- |
| Rogue 5.4.5 | `rogue.save` | `rogue.scr` | 専用ファイルなし |
| Rogue Clone III | `rogue-clone.save` | `rogue-clone.scores` | `rogue-clone.lock` |
| Rogue DOS Tribute | `rogue-dos.save` | `rogue-dos.scr` | `rogue-dos.lck` |
| Rogue 3.6 | `rogue36.save` | `rogue36.scr` | `rogue36.lock` |
| Rogue 5.2 | `rogue52.save` | `rogue52.scr` | 専用ファイルなし |

各ゲームを `rogue54` などのコマンドで直接起動した場合は、原則として起動時の作業ディレクトリに保存されます。5.4とClone IIIは、実行コマンド名を変更しても、既存のセーブ・スコアファイル名を維持しています。

一方、ランチャー `rogue-mac` から起動した場合は、GUI版「Rogue for macOS」と同じ保存先を使用します。以下のフォルダはすべて `~/Library/Application Support/Rogue/` 以下です。

| バージョン | GUI版・ターミナル用ランチャー共通の保存先 |
| --- | --- |
| Rogue 5.4.5 | `5.4/` |
| Rogue Clone III | `Clone III/` |
| Rogue DOS Tribute | `DOS 1.48/` |
| Rogue 3.6 | `3.6/` |
| Rogue 5.2 | `5.2/` |

GUI版とターミナル用ランチャーは同じセーブ・スコアファイルを使用します。同じバージョンを両方から同時に起動して、同じセーブファイルを操作しないでください。なお、`ROGUEOPTS` の `file=...` などで標準のセーブファイル名を変更した場合は、ランチャーがそのファイルを自動検出できないことがあります。

直接起動する場合にスコアファイルの場所を固定したいときは、起動前に決まったディレクトリへ移動するシェル関数を作っておくと便利です。

5.4版で書類フォルダに移動する例：

```sh
function myrogue54() {
    pushd ~/Documents/ >/dev/null
    rogue54 "$@"
    popd >/dev/null
}
alias rogue54=myrogue54
```

## ウィザードモード

5.4のウィザードモードを有効にしてインストールしたい場合は以下のようにします。これは一般向けではなく基本的にデバッグ用ですので、普通に遊ぶ分には必要ありません。

```sh
brew install rogue54-wizard
```

## 動作確認

macOS Golden Gate 27.2.1

