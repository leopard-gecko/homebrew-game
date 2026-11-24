# rogue-mac 0.3.24 — 第5-A段階：macOS実機検証の準備と配布整合性の点検

## 変更内容

- 026のソースをベースに、バージョンのみ0.3.24に更新。メニュー表示、共有設定、起動・終了処理は変更していません。
- 読み取り専用の `macos-check.sh` を追加。Homebrew、5種類のRogue実行ファイル、基本CLI、`defaults`の共有領域、データディレクトリを確認。ゲームやGUIは起動せず、保存値は出力しません。
- `MACOS_TEST_GUIDE.md` に、Terminal.app、GUIとの設定往復、セーブ再開、UTF-8入力、終了時の端末復元の実機チェック手順を用意。
- GitHub上の `leopard-gecko/homebrew-game` リポジトリのFormula配置と依存先5種の名前を確認。tap側はルート配置であり、現行の公開 `rogue-mac.rb` は0.3.3（vrogue-mac.006）です。027の公開後にFormula更新が必要です。
- ReleaseアーカイブとHomebrew Formulaを027向けに再生成しSHA-256を更新。実際のGitHub公開は行っていません。

## 検証範囲

- `sh -n` / `dash -n`、`ruby -c`、`--help`/`--list`/`--version`の基本検証。
- `macos-check.sh` の引数処理、欠落バイナリや未設定設定領域での非破壊動作をLinux上で確認。
- 026に対してランチャー本体の変更がバージョン表記2か所のみであることを確認。
- アーカイブ内の実行権限、README、FormulaのURL・バージョン・ハッシュを検査。

## 制約

macOS Terminal.app、Homebrewの実インストール、AppleScript GUIとの設定往復、実際のRogueのゲーム画面はこの実行環境ではテストできません。静的な一致や疑似端末のテストをMac実機の合格結果として扱わないでください。

## 公開準備

- Releaseタグ：`vrogue-mac.027`
- Release添付：`rogue-mac-027.tar.gz`
- Formula：`rogue-mac.rb`
- Mac上での確認方法：`MACOS_TEST_GUIDE.md` を参照。

Release SHA-256: `897f51f66249049eece5408ca2644aea9ffa78601f7643a3652d6855c2c6cef1`
