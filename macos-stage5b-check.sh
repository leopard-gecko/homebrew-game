#!/bin/sh
# Rogue for macOS: Stage 5-B, non-destructive integration/pre-release checks.
# No game or GUI launch, no preference writes and no save-file changes.
set -u

PASS=0
WARN=0
FAIL=0
pass() { printf '[PASS] %s\n' "$*"; PASS=$((PASS + 1)); }
warn() { printf '[WARN] %s\n' "$*"; WARN=$((WARN + 1)); }
fail() { printf '[FAIL] %s\n' "$*"; FAIL=$((FAIL + 1)); }
info() { printf '[INFO] %s\n' "$*"; }
usage() {
    cat <<'EOF'
Usage: sh macos-stage5b-check.sh [options]
  --repo DIR             homebrew-game checkout (default: script's directory)
  --applescript FILE     GUI AppleScript source text (static comparison)
  --archive FILE         Release rogue-mac-028.tar.gz (optional SHA-256 verification)
  --help                 Show this message

Read-only: does not launch games, GUI, or modify Homebrew/preferences/saves.
Personal preference values and login-shell ROGUEOPTS are not printed.
EOF
}
SCRIPT_DIR=$(CDPATH= cd "$(dirname "$0")" && pwd) || exit 2
REPO=$SCRIPT_DIR
GUI=''
ARCHIVE=''
while [ "$#" -gt 0 ]; do
    case "$1" in
        --repo|--applescript|--archive)
            if [ "$#" -lt 2 ]; then printf 'Missing argument: %s\n' "$1" >&2; exit 2; fi
            case "$1" in
                --repo) REPO=$2 ;;
                --applescript) GUI=$2 ;;
                --archive) ARCHIVE=$2 ;;
            esac
            shift 2 ;;
        --help|-h) usage; exit 0 ;;
        *) printf 'Unknown argument: %s\n' "$1" >&2; usage >&2; exit 2 ;;
    esac
done
[ -n "$GUI" ] || { [ ! -f "$SCRIPT_DIR/AppleScript_GUI_reference.txt" ] || GUI=$SCRIPT_DIR/AppleScript_GUI_reference.txt; }

LAUNCHER=$REPO/rogue-mac
FORMULA=$REPO/rogue-mac.rb
printf '%s\n' '=== Rogue for macOS / Stage 5-B integration checks ==='
if [ "$(uname -s)" = Darwin ]; then pass 'macOS host'; else warn 'Not macOS: only static/portable checks are possible'; fi
if [ ! -f "$LAUNCHER" ]; then fail "Launcher missing: $LAUNCHER"; else
    if sh -n "$LAUNCHER"; then pass 'rogue-mac: sh -n'; else fail 'rogue-mac: shell syntax'; fi
    if command -v dash >/dev/null 2>&1; then
        if dash -n "$LAUNCHER"; then pass 'rogue-mac: dash -n'; else fail 'rogue-mac: dash syntax'; fi
    fi
    if [ -x "$LAUNCHER" ]; then pass 'Launcher executable'; else warn 'Launcher is not executable (can run via sh)'; fi
    version=$({ "$LAUNCHER" --version; } 2>/dev/null) || version=''
    case "$version" in
        'rogue-mac 0.3.25') pass 'Expected 028 launcher version: 0.3.25' ;;
        'rogue-mac '*) warn "Version differs from 028 package: $version" ;;
        *) fail 'Cannot read launcher version' ;;
    esac
    if "$LAUNCHER" --help 2>/dev/null | grep -Fq 'Rogue for macOS'; then pass 'Help command'; else fail 'Help command'; fi
    versions=$({ "$LAUNCHER" --list; } 2>/dev/null) || versions=''
    n=$(printf '%s\n' "$versions" | grep -c '^\([1-5]\)\. Rogue ' || :)
    if [ "$n" -eq 5 ]; then pass 'All five version menu entries'; else fail 'Version list is incomplete'; fi
    # Only the exit status is checked; do not reveal user-specific content.
    if "$LAUNCHER" --show-rogueopts >/dev/null 2>&1; then
        pass 'Login-shell ROGUEOPTS inspection returned (contents hidden)'
    else
        warn 'Login-shell ROGUEOPTS inspection failed'
    fi
    if grep -Fq "52) printf '%s' 'color cursor terse flush jump step askme passgo name fruit language file'" "$LAUNCHER" &&
       grep -Fq "clone:jump|36:jump) printf 'jump'" "$LAUNCHER" &&
       grep -Fq '52:cursor|52:flush|52:step|52:terse|52:jump)' "$LAUNCHER" &&
       ! grep -Fq '52:jump) append_game_option "$item"; continue ;;' "$LAUNCHER"; then
        pass '5.2 jump: CUI All options offers separate On/Off choices'
    else
        fail '5.2 jump: expected CUI All options entry or handling missing'
    fi
    if grep -Fq 'add_state=$(advanced_pref_read "$add_opt")' "$LAUNCHER" &&
       grep -Fq '[ "$extra_override" = inherit ] || continue' "$LAUNCHER" &&
       ! grep -Fq 'if [ "$S_JUMP" = True ]; then append_game_option jump; else append_game_option nojump; fi' "$LAUNCHER"; then
        pass '5.2 jump: explicit CUI choice overrides shell; otherwise external/default applies'
    else
        fail '5.2 jump: unexpected forced or missing override logic'
    fi
    if grep -Fq 'DEFAULTS_DOMAIN=com.leopard.rogue' "$LAUNCHER"; then pass 'Shared preference domain: CUI'; else fail 'Unexpected CUI preference domain'; fi
    if grep -Fq 'EXTERNAL_ROGUEOPTS=$(read_external_rogueopts)' "$LAUNCHER"; then pass 'ROGUEOPTS refreshed at game launch'; else warn 'No launch-time external refresh detected'; fi
    if grep -Fq 'clear_terminal_screen' "$LAUNCHER" && grep -Fq 'reset_screen_colors' "$LAUNCHER"; then pass 'Terminal reset/clear paths present'; else warn 'Terminal reset paths not detected'; fi
