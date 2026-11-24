# rogue-mac 0.3.25 — 第5-A／第5-B段階の開発・検証メモ

## 第5-A段階（履歴）

## 変更内容

- 026のソースをベースに、バージョンのみ0.3.24に更新。メニュー表示、共有設定、起動・終了処理は変更していません。
- 読み取り専用の `macos-check.sh` を追加。Homebrew、5種類のRogue実行ファイル、基本CLI、`defaults`の共有領域、データディレクトリを確認。ゲームやGUIは起動せず、保存値は出力しません。
- `MACOS_TEST_GUIDE.md` に、Terminal.app、GUIとの設定往復、セーブ再開、UTF-8入力、終了時の端末復元の実機チェック手順を用意。
- GitHub上の `leopard-gecko/homebrew-game` リポジトリのFormula配置と依存先5種の名前を確認。tap側はルート配置であり、現在の公開 `rogue-mac.rb` は0.3.24（vrogue-mac.027）を指しています。
- ReleaseアーカイブとHomebrew Formulaを027向けに再生成しSHA-256を更新。GitHub Release `vrogue-mac.027` は2026-11-24に公開済みです。公開アーカイブのSHA-256はFormulaの指定値と一致しています。

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


## 第5-B段階（このソース一式に反映）

- 現行AppleScript `Rogue_AppleScript_52_jump_external_only_20261124` に合わせ、5.2の通常モードによる `jump` / `nojump` の自動追加を廃止しました。GUIは外部の明示指定を引き継ぎます。
- CUIの5.2「全オプション」には `jump` を復活させ、他の追加オプションと同じ「有効／無効」の2択で設定できます。明示選択時は `SavedVersion52_rogueopt_jump` に保存して外部指定より優先し、未選択時は外部の明示指定またはゲーム本体の既定値に従います。「自動」という追加の選択肢はありません。`R`で個別設定をリセットすると未指定状態に戻ります。GUI側の `SavedVersion52_myjump` とは別管理で、GUIの設定に副作用を与えません。
- ほかの4バージョンの `jump` 設定の扱いは変更しません。
- `README_rogue-mac.md` / `README_rogue-mac_ja.md` を更新し、読み取り専用の `macos-stage5b-check.sh` を追加しました。`MACOS_TEST_GUIDE.md` のRelease公開状況も修正しました。
- macOSでの動作確認は未実施。Linux上ではシェル構文、CLI基本操作、Ruby構文、および5.2のROGUEOPTS生成処理（指定なし／jump／nojump／旧保存値あり）を検証しました。

### 本ソースと公開027の違い

`rogue-mac`本体は0.3.24のままですが、この第5-B修正は**公開済み027 Releaseには含まれていません**。`rogue-mac.rb`の配布URLとハッシュは027の公開物を正しく指すため、そのまま維持しています。修正版の検証にはこのZIP内の `./rogue-mac` を直接使用してください。Homebrewでインストール・更新しても、この修正版にはなりません。

実機検証後、次の配布番号でリリースを作る際は、ソースのバージョン、Releaseアーカイブ、FormulaのURLとSHA-256をまとめて更新してください。既存027のアーカイブを修正版に差し替えないでください。


## 028 Release候補（第5-B段階の配布準備）

公開済み027は `rogue-mac 0.3.24` の旧版として維持します。第5-Bの修正を含む配布候補は `rogue-mac 0.3.25`、タグ `vrogue-mac.028`、アーカイブ `rogue-mac-028.tar.gz` とします。

- このソース一式の `rogue-mac.rb` は028向けのURL、バージョン、生成済みアーカイブのSHA-256を指定します。
- 028のReleaseは**まだGitHub上に公開していません**。公開前にMac実機の動作を確認してください。
- macOS実機検証が済んだら `RELEASE_028_GUIDE.md` に従いRelease作成とFormula更新を行います。
- 配布アーカイブにはHomebrew Formulaがインストールする `rogue-mac` と日英READMEの3ファイルをルートに格納します。
