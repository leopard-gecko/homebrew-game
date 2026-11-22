# Rogue for macOS — CUIランチャー（rogue-mac）

AppleScriptによるGUI版「Rogue for macOS」のターミナル版です。
Rogue 5.4.5、Clone III、DOS Tribute、3.6、5.2を選択して起動できます。

## 起動

```sh
rogue-mac        # バージョンを選択
rogue-mac 54     # Rogue 5.4.5を直接選択
rogue-mac clone  # Clone III
rogue-mac dos    # DOS Tribute
rogue-mac 36     # Rogue 3.6
rogue-mac 52     # Rogue 5.2
rogue-mac 54 -s  # 指定バージョンに引数を渡す
rogue-mac --help
```

各選択肢は **リターンで確定** します。バージョン選択後、標準セーブが
見つからなければ新規ゲームを開始します。セーブがあれば次の選択肢が出ます。

- `R` または Enter：保存した冒険を再開
- `N`：新しい冒険を始める（古いセーブは削除しない）
- `F`：別のセーブファイルをパスで指定
- `Q`：バージョン選択に戻る

ゲーム終了後は `Y`（同じバージョンでもう一度）、`M`（バージョン選択）、
`N`（終了）を選択できます。`Y` で再起動すると標準セーブの有無を再確認します。
直接ゲームの引数を指定した初回起動のみ、セーブ選択メニューを省略します。

## GUI版と共通の保存先

`~/Library/Application Support/Rogue/` 以下にバージョン別のフォルダを使います。

| バージョン | フォルダ | 標準セーブファイル |
|---|---|---|
| 5.4.5 | `5.4/` | `rogue.save` |
| Clone III | `Clone III/` | `rogue-clone.save` |
| DOS Tribute | `DOS 1.48/` | `rogue-dos.save` |
| 3.6 | `3.6/` | `rogue36.save` |
| 5.2 | `5.2/` | `rogue52.save` |

セーブの内容・再開後のファイル削除は各Rogue本体が扱います。
ランチャーは保存ファイルの移動・変換・削除をしません。
`ROGUEOPTS` はそのまま引き継ぎます。`file=...` 等で標準のセーブ名を
変更している場合は、ランチャーの標準セーブ検出対象と一致しないため注意してください。

GUI版とCUI版の**同時起動で同じセーブファイルを操作しないでください**。
別のセーブファイルを選択するときは、絶対パス・`~/` で始まるパスが使用できます。
相対パスは選択中のバージョンの保存先を基準とします。

## Homebrewへの登録

Formula `rogue-mac.rb` は5種類のRogueを必須の依存関係に指定しています。
このランチャーをHomebrewからインストールできるようにするには、
`leopard-gecko/homebrew-game` に次の2つを配置します。

1. `vrogue-mac.001` というGitHub Releaseを作成し、配布物 `rogue-mac-001.tar.gz` を**変更せず**添付します。
2. タップのルートへ `rogue-mac.rb` を配置します。

`rogue-mac.rb` のSHA-256はこのアーカイブと一致しています。
また、依存先の `rogue54`、`rogue-c3`、`rogue-dos`、`rogue36`、`rogue52` の
FormulaもHomebrew tapに登録してある必要があります。

```sh
brew tap leopard-gecko/game
brew trust leopard-gecko/game
brew install rogue-mac
rogue-mac
```

DOS TributeのFormulaとAppleScriptは、このランチャーのために変更する必要はありません。

## 確認状況

シェル構文検査、Ruby構文検査、仮のゲーム実行ファイルを使った対話操作の
テストを実施しました。macOS上の実Rogue本体やHomebrewでの
インストール・プレイテストは未実施です。
