# rogue-mac 0.3.0 — Homebrew publishing notes

This release introduces the black-background menu design provided by the user,
Return-to-last-version selection via `Savedmygameversion`, and per-version
`ROGUEOPTS` settings shared with the updated AppleScript GUI, including
correct 3.6/5.2 `askme` preset handling.

## Release files

- `rogue-mac`: POSIX shell launcher, version 0.3.0
- `README_rogue-mac.md` / `README_rogue-mac_ja.md`: user instructions
- `rogue-mac.rb`: Homebrew Formula with five mandatory dependencies
- `rogue-mac-003.tar.gz`: release asset that matches the Formula SHA-256

## Publishing

1. Publish the release tag `vrogue-mac.003` in `leopard-gecko/homebrew-game`.
2. Upload **the exact provided** `rogue-mac-003.tar.gz` archive; do not repackage.
3. Place the provided `rogue-mac.rb` in the root of `homebrew-game`.
4. On macOS, run `brew update`, `brew install rogue-mac` (or `brew reinstall rogue-mac`
   if already installed), and `brew test rogue-mac`.

This package does not modify the GUI AppleScript, the game Formulae, or GitHub.
Testing was conducted with mock versions of `defaults` and the five Rogue
executables on Linux. Actual integration on macOS remains to be tested.
