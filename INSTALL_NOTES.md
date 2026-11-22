# rogue-mac 0.3.3 — Homebrew publishing notes

## Changes

- In the main menu, rename `G  案内書` to `G  【運命の洞窟】への案内書`.
- Swap the on-screen positions of `G` (guide) and `S` (game settings) in both Japanese and English.
- Keep `G` and `Q` vertically aligned, with the full Japanese menu entry fitting the 52-column rule.
- Update the Japanese guide-selection heading to `【運命の洞窟】への案内書`.
- No change to the game selection, browser URLs, GUI-shared preferences, or gameplay settings.

## Release files

- `rogue-mac`: POSIX shell launcher, version `0.3.3`
- `README_rogue-mac.md`, `README_rogue-mac_ja.md`: updated control descriptions
- `README_homebrew-game.md`: optional updated top-level README (not part of the release tarball)
- `rogue-mac.rb`: Homebrew Formula
- `rogue-mac-006.tar.gz`: Release archive, SHA-256: `cc41684213a857e6859bee0490bc2cf512ac94dc80535380397052490d352482`

## Publishing

1. Publish tag `vrogue-mac.006` in `leopard-gecko/homebrew-game`.
2. Upload exactly this `rogue-mac-006.tar.gz` release archive.
3. Update the tap's `rogue-mac.rb`, `README_rogue-mac.md`, `README_rogue-mac_ja.md`, and if desired the top-level `README.md` using `README_homebrew-game.md`.
4. Run `brew update` and `brew upgrade rogue-mac` (or `brew install rogue-mac`) and `brew test rogue-mac` on macOS.

Do not publish the new Formula before the matching Release archive exists.
