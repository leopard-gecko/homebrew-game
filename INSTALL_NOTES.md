# rogue-mac 0.3.2 — Homebrew publishing notes

## Changes

- Add `G` (online guidebook) to the main menu. The guide menu opens a version-specific website in the default macOS browser.
- Guide selection supports `1`–`5`, Return for the last GUI/CUI-selected version, and `B` to return. Merely opening a guide does not save a new selected version.
- The same last-selected version is highlighted in the main and guide selection menus.
- Main prompt: 「冒険したいバージョンまたは操作を選ぶ」.
- Align the `S` and `Q` choices in the same column in the Japanese and English main menus.
- No changes to the AppleScript GUI, Rogue game sources, shared preferences, or game settings.

## Release files

- `rogue-mac`: POSIX shell launcher, version 0.3.2
- `README_rogue-mac.md` / `README_rogue-mac_ja.md`: updated guide and controls
- `README_homebrew-game.md`: suggested updated top-level README.md (not part of the release tarball)
- `rogue-mac.rb`: Homebrew Formula
- `rogue-mac-005.tar.gz`: Release archive, SHA-256: `b6c8f04cd9f0e401ce48e0338236c65ec12b9306e42ef2023fc55c8905f0dcc6`

## Publishing

1. Publish tag `vrogue-mac.005` in `leopard-gecko/homebrew-game`.
2. Upload exactly this `rogue-mac-005.tar.gz` file to the release.
3. Replace the tap's `rogue-mac.rb` and README files using the supplied revisions.
4. On macOS run `brew update`, `brew upgrade rogue-mac` (or `brew install rogue-mac`), and `brew test rogue-mac`.

Do not publish the Formula before the matching Release archive exists.
