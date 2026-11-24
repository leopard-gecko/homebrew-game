#!/bin/sh
# rogue-mac: read-only diagnostics for the Stage 5 macOS integration check.
# Does not launch any Rogue game, modify defaults, or create any save files.
set -u

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0
pass() { printf '[PASS] %s\n' "$*"; PASS_COUNT=$((PASS_COUNT + 1)); }
warn() { printf '[WARN] %s\n' "$*"; WARN_COUNT=$((WARN_COUNT + 1)); }
fail() { printf '[FAIL] %s\n' "$*"; FAIL_COUNT=$((FAIL_COUNT + 1)); }

usage() {
    cat <<'EOF'
Usage: sh macos-check.sh [--launcher PATH] [--brew-test]

Read-only inspection of a Mac installation of rogue-mac.
  --launcher PATH   Test the given rogue-mac executable (default: PATH, then sibling file)
  --brew-test       Also run 'brew test rogue-mac' (may make Homebrew test files)

The script never writes shared preferences or game saves.
It does not print the stored player name, fruit or ROGUEOPTS value.
EOF
}

LAUNCHER=''
BREW_TEST=0
while [ "$#" -gt 0 ]; do
    case "$1" in
        --launcher)
            if [ "$#" -lt 2 ]; then printf 'Missing --launcher argument\n' >&2; exit 2; fi
            LAUNCHER=$2; shift 2 ;;
        --brew-test) BREW_TEST=1; shift ;;
        --help|-h) usage; exit 0 ;;
        *) printf 'Unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
    esac
done

printf '%s\n' '=== rogue-mac macOS diagnostics (read-only) ==='
if [ "$(uname -s)" = Darwin ]; then
    pass 'Operating system: macOS'
else
    warn 'This is not macOS; macOS integration checks cannot be verified here'
fi

if [ -z "$LAUNCHER" ]; then
    if command -v rogue-mac >/dev/null 2>&1; then
        LAUNCHER=$(command -v rogue-mac)
    else
        # Work when the script is run directly from the extracted package.
        script_dir=$(CDPATH= cd "$(dirname "$0")" && pwd) || exit 2
        LAUNCHER=$script_dir/rogue-mac
    fi
fi
if [ -f "$LAUNCHER" ] && [ -x "$LAUNCHER" ]; then
    pass "Launcher is executable: $LAUNCHER"
    version=$({ "$LAUNCHER" --version; } 2>/dev/null) || version=''
    case "$version" in
        'rogue-mac 0.3.25') pass 'Launcher version: 0.3.25' ;;
        'rogue-mac '*) warn "Launcher version differs from package: $version" ;;
        *) fail 'Cannot retrieve launcher version' ;;
    esac
    if "$LAUNCHER" --help 2>/dev/null | grep -q 'Rogue for macOS'; then
        pass '--help completed'
    else
        fail '--help failed'
    fi
    list=$({ "$LAUNCHER" --list; } 2>/dev/null) || list=''
    lines=$(printf '%s\n' "$list" | grep -c '^\([1-5]\)\. Rogue ' || :)
    # Clone III and DOS Tribute are included under 'Rogue '.
    if [ "$lines" -eq 5 ]; then pass '--list shows all five editions'; else fail '--list is incomplete'; fi
    if "$LAUNCHER" --show-rogueopts >/dev/null 2>&1; then
        pass '--show-rogueopts completed (value hidden)'
    else
        warn 'Could not complete --show-rogueopts; check login shell startup'
    fi
else
    fail "Launcher is missing or not executable: $LAUNCHER"
fi

if command -v brew >/dev/null 2>&1; then
    pass "Homebrew found: $(command -v brew)"
    brew_ver=$(brew list --versions rogue-mac 2>/dev/null || :)
    if [ -n "$brew_ver" ]; then pass "Homebrew launcher package: $brew_ver"; else warn 'rogue-mac is not installed with Homebrew'; fi
else
    warn 'Homebrew not found on PATH'
fi

for spec in 'rogue54:Rogue 5.4' 'rogue-c3:Rogue Clone III' 'rogue-dos:Rogue DOS Tribute' 'rogue36:Rogue 3.6' 'rogue52:Rogue 5.2'; do
    bin=${spec%%:*}
    title=${spec#*:}
    if command -v "$bin" >/dev/null 2>&1; then
        pass "$title executable found: $(command -v "$bin")"
    else
        warn "$title executable not found on PATH ($bin)"
    fi
done

DOMAIN=com.leopard.rogue
if command -v defaults >/dev/null 2>&1; then
    if defaults read "$DOMAIN" >/dev/null 2>&1; then
        pass "Preference domain accessible: $DOMAIN"
        for key in Savedmygameversion Savedmyname Savedmyfruit Savedmylanguage SavedVersion54_mylanguage SavedVersionCloneIII_mylanguage SavedVersionDOS148_mylanguage SavedVersion36_mylanguage SavedVersion52_mylanguage; do
            if defaults read "$DOMAIN" "$key" >/dev/null 2>&1; then
                pass "Shared preference exists: $key (value hidden)"
            else
                # Absent preferences are valid until the corresponding GUI/CUI screen saves them.
                printf '[INFO] Shared preference unset: %s\n' "$key"
            fi
        done
    else
        warn "No existing $DOMAIN settings (expected before the GUI has saved preferences)"
    fi
else
    warn 'defaults command not found; shared preference compatibility cannot be checked'
fi

BASE="${HOME:?HOME is required}/Library/Application Support/Rogue"
for name in '5.4' 'Clone III' 'DOS 1.48' '3.6' '5.2'; do
    if [ -d "$BASE/$name" ]; then
        pass "Game data directory exists: $name"
    else
        printf '[INFO] Game data directory not yet created: %s\n' "$name"
    fi
done

if [ "$BREW_TEST" -eq 1 ]; then
    if command -v brew >/dev/null 2>&1; then
        if brew test rogue-mac; then pass 'brew test rogue-mac'; else fail 'brew test rogue-mac'; fi
    else
        fail 'Cannot run brew test without Homebrew'
    fi
fi

printf '\nSummary: PASS=%s WARN=%s FAIL=%s\n' "$PASS_COUNT" "$WARN_COUNT" "$FAIL_COUNT"
printf '%s\n' 'GUI-to-CUI changes, terminal colors and actual gameplay require manual macOS checks.'
if [ "$FAIL_COUNT" -ne 0 ]; then exit 1; fi
exit 0
