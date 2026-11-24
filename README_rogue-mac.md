# Rogue for macOS (rogue-mac)

A terminal launcher accompanying the AppleScript **Rogue for macOS** GUI. Choose Rogue 5.4, Clone III, DOS Tribute, 3.6, or 5.2. Both launchers share game save/score directories, player name, favorite fruit, last selected version, and per-version gameplay preferences.

All preferences use the macOS defaults domain `com.leopard.rogue`. Where an equivalent AppleScript setting exists, the launcher uses that exact shared preference—there is no CUI-specific override. Additional options without GUI equivalents get new keys in the same domain. No manually managed config file is created.

## Usage

```sh
rogue-mac           # version menu
rogue-mac 54        # Rogue 5.4
rogue-mac clone     # Rogue Clone III
rogue-mac dos       # Rogue DOS Tribute
rogue-mac 36        # Rogue 3.6
rogue-mac 52        # Rogue 5.2
rogue-mac 54 -s     # pass arguments directly to the game
rogue-mac --help
```

At startup, the launcher displays a personalized greeting, the favorite fruit, and the five available versions. Versions with a standard save file are marked as saved.

Use the following keys on the main menu, confirming each entry with Return:

| Key | Action |
| --- | --- |
| `1`–`5` | Select a Rogue version |
| Return alone | Select the last chosen version |
| `P` | Player name and favorite fruit settings |
| `G` | Open a version-specific online guide |
| `S` | Per-version game settings |
| `Q` | Quit the launcher |

The menu prompt reads “Choose a version or action.” The Return hint includes the selected version name, such as “Return: launch previously selected Rogue 3.6.” The selection is shared with the AppleScript GUI through `Savedmygameversion`. Since the GUI also records a version when it is selected in its interface, this is the **last selected version**, not necessarily the last game actually started. An unsupported saved value falls back to 5.4.

On normal exit, the launcher clears the terminal screen before displaying the AppleScript farewell message: “See you again.” (Japanese: 「それでは、またね。」).

Color menus (including post-game prompts) paint the entire terminal grid black, regardless of the Terminal profile’s background. `--mono` continues to use the Terminal profile’s own colors. Before launching a game and before the farewell, the normal terminal foreground/background are restored.

## Online guidebooks

Press `G` from the main menu to open **A Guide to the Dungeons of Doom** selection screen. Choose `1`–`5` to open that version's online guide in the macOS default browser; the launcher then returns to its main menu.

Press Return alone to open the guide for the **last selected version**. Press `B` to go back without opening a guide.

Viewing a guide does **not** update the GUI-shared last selected version or any gameplay settings. An internet connection is required to view the online guides.



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
| 5.4 | Color, identify-scroll count, message length, corner movement |
| Clone III | Color, corner movement, jump |
| DOS Tribute | Color, map characters, key bindings, macro, message length |
| 3.6 | Message length, jump, unidentified-item confirmation (`askme`) |
| 5.2 | Color, corner movement, message length, unidentified-item confirmation (`askme`) |

GUI-shared ordinary `jump` and `askme` values are stored as `True`/`False` for compatibility. They appear as 有効/無効 in Japanese menus and `True`/`False` in English menus. The 5.2 `jump` entry under **All options** is an additional CUI selection stored as `on` / `off`, independent of the GUI-shared ordinary key.

Select numbered items to edit. `M` chooses **Modern**, **Classic**, or **Custom** modes; `L` toggles Japanese/English; `A` opens the all-options menu; `V` changes the version whose options are edited; and `B` returns to the main menu. Editing an individual option switches that version to **Custom**, matching the GUI. Choosing Modern or Classic applies the GUI's preset for that version.

Settings use the GUI's `SavedVersion54_*`, `SavedVersionCloneIII_*`, `SavedVersionDOS148_*`, `SavedVersion36_*`, and `SavedVersion52_*` keys. In 3.6 and 5.2, `askme` or `noaskme` is calculated from the current mode and settings when launching: Modern enables it, Classic disables it, and Custom uses the individually saved value. This matches the updated AppleScript.

