# Rogue for macOS — CUI launcher (rogue-mac)

`rogue-mac` is the text-based companion to the AppleScript GUI launcher.
It uses the same saved games and score directories, and presents a new/resume
menu only when a standard save is present. After playing, `Y` starts the same
version again, `M` returns to version selection, and `N` exits the launcher.

## Usage

    rogue-mac           # choose a version
    rogue-mac 54        # open Rogue 5.4.5 (resume menu if a save exists)
    rogue-mac clone     # open Rogue Clone III
    rogue-mac dos       # open Rogue DOS Tribute
    rogue-mac 36        # open Rogue 3.6
    rogue-mac 52        # open Rogue 5.2
    rogue-mac 54 -s     # forward an argument to the selected game
    rogue-mac --help

Input is confirmed with Return. On game exit, `Y` checks for an existing
standard save again. Passing game arguments explicitly bypasses the initial
save menu only for the first launch; `Y` returns to normal save detection.

## Save data directories

Each directory is under `~/Library/Application Support/Rogue/`:

| Game | Subdirectory | Default save |
| --- | --- | --- |
| Rogue 5.4.5 | `5.4` | `rogue.save` |
| Rogue Clone III | `Clone III` | `rogue-clone.save` |
| Rogue DOS Tribute | `DOS 1.48` | `rogue-dos.save` |
| Rogue 3.6 | `3.6` | `rogue36.save` |
| Rogue 5.2 | `5.2` | `rogue52.save` |

The game itself owns the save file contents and deletion/recovery behavior.
The launcher only changes the working directory, checks for files and passes
save paths to the game. It does **not** copy or migrate data, and does **not**
change `ROGUEOPTS`. Absolute and `~/` paths can be entered for a different
save file; a relative path is interpreted from the selected game's directory.

Do not run GUI and CUI simultaneously on the same save. The launcher assumes
`ROGUEOPTS` does not override the standard save filename with `file=...`.

## Homebrew distribution

`rogue-mac.rb` requires five Formulae in `leopard-gecko/game`:
`rogue54`, `rogue-c3`, `rogue-dos`, `rogue36`, `rogue52`.

Before `brew install rogue-mac` can work, upload the bundled
`rogue-mac-001.tar.gz` as an asset under tag `vrogue-mac.001` in
`leopard-gecko/homebrew-game`, and commit `rogue-mac.rb` to the tap.
The Formula's URL and SHA-256 match that archive exactly.

The independent game Formulae should already be present under their new names.
They should be built with their existing relative default save/score filenames,
not absolute home-directory paths.

The Rogue DOS Tribute save is named `rogue-dos.save`, matching the updated
AppleScript launcher. No changes to the DOS Tribute Formula are required.
