# Homebrew Formula updates — 2026-11-26

Replace these three files in the root of `leopard-gecko/homebrew-game`:

| Formula | New version | Release |
| --- | --- | --- |
| `rogue34.rb` | `3.4.002` | `rogue_3.4_jec` `v002` |
| `rogue36.rb` | `3.6.007` | `rogue_3.6_jec` `v007` |
| `rogue54-wizard.rb` | `5.4.5jec.057` | `rogue_5.4.5_jec` `v57` |

The download URL and SHA-256 in each Formula match the published release asset and its GitHub digest. Existing installation procedures, executable names, save/score names, and tests are unchanged.

Other Formulas (`rogue54.rb`, `rogue-c3.rb`, `rogue-dos.rb`, `rogue52.rb`, `rogue-mac.rb`) already reference the latest matching releases as of the check and do not need updates.

Validation run on Linux: `ruby -c` for all three files; source `Makefile`/`configure` parameters checked at corresponding release tags. Homebrew install and runtime tests require a Mac and have not been run here.

After uploading the replacements to the GitHub repository, on a Mac run:

```sh
brew update
brew upgrade rogue34 rogue36
# if rogue54-wizard is installed:
brew upgrade rogue54-wizard
```

If the formula names are not recognized without a tap, use the fully qualified `leopard-gecko/game/rogue34`, `leopard-gecko/game/rogue36` and `leopard-gecko/game/rogue54-wizard` names.

The CUI launcher still installs five Rogue editions; `rogue34` remains separately installable and is not added to `rogue-mac` as an automatic dependency.