fi

if [ -f "$FORMULA" ]; then
    if command -v ruby >/dev/null 2>&1 && ruby -c "$FORMULA" >/dev/null 2>&1; then
        pass 'Homebrew Formula: Ruby syntax'
    elif command -v ruby >/dev/null 2>&1; then
        fail 'Homebrew Formula: Ruby syntax'
    else
        warn 'Ruby not installed: Formula syntax not checked'
    fi
    for dependency in rogue54 rogue-c3 rogue-dos rogue36 rogue52; do
        if grep -Fq 'depends_on "leopard-gecko/game/'"$dependency"'"' "$FORMULA"; then
            pass "Formula dependency: $dependency"
        else
            fail "Formula missing dependency: $dependency"
        fi
    done
    if grep -Fq 'vrogue-mac.028/rogue-mac-028.tar.gz' "$FORMULA"; then pass 'Formula targets Release 028'; else warn 'Formula Release URL differs from 028'; fi
    if grep -Fq 'version "0.3.25"' "$FORMULA"; then pass 'Formula version matches 028 package'; else warn 'Formula version differs from 028'; fi
else
    fail "Formula missing: $FORMULA"
fi

if [ -f "$GUI" ]; then
    if grep -Fq 'property suiteName : "com.leopard.rogue"' "$GUI"; then pass 'GUI/CUI preference domain matches'; else fail 'GUI preference domain differs'; fi
    for p in SavedVersion54 SavedVersionCloneIII SavedVersionDOS148 SavedVersion36 SavedVersion52; do
        if grep -Fq 'return "'"$p"'"' "$GUI" && grep -Fq "printf '$p'" "$LAUNCHER"; then
            pass "Shared version-key prefix: $p"
        else
            fail "Version-key prefix mismatch or not found: $p"
        fi
    done
    for key in Savedmyname Savedmyfruit Savedmygameversion; do
        if grep -Fq '"'"$key"'"' "$GUI" && grep -Fq "$key" "$LAUNCHER"; then
            pass "Shared profile key: $key"
        else
            fail "Shared profile key missing: $key"
        fi
    done
    for save_name in rogue.save rogue-clone.save rogue-dos.save rogue36.save rogue52.save; do
        if grep -Fq '"'"$save_name"'"' "$GUI" && grep -Fq "$save_name" "$LAUNCHER"; then
            pass "Save filename aligned: $save_name"
        else
            fail "Save filename mismatch: $save_name"
        fi
    done
    if grep -Fq 'if mygameversion is "5.2" then' "$GUI" &&
       grep -Fq 'set opjump to ""' "$GUI" &&
       grep -Fq 'jump/nojumpはランチャーから指定せず' "$GUI" &&
       grep -Fq 'if optName is "jump" and my versionHasJump() then return true' "$GUI"; then
        pass 'Current GUI 5.2 jump: external-only (no forced setting)'
    else
        warn 'GUI 5.2 external-only jump behavior not detected'
    fi
    if grep -Fq '" -lic "' "$GUI" && grep -Fq ' -lic "$ex_probe"' "$LAUNCHER"; then
        pass 'Both launchers probe interactive login shells'
    else
        warn 'Login-shell probe markers not detected in both sources'
    fi
else
    info 'GUI comparison omitted: pass --applescript FILE for a full source comparison'
fi

if command -v defaults >/dev/null 2>&1; then
    if defaults read com.leopard.rogue >/dev/null 2>&1; then
        pass 'Existing GUI/CUI preference domain is readable (values hidden)'
        for key in Savedmygameversion Savedmyname Savedmyfruit; do
            if defaults read com.leopard.rogue "$key" >/dev/null 2>&1; then
                pass "Saved preference exists: $key (value hidden)"
            else
                info "Saved preference unset: $key"
            fi
        done
    else
        info 'No com.leopard.rogue preferences saved yet; this is not an error'
    fi
else
    warn 'defaults unavailable: macOS preference store cannot be inspected here'
fi

if [ -n "$ARCHIVE" ]; then
    if [ -f "$ARCHIVE" ] && [ -f "$FORMULA" ]; then
        expected=$(sed -n 's/^[[:space:]]*sha256 "\([0-9a-f]*\)".*/\1/p' "$FORMULA" | head -n 1)
        actual=''
        if command -v shasum >/dev/null 2>&1; then
            actual=$(shasum -a 256 "$ARCHIVE" | awk '{print $1}')
        elif command -v sha256sum >/dev/null 2>&1; then
            actual=$(sha256sum "$ARCHIVE" | awk '{print $1}')
        fi
        if [ -z "$actual" ]; then warn 'SHA-256 tool unavailable'
        elif [ "$actual" = "$expected" ]; then pass 'Release tarball SHA-256 matches Formula'
        else fail 'Release tarball SHA-256 differs from Formula'
        fi
    else
        fail 'Cannot read supplied Release archive or Formula'
    fi
fi

printf '\nResult: PASS=%s WARN=%s FAIL=%s\n' "$PASS" "$WARN" "$FAIL"
info 'Static checks do not replace interactive Terminal.app, GUI or gameplay verification.'
[ "$FAIL" -eq 0 ]
