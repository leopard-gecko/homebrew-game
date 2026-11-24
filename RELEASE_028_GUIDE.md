# rogue-mac 028 — 公開手順

## ファイル

- タグ: `vrogue-mac.028`
- Release添付: `rogue-mac-028.tar.gz`
- ランチャーバージョン: `0.3.25`
- SHA-256: `5b0260724a3f18d6e7e3df8488746cce73c5c6cb1148b050a4bb66cb799e6ca9`
- Homebrew Formula: `rogue-mac.rb`（リポジトリのルート）

**027はすでに公開済みなので差し替えません。** 028は現時点で未公開です。

## 公開前のMac実機確認

1. 展開したソースフォルダで `./rogue-mac --version` が `rogue-mac 0.3.25` を表示すること。
2. `sh ./macos-check.sh --launcher ./rogue-mac` と `sh ./macos-stage5b-check.sh --repo . --archive /path/to/rogue-mac-028.tar.gz` の検査を行います。
3. `MACOS_TEST_GUIDE.md` に沿ってTerminal.appの表示、GUI共有設定、5種のゲーム起動とセーブ再開、5.2の `jump` / `nojump` を手動確認します。既存セーブのバックアップを推奨します。
4. `shasum -a 256 rogue-mac-028.tar.gz` で上記ハッシュと一致することを確認します。

## GitHubへの公開

1. このソースZIPの内容を `leopard-gecko/homebrew-game` に反映します（特に `rogue-mac`、`rogue-mac.rb`、README、診断スクリプト）。
2. GitHubで新規Releaseを作成し、タグを **`vrogue-mac.028`**、添付ファイルを **`rogue-mac-028.tar.gz`** として公開します。027を編集・削除しないでください。
3. Formulaはこの028アーカイブのURLと一致する必要があります。ユーザーがReleaseの添付を取得できる状態になってから、Formulaを含む更新を利用可能にします。
4. Macで `brew update`、`brew upgrade leopard-gecko/game/rogue-mac`、`brew test leopard-gecko/game/rogue-mac` を実行します。既にインストールされていない場合は `brew install leopard-gecko/game/rogue-mac` を使用します。
5. `rogue-mac --version` で `0.3.25` を確認します。

## アーカイブの内容

Release tar.gz は、Formula の `def install` が使用する3ファイルを最上位に置いています：`rogue-mac`（実行権限755）、`README_rogue-mac.md`、`README_rogue-mac_ja.md`（644）。GitHub用のソース一式ZIPとは内容が異なります。

macOSでの実機動作はこの作成環境では未検証です。Release公開前に確認してください。
