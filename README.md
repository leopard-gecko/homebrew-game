# Rogue for macOS（CUI版）

Rogueは、1980年頃に誕生した、文字や記号で描かれた迷宮を探索するコンピューターRPGです。怪物と戦い、道具を使いながら、迷宮の奥に隠された「イェンダーの魔除け」を探します。プレイするたびに迷宮が変わる、いわゆる「ローグライクゲーム」の原点となった作品です。

**Rogue for macOS** には、ターミナルで操作する **CUI版** と、画面上で操作する [**GUI版**](https://leopard-gecko.github.io/jrogue/) があります。**このリポジトリで配布するのはCUI版** です。GUI版は[専用の配布サイト](https://leopard-gecko.github.io/jrogue/)で公開しています。

CUI版では、**Rogueのバージョン違いや派生版を合わせた6つ**（5.4.5、Clone III、DOS Tribute、3.6、5.2、3.4）を選んで遊べます。日本語・英語の切り替え、ゲーム設定の変更、セーブからの再開などに対応しています。Homebrewでランチャー `rogue-mac` をインストールすると、これらのゲームもまとめてインストールされます。

[GUI版「Rogue for macOS」](https://leopard-gecko.github.io/jrogue/) とプレイヤー情報、ゲーム設定、セーブ・スコアファイルを共有できます。各ゲームの特徴や詳しい遊び方、ソースコードについては、[対応するRogue](#対応するrogue) の各リポジトリをご覧ください。

## 必要環境

- macOS
- [Homebrew](https://brew.sh/ja/)

## インストール

ターミナルで以下を実行します。

```sh
brew tap leopard-gecko/game
brew trust leopard-gecko/game
brew install rogue-mac
```

`rogue-mac` とともに、上記の6つのバージョン・派生版がインストールされます。

更新する場合は次のコマンドを使用します。

```sh
brew update
brew upgrade rogue-mac
```

## 起動方法

ターミナルで以下を実行すると、バージョン選択メニューが開きます。

```sh
rogue-mac
```

メニューでは番号・アルファベットを入力し、Returnで確定します。

| 入力 | 操作 |
| --- | --- |
| `1`〜`6` | 遊びたいRogueを選ぶ |
| Returnのみ | 前回選択したRogueを選ぶ |
| `P` | プレイヤー情報を変更 |
| `S` | ゲーム設定を変更 |
| `G` | 案内書をWebブラウザで開く |
| `Q` | ランチャーを終了 |

バージョンを指定して直接起動することもできます。

```sh
rogue-mac 54       # Rogue 5.4.5
rogue-mac clone    # Rogue Clone III
rogue-mac dos      # Rogue DOS Tribute
rogue-mac 36       # Rogue 3.6
rogue-mac 52       # Rogue 5.2
rogue-mac 34       # Rogue 3.4
```

セーブファイルがある場合は、再開するか新しい冒険を始めるかを選べます。案内書の閲覧にはインターネット接続が必要です。

操作方法や設定項目の詳細は、ランチャーのREADMEをご覧ください。

- [使い方（日本語）](README_rogue-mac_ja.md)
- [User guide (English)](README_rogue-mac.md)

## GUI版との連携

[GUI版「Rogue for macOS」](https://leopard-gecko.github.io/jrogue/) とCUI版では、プレイヤー名、好きな果物、ゲーム設定、セーブ・スコアファイルを共有しています。GUI版でセーブした冒険をCUI版で再開でき、その逆も同様です。

セーブファイルは、どちらも `~/Library/Application Support/Rogue/` 以下のバージョン別フォルダに保存されます。

## 対応するRogue

各バージョンの詳しい説明、ゲームの仕様、案内書、ソースコードは、それぞれのリポジトリを参照してください。

| バージョン | 主な特徴 | 単体インストール |
| --- | --- | --- |
| [Rogue 5.4.5 JEC](https://github.com/leopard-gecko/rogue_5.4.5_jec) | 1985年に登場した、Rogueのオリジナル系統の最終版。 | `brew install rogue54` |
| [Rogue Clone III JEC](https://github.com/leopard-gecko/rogue_clone_iii_jec) | 暗い部屋がなく、巻き物や水薬が使用後に基本的に自動識別されるクローン版。 | `brew install rogue-c3` |
| [Rogue DOS Tribute](https://github.com/leopard-gecko/rogue_dos_tribute) | DOS版Rogue 1.48を参考に、怪物・道具・操作・演出を再構成した派生版。 | `brew install rogue-dos` |
| [Rogue 3.6 JEC](https://github.com/leopard-gecko/rogue_3.6_jec) | 初期Rogueの特徴を残し、後期版とは怪物や道具が異なる版。 | `brew install rogue36` |
| [Rogue 5.2 JEC](https://github.com/leopard-gecko/rogue_5.2_jec) | Rogue 5.4より前の版で、怪物・道具やゲームの仕組みに違いがある版。 | `brew install rogue52` |
| [Rogue 3.4 JEC](https://github.com/leopard-gecko/rogue_3.4_jec) | 1981年に発表された、現在入手できる最も古いRogue。 | `brew install rogue34` |

各ゲームだけを利用する場合は、表のコマンドで個別にインストールできます。ソースからのビルド方法やゲーム固有の設定も各リポジトリを参照してください。

Rogue 3.4／3.6では、GUI/CUI共通の「端末表示」で白・緑・アンバーのCRT風配色を選べます。Terminal.appのタブだけを一時的に変更し、プロファイルは作成しません。
