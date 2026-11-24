# 第5-A／第5-B段階 — macOS / Homebrew / GUI共有設定の実機確認

このファイルは `rogue-mac` 0.3.25として第5-B修正を加えたソースの**Mac実機で行うための確認手順**です。ここでの静的テストはLinux上で行っています。macOS実機で動作確認済みという意味ではありません。

## 1. 公開前にできる確認

ZIPを解凍し、MacのTerminal.appで解凍先へ移動して以下を実行します。

```sh
sh ./macos-check.sh --launcher ./rogue-mac
```

- `rogue-mac --version` / `--help` / `--list` / `--show-rogueopts`、5つのゲーム本体のコマンド、共有設定ドメインを確認します。
- スクリプトは**共有設定を書き換えず**、ゲームを起動せず、既存セーブを削除・変更しません。
- プレイヤー名、果物名、ROGUEOPTSの内容を表示しません。`PASS` は検査した項目、`WARN` は不足・未設定・確認不能、`FAIL` は検査失敗です。
- 共有設定のキーが未設定でも異常とは限りません。GUI/CUIでその項目を保存したことがない場合は正常です。
- `--launcher` を省略すると、PATHで見つかった `rogue-mac` を優先して検査します。今回の修正版を検査する場合は上記のように `./rogue-mac` を明示してください。

## 2. 028 Release候補とHomebrew更新の確認

公開済み `vrogue-mac.027` は旧版 `0.3.24` を指し、第5-B修正は含まれません。今回の `vrogue-mac.028` / `0.3.25` は**公開準備用の候補**です。アップロード後にHomebrew Formulaを更新してください。

1. `rogue-mac-028.tar.gz` のSHA-256が `rogue-mac.rb` の `sha256` と一致することを確認します。
2. Mac実機でこのフォルダの `./rogue-mac` を使い、下記の対話式操作と5.2の`jump`設定を確認します。
3. GitHub Release `vrogue-mac.028` を公開し、`rogue-mac-028.tar.gz` を添付します。
4. tap `leopard-gecko/homebrew-game` のルートにある `rogue-mac.rb` を更新します。
5. Macで以下を実行します。既にインストール済みなら `brew upgrade`、初めてなら `brew install` を使用します。

```sh
brew update
brew upgrade leopard-gecko/game/rogue-mac
brew test leopard-gecko/game/rogue-mac
rogue-mac --version
sh ./macos-check.sh --brew-test
```

`rogue-mac --version` の期待値は `rogue-mac 0.3.25` です。`brew test` に成功しても、GUIの設定往復やゲーム本体の実動作については別途確認が必要です。

## 3. 手動確認（1台のMacで行う）

1. Terminal.appを**明るい背景**に設定し、展開先で `sh ./rogue-mac` を起動。メニュー文字の背後に不自然な背景色の帯がないこと。`Q` で抜けると画面が消去され、端末本来の背景色で「それでは、またね。」が出ること。
2. `sh ./rogue-mac --mono` では端末既定色が使用されること。
3. GUI版を起動し、最後に選択したバージョンを5.2などへ変更して終了。CUI起動後にReturnで**同じバージョン**を選ぶこと（起動前のセーブは適切にバックアップ）。
4. GUI版でプレイヤー名・果物を変更して終了し、CUIで `P` に表示されること。CUIで変更した結果が、GUI版を**再起動したとき**に反映されること。変更後は元の名前・果物へ戻してください。
5. GUI版で各バージョンの言語とモードを変更し、CUI `S` の表示に反映されること。反対方向の変更も同様に確認。共有設定の初期値には勝手に書き込まれないこと。
6. 5.4 / Clone III / DOS Tribute / 3.6 / 5.2 の順に起動・終了。新規ゲーム、標準セーブからの再開、ファイル名指定、終了後 `Y` / `M` / `N` の動作を確認。**既存セーブ・スコアの破損を避けるため、別途バックアップを取ったテスト用データで実行**してください。
7. 日本語と絵文字をプレイヤー名の入力欄で試し、左右キー、Backspace、Delete、Home/End、Ctrl-Uで意図した編集になること。キャンセルするなら最後にEsc。
8. `P` の文字列入力中にCtrl-Cを押した後、端末の入力・カーソル・配色が復元されること。`stty -a` で端末設定を確認できます。
9. `rogue-mac --show-rogueopts` がログインシェルで設定された `ROGUEOPTS` を取得できること。**機密の値を含む可能性があるので出力を公開しないこと**。
10. Mac mini M1とM4の両方で、できればTerminal.app標準設定で確認。zsh/bashを利用している場合は、それぞれのログインシェルでも確認。

## 4. 問題の報告方法

`sh ./macos-check.sh` の結果から**個人情報、ホームディレクトリ、設定値、端末名などを必要に応じて伏せたもの**と、再現時の操作、画面画像を記録してください。診断スクリプトは値を隠しますが、コマンドのパスにはユーザー名が含まれる場合があります。

## 静的確認の範囲と制約

同梱ソースは第5-B段階で5.2の`jump`設定処理を更新し、028向けにバージョンを変更しました。既存の`com.leopard.rogue`設定ドメインや、ほかのバージョンの起動・終了処理は維持しています。Homebrew Formulaの依存先5種はGitHub上の tap の現在のFormula名と一致することを確認しました。**GUIの現在のAppleScriptソースは同梱されていないため、GUI内部のキーの完全な一致については、今回のソースだけから断定できません。**


## 5. 第5-B段階：5.2のジャンプ設定

GUIは、今回提供されたAppleScript `Rogue_AppleScript_52_jump_external_only_20261124` を使用します。

1. GUIの5.2通常設定には `jump` の選択項目がなく、CUIでは5.2の `S` → `A`（全オプション）に `jump` があることを確認します。選択肢は「有効／無効」の2つだけで、「自動」は表示されません。
2. CUIの `jump` 個別設定が未保存なら、外部 `ROGUEOPTS` に `jump`／`nojump` の指定がない場合はゲーム本体の既定動作となることを確認します。GUIも強制指定しません。
3. CUIの個別設定が未保存なら、ログインシェルの `ROGUEOPTS=jump`／`ROGUEOPTS=nojump` が新規ゲームに反映されることを確認します。
4. CUIの5.2全オプションで「有効」を選択すると、外部設定の有無にかかわらず `jump` が指定され、「無効」では `nojump` が指定されることを確認します。通常モードの変更はこの個別選択を消去しません。
5. CUIの5.2全オプションから `R`（個別設定をリセット）を実行した後は、外部の指定またはゲーム本体の既定値に戻ることを確認します。GUI側の旧キー `SavedVersion52_myjump` は参照されません。

**注意：** GUI/CUIは継承した一時的な `ROGUEOPTS=jump` ではなく、登録済みログインシェルの初期化処理で設定された値を読みます。確認には `sh ./rogue-mac --show-rogueopts` を利用できますが、表示にはプライベートな設定値が含まれる場合があるため、公開しないでください。設定の有無はシェル起動設定側で管理します。

## 6. 第5-B段階の静的診断

```sh
sh ./macos-stage5b-check.sh --repo . \
  --applescript /path/to/Rogue_AppleScript_52_jump_external_only_20261124.txt
```

`--applescript` を省略するとCUI単体を検証します。値を出力せず、GUI・ゲームを起動せず、設定やセーブを変更しません。AppleScriptは別配布なので任意で指定してください。GUIの実動作・端末表示については、上の手動確認が必要です。
