# Rogue for macOS (rogue-mac)

The **CUI edition of Rogue for macOS** is a terminal launcher for different Rogue versions and derivatives: 5.4, Clone III, DOS Tribute, 3.6, and 5.2. It shares player information, game settings, and save/score files with the [Rogue for macOS GUI edition](https://leopard-gecko.github.io/jrogue/).

## Starting the launcher

```sh
rogue-mac           # Open the menu
rogue-mac 54        # Rogue 5.4
rogue-mac clone     # Rogue Clone III
rogue-mac dos       # Rogue DOS Tribute
rogue-mac 36        # Rogue 3.6
rogue-mac 52        # Rogue 5.2
rogue-mac --help    # Show usage
```

Enter a number or letter in the menu, then press Return.

| Key | Action |
| --- | --- |
| `1`–`5` | Choose a Rogue version |
| Return alone | Choose the last selected version |
| `P` | Edit player information |
| `G` | Open a guidebook |
| `S` | Change game settings |
| `Q` | Quit |

Menus normally use a black background with colored text. To use your Terminal profile's colors, start with `rogue-mac --mono`.

## Guidebooks

Select `G` on the main menu, then choose a version with `1`–`5` to open its guidebook in your browser. Press Return for the last selected version or `B` to return to the main menu. An internet connection is required.

## Saved games and replay

When a saved game exists, you can choose how to start:

| Key | Action |
| --- | --- |
| `R` or Return | Resume a saved game |
| `N` | Start a new adventure |
| `F` | Choose another saved game |
| `Q` | Return to version selection |

If no save exists, a new adventure starts.

After a game, press `Y` to play the same version again, `M` for the main menu, or `N` to quit.

## Player information (shared with the [GUI](https://leopard-gecko.github.io/jrogue/))

Select `P` on the main menu.

| Key | Action |
| --- | --- |
| `1` | Change player name |
| `2` | Change favorite fruit |
| `3` | Reset the name to your macOS account name |
| `4` | Reset the fruit to its default |
| `B` | Return to the main menu |

Japanese text and common emoji are supported. Press Return on an empty input to cancel. Commas and newlines cannot be used in names or fruit values.

## Game settings (shared with the [GUI](https://leopard-gecko.github.io/jrogue/))

Select `S` on the main menu. **Modern** and **Classic** apply ready-made settings, while **Custom** lets you change individual options. Available settings vary by Rogue version.

| Version | Main settings |
| --- | --- |
| 5.4 | Color, identify scrolls, message length, corner movement |
| Clone III | Color, corner movement, jump |
| DOS Tribute | Color, map characters, key bindings, macro, message length |
| 3.6 | Message length, jump, unidentified-item confirmation |
| 5.2 | Color, corner movement, message length, unidentified-item confirmation |

Use the following keys in Game settings:

| Key | Action |
| --- | --- |
| Number | Change the listed setting |
| `M` | Change mode |
| `L` | Change display language |
| `A` | Show all options |
| `V` | Choose which version to configure |
| `B` | Return to the main menu |

Editing an individual setting switches the mode to **Custom**. Changes made in the [GUI](https://leopard-gecko.github.io/jrogue/) are reflected here too.

## All options

From Game settings, select `A` to access additional options. Select an **option number** to edit it, or `B` to return.

| Version | Main additional options |
| --- | --- |
| 5.4 | Cursor, lit-floor display, combat input, movement display, tombstone, inventory style |
| Clone III | Cursor, quit confirmation, skull on death |
| DOS Tribute | Cursor, movement display, inventory menu |
| 3.6 | Combat input, step-by-step inventory |
| 5.2 | Cursor, combat input, movement display, step-by-step inventory |

Most options are switched **On / Off**. You can also change the default save filename here.

Press `R` to **reset all separately saved additional options for that version**. Your player information and regular game settings are not changed.

## Importing the ROGUEOPTS environment variable

`ROGUEOPTS` is an environment variable for choosing Rogue's display and gameplay settings before starting a game. For example, `language=ja` selects Japanese and `color` enables color. Separate multiple options with commas (supported options vary by version).

The CUI launcher **reads `ROGUEOPTS` from your Mac login shell** and applies it when launching a game. Settings explicitly changed in the launcher take priority. When resuming a saved game, the saved game's settings take priority.

If you use macOS's default zsh shell, add this line to `~/.zshrc` to apply the settings when starting Rogue. You can also use `~/.zprofile`.

```sh
export ROGUEOPTS="language=ja,color"
```

Open a new Terminal window, then check the value imported by the launcher:

```sh
rogue-mac --show-rogueopts
```

You can normally change settings with `S` in the launcher menu, so setting `ROGUEOPTS` yourself is optional.

## Shared save directories

Save files are kept under `~/Library/Application Support/Rogue/`.

| Version | Folder | Default save filename |
| --- | --- | --- |
| 5.4 | `5.4/` | `rogue.save` |
| Clone III | `Clone III/` | `rogue-clone.save` |
| DOS Tribute | `DOS 1.48/` | `rogue-dos.save` |
| 3.6 | `3.6/` | `rogue36.save` |
| 5.2 | `5.2/` | `rogue52.save` |

Use `F` when resuming to choose a different saved game. To change the default save filename, use **All options**.

Do not use the same saved game from both the [GUI](https://leopard-gecko.github.io/jrogue/) and the terminal at the same time.
