# rogue-mac CUI Launcher — Package Contents

- `rogue-mac`: launcher executable (POSIX /bin/sh)
- `README_rogue-mac.md`: usage and save directory map
- `rogue-mac.rb`: Homebrew Formula
- `rogue-mac-001.tar.gz`: exact archive referenced by Formula (copy outside this folder)

## Publish steps

1. Ensure renamed/new game Formulae (`rogue54`, `rogue-c3`, `rogue-dos`, `rogue36`, `rogue52`) are present in `leopard-gecko/homebrew-game`.
2. Create `vrogue-mac.001` Release in `leopard-gecko/homebrew-game` and attach `rogue-mac-001.tar.gz` **unchanged**. The SHA is fixed in the Formula.
3. Commit `rogue-mac.rb` in the root of the tap repository. Formula points to the Release archive created in step 2.
4. Run `brew update`, `brew install rogue-mac`, and `brew test rogue-mac` on macOS.

No changes to DOS Tribute Formula or AppleScript are necessary.

Note: the Release asset above has not been published in GitHub as part of generating these files; `brew install rogue-mac` will not work until it has been uploaded.
