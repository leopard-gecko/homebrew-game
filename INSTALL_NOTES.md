# rogue-mac 0.3.1 — Homebrew publishing notes

## Changes

- Prompt: 「冒険したいバージョンまたは設定を選ぶ」
- Return hint shows the last selected Rogue version name.
- The previously selected version name uses the former Last-marker accent color; no separate 前回/Last marker.
- Normal quit shows the AppleScript greeting's matching farewell: 「それでは、またね。」 / "See you again."
- All previously supported shared preferences, launch paths and settings remain unchanged.

## Release files

- `rogue-mac`: POSIX shell launcher, version 0.3.1
- `README_rogue-mac.md` / `README_rogue-mac_ja.md`: documentation
- `rogue-mac.rb`: Homebrew Formula
- `rogue-mac-004.tar.gz`: exact Release archive (SHA-256: `64a10cf0a8f59046210b0bd4cc09e5dc8a97a27590ed17780eb7afcf979f04ae`)

## Publishing

1. Publish tag `vrogue-mac.004` in `leopard-gecko/homebrew-game`.
2. Upload the exact supplied `rogue-mac-004.tar.gz` file to that release.
3. Update the tap's `rogue-mac.rb` to the supplied file.
4. On macOS run `brew update` and `brew upgrade rogue-mac` (or `brew install rogue-mac`) and `brew test rogue-mac`.

Do not publish only the Formula before the matching Release archive exists.
The other game Formulae and the GUI AppleScript are not changed.
