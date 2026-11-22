# Rogue for macOS (rogue-mac)

A terminal launcher accompanying the AppleScript **Rogue for macOS** GUI. Choose Rogue 5.4.5, Clone III, DOS Tribute, 3.6, or 5.2. Both launchers share game save/score directories, player name, favorite fruit, last selected version, and per-version gameplay preferences.

All shared preferences use the macOS defaults domain `com.leopard.rogue` without a separate configuration file.

## Usage

```sh
rogue-mac           # version menu
rogue-mac 54        # Rogue 5.4.5
rogue-mac clone     # Rogue Clone III
rogue-mac dos       # Rogue DOS Tribute
rogue-mac 36        # Rogue 3.6
rogue-mac 52        # Rogue 5.2
rogue-mac --mono    # menus without ANSI colors
rogue-mac 54 -s     # pass arguments directly to the game
rogue-mac --help
```

The menu uses an elegant black-background design with gold accents, adapted from the supplied reference script. It shows the player greeting, favorite fruit, and “Saved” markers. It does not display binary filenames. `NO_COLOR` and `--mono` disable menu colors without changing the Terminal profile.

Press **Return on the version menu** to select the version last selected in either launcher. This is stored under `Savedmygameversion`. Because the GUI also saves the selection when its version control changes, this is *the last selected version*, not necessarily the last game actually started. Unknown or unsupported versions default to 5.4. The last selected version name is highlighted in teal instead of showing a separate "Last" marker. The Return hint includes the actual version name. The input prompt reads "Choose a version or settings". Choose `P` for player settings, `S` for game settings, or `Q` to quit. On normal exit, the launcher shows the same farewell message as AppleScript: "See you again." (Japanese: 「それでは、またね。」).

## Saved games and replay

If no standard save exists, a new game starts. Otherwise:

| Key | Action |
| --- | --- |
| `R` / Return | Resume the standard saved game |
| `N` | Start a new adventure (does not delete old save) |
| `F` | Enter the path to another saved game |
| `Q` | Return to version selection |

After gameplay, choose `Y` (same version again, with a fresh save check), `M` (main menu), or `N` (quit). For 3.6 and 5.2, Return is required after the final game screen so it is not cleared prematurely.

## Player name and fruit (shared with GUI)

Choose `P` on the main menu:

| Key | Action |
| --- | --- |
| `1` | Change player name |
| `2` | Change favorite fruit |
| `3` | Reset name to the macOS account's full name |
| `4` | Reset fruit to the language-specific default |
| `B` | Back to main menu |

These use `Savedmyname` and `Savedmyfruit`. The macOS full name (or login name) is the fallback when no player name is stored. Default fruit is `ネバネバかび` in Japanese and `slime-mold` in English. Names can contain UTF-8, whitespace, and typical emoji. Newly edited values cannot be empty or contain commas (a `ROGUEOPTS` separator) or newlines; a blank input cancels the edit.

## Game settings (shared with GUI)

Choose `S` on the main menu. Each version has its own mode, display language, and editable options:

| Version | Editable gameplay options |
| --- | --- |
| 5.4.5 | Color, identify-scroll count, message length, corner movement |
| Clone III | Color, corner movement, jump |
| DOS Tribute | Color, map characters, key bindings, macro, message length |
| 3.6 | Message length, jump, unidentified-item confirmation (`askme`) |
| 5.2 | Color, corner movement, message length, unidentified-item confirmation (`askme`) |

Select numbered items to edit. `M` chooses **Modern**, **Classic**, or **Custom** modes; `L` toggles Japanese/English; `V` changes the version whose options are edited; and `B` returns to the main menu. Editing an individual option switches that version to **Custom**, matching the GUI. Choosing Modern or Classic applies the GUI's preset for that version.

Settings use the GUI's `SavedVersion54_*`, `SavedVersionCloneIII_*`, `SavedVersionDOS148_*`, `SavedVersion36_*`, and `SavedVersion52_*` keys. In 3.6 and 5.2, `askme` or `noaskme` is calculated from the current mode and settings when launching: Modern enables it, Classic disables it, and Custom uses the individually saved value. This matches the updated AppleScript.

DOS Tribute emits `nodoskeys` for **Rogue 5.4-style** controls and uses the game's default `doskeys` for **DOS 1.48-style** controls; its `macro=` option is also shared. As in the GUI, version 5.2 always receives `nojump`.

For **new adventures**, the launcher generates `ROGUEOPTS` from shared GUI settings, replacing conflicting inherited options while retaining unrelated ones. When **resuming a saved game**, it normally supplies only `language=ja/en`, preserving the other saved options. When explicit game arguments are given on the command line, they and the inherited environment are forwarded unchanged, as before.

Merely viewing settings does not write them. To avoid stale preferences being written over newer changes, do not edit the same settings in two running launchers simultaneously; reopen the other launcher after changing settings.

## Shared save directories

All are under `~/Library/Application Support/Rogue/`:

| Version | Subdirectory | Default save filename |
| --- | --- | --- |
| 5.4.5 | `5.4/` | `rogue.save` |
| Clone III | `Clone III/` | `rogue-clone.save` |
| DOS Tribute | `DOS 1.48/` | `rogue-dos.save` |
| 3.6 | `3.6/` | `rogue36.save` |
| 5.2 | `5.2/` | `rogue52.save` |

The game executable remains responsible for save-file formats and post-resume cleanup. The launcher does not move, convert, or delete save files. Do not operate on the same save from the GUI and terminal at the same time.

Alternate saves may be selected by absolute path, `~/` path, or a path relative to the version's save directory. Custom `file=...` settings in `ROGUEOPTS` may cause automatic save detection to miss a differently named standard save.