DOS Tribute emits `nodoskeys` for **Rogue 5.4-style** controls and uses the game's default `doskeys` for **DOS 1.48-style** controls; its `macro=` option is also shared. In 5.2, the current AppleScript GUI does not set `jump`/`nojump`. The CUI **All options** menu offers **On / Off** choices for `jump`, just like other additional boolean options. A saved explicit choice emits `jump` / `nojump` and overrides login-shell settings. Without a saved choice, an external `jump` / `nojump` is preserved; if none exists, the game default applies. No separate “Auto” choice is shown; **R** (Reset individual options) restores inheritance. The GUI's `SavedVersion52_myjump` preference is not used at launch, while the CUI's explicit choice is stored in `SavedVersion52_rogueopt_jump` in the same preference domain.

For **new adventures**, the launcher generates `ROGUEOPTS` from the shared GUI settings, overriding overlapping options read from the login shell and passing through unrelated entries. When **resuming a saved game**, it normally supplies only `language=ja/en` to preserve saved options. Explicit game arguments are passed through unchanged; the environment uses the freshly retrieved login-shell `ROGUEOPTS`, not a stale inherited value.

Merely viewing settings does not write them. To avoid stale preferences being written over newer changes, do not edit the same settings in two running launchers simultaneously; reopen the other launcher after changing settings.

## Retrieving `ROGUEOPTS` from the login shell

Like the AppleScript GUI, this launcher queries the user's registered macOS login shell in interactive login mode (`-lic`) and retrieves the `ROGUEOPTS` established by shell startup files. It **does not fall back to inherited, potentially stale `ROGUEOPTS` values or `launchctl`**. The probe shell is detached from the user's controlling terminal to prevent it from taking terminal input or suspending the launcher. Shell banners are ignored, and startup is limited to five seconds. If retrieval fails or times out, the launcher proceeds without external options.

On startup, supported shared settings (`color`, `passgo`, `language`, `name`, `fruit`, etc.) are reflected as initial menu values. Edits made within the running launcher take precedence. Immediately before starting a game, the login shell is queried again; additional options not managed by the GUI are passed to new games. External `file=` is excluded to protect standard save-file detection.

Retrieval does not write to the shared preferences. The probe forks before detaching its login-shell session, avoiding `setsid()` failure when the invoking process is a job-control process-group leader.

**Check retrieval:** Run `rogue-mac --show-rogueopts` to print the value retrieved from your login shell. If it is empty, the option may be unset or retrieval may have failed; review your shell startup files as needed.

**Additional-option precedence for new games:** an explicit choice in All Options → login-shell `ROGUEOPTS` → the game's built-in default. Shared GUI fields continue to use the existing AppleScript-compatible preference keys, with in-session edits taking precedence. External `file=` remains excluded.

## All ROGUEOPTS options

Press `S` on the main menu, then `A` to see all supported options for that Rogue version together with their current values. The menu does not divide entries by storage mechanism: select a number to change an option. **Options already available in AppleScript use the very same shared preference keys.** For example, `color`, `passgo`, `name`, `fruit`, and `language` are displayed and edited directly; no CUI-only override is created. Changes to shared fields are available to the GUI as well, subject to its normal preset behavior.

Options not yet available in AppleScript, such as `flush`, `step`, `inven`, and `menu`, have new keys in the **same `com.leopard.rogue` preference domain**. Unset additional items display the login-shell value when present, or the game's standard Homebrew-build default otherwise. The choice screen marks the built-in default as **(default)** without a separate unset choice. **Explicitly selecting a default stores that choice**, so it overrides a conflicting login-shell option. The old `com.leopard.rogue.cui` domain is no longer used.

| Version | Available all-options entries |
| --- | --- |
| 5.4 | `color`, `cursor`, `seefloor`, `terse`, `flush`, `jump`, `passgo`, `tombstone`, `inven`, `idscrl`, `name`, `fruit`, `language`, `file` |
| Clone III | `color`, `cursor`, `jump`, `passgo`, `noaskquit`, `noskull`, `name`, `fruit`, `language`, `file` |
| DOS Tribute | `color`, `cursor`, `extchars`, `terse`, `jump`, `doskeys`, `menu`, `macro`, `name`, `fruit`, `language`, `file` |
| 3.6 | `terse`, `flush`, `jump`, `step`, `askme`, `name`, `fruit`, `language`, `file` |
| 5.2 | `color`, `cursor`, `terse`, `flush`, `jump`, `step`, `askme`, `passgo`, `name`, `fruit`, `language`, `file` |

Additional options accept validated boolean, enum, and text values as applicable. Options with named choices in AppleScript use those same labels here (Color/Monochrome, 1 kind/5 kinds, Short/Normal, Do not stop/Stop, Extended/Basic, and Rogue 5.4-style/DOS 1.48-style). `jump` and `askme` continue to use simple on/off labels. Clone III's `noaskquit` and `noskull` can be toggled On/Off in the interface; enabling them removes an external disable token and restores the normal built-in behavior. Version 5.4 supports Overwrite/Slow/Clear for `inven`; DOS Tribute supports `on`/`sel`/`off` for `menu`. Text inputs reject commas, controls, invalid UTF-8, and excessively long values. DOS Tribute macros are restricted to 40 bytes and may not contain `x`, which the game would otherwise remove to prevent recursion. The option picker shows the current value with the label “Current setting:”. In text-entry fields, Backspace removes one complete Unicode grapheme (including Japanese characters and normal emoji), and Left/Right arrow keys move the insertion point without entering escape codes. Home/End, Delete, Control-A/Control-E, and Control-U are also supported. Press Esc to cancel, or clear the field with Control-U and press Return; an empty line cancels. Menu-number and command-key inputs continue to use ordinary Return-confirmed input. The default for `file` is the standard save filename.

Use `R` to **Reset individual options**, or `B` to return. A confirmation screen explains that only separately stored choices for the selected version are cleared. Basic settings such as name, fruit, and color are preserved. After reset, a login-shell `ROGUEOPTS` value applies where present; otherwise the game default applies. Press `N` or Return to cancel.

Here, "default" means the standard Homebrew-built game default, which may differ from GUI Modern/Classic presets or from `ROGUEOPTS` set in the login shell.

**Launch behavior:** Additional saved options now affect newly started games. For 5.4, the language token is always placed before `inven`, and recognized external `inven=` values are translated into the selected game language. A custom `file=` chosen in All Options is also used for automatic save detection and resuming (external `file=` remains excluded). Resuming saved games still passes language only; explicit game arguments still use the login-shell `ROGUEOPTS`.

New keys include `SavedVersion54_rogueopt_flush`, `SavedVersionCloneIII_rogueopt_noskull`, `SavedVersionDOS148_rogueopt_menu`, and `SavedVersion36_rogueopt_step`. Experimental values stored in `com.leopard.rogue.cui` by version 0.3.4 are neither migrated nor deleted and are no longer consulted.

## Shared save directories

All are under `~/Library/Application Support/Rogue/`:

| Version | Subdirectory | Default save filename |
| --- | --- | --- |
| 5.4 | `5.4/` | `rogue.save` |
| Clone III | `Clone III/` | `rogue-clone.save` |
| DOS Tribute | `DOS 1.48/` | `rogue-dos.save` |
| 3.6 | `3.6/` | `rogue36.save` |
| 5.2 | `5.2/` | `rogue52.save` |

The game executable remains responsible for save-file formats and post-resume cleanup. The launcher does not move, convert, or delete save files. Do not operate on the same save from the GUI and terminal at the same time.

Alternate saves may be selected by absolute path, `~/` path, or a path relative to the version's save directory. The launcher uses detailed-menu `file=...` values for both saved-game detection and new-game creation. An external `file=` set in the login shell is excluded so that it cannot silently change the save-file location.
