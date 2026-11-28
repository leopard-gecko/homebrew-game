-- Rogue JEC CRT tab-color prototype (2026-11-27, amber + dark block cursor)
-- No Terminal profiles are created, imported, updated, or deleted.
-- Only colors of a specifically identified Terminal tab are changed.
-- Direct tab-color properties are deprecated by Apple; use as a prototype.

on run argv
    if (count of argv) < 1 then error "Operation required." number 7101
    set operation to item 1 of argv as text
    if operation is "open" then
        if (count of argv) is not 2 then error "Usage: open <shell-command>" number 7102
        -- A new Terminal window runs the wrapper. The wrapper identifies
        -- its own TTY and saves/restores colors, including when it exits.
        set shellCommand to item 2 of argv as text
        tell application "Terminal"
            do script shellCommand
            activate
        end tell
        return "Opened a separate Terminal session. No profile was created."
    else if operation is "apply-tty" then
        if (count of argv) is not 3 then error "Usage: apply-tty <white|green|amber> <tty>" number 7103
        return my applyTTY(item 2 of argv as text, item 3 of argv as text)
    else if operation is "restore-tty" then
        if (count of argv) is not 4 then error "Usage: restore-tty <tty> <color-snapshot> <white|green|amber>" number 7104
        return my restoreTTY(item 2 of argv as text, item 3 of argv as text, item 4 of argv as text)
    else if operation is "inspect-tty" then
        if (count of argv) is not 2 then error "Usage: inspect-tty <tty>" number 7105
        return my inspectTTY(item 2 of argv as text)
    else if operation is "reset-tty" then
        if (count of argv) is not 2 then error "Usage: reset-tty <tty>" number 7122
        return my resetTTY(item 2 of argv as text)
    end if
    error "Unknown operation: " & operation number 7106
end run

-- 16-bit RGB values: 8-bit sRGB components multiplied by 257.
-- White (ADM-3A-inspired): #D2DCE8, background #070808
-- Green (P31-inspired):    #2BB84F, background #040704
-- Amber (CRT-inspired):    #E5A000, background #090702
-- Cursor colors are DARK for legible text under a block cursor.
-- Amber is a modern sRGB approximation, not a measured CRT phosphor color.
-- Bold and cursor values are practical legibility choices.
on colorsForMode(modeName)
    if modeName is "white" then
        return {{53970, 56540, 59624}, {59110, 60909, 62451}, {1799, 2056, 2056}, {18504, 23130, 27242}}
    else if modeName is "green" then
        return {{11051, 47288, 20303}, {33924, 62965, 41120}, {1028, 1799, 1028}, {5397, 24415, 13107}}
    else if modeName is "amber" then
        return {{58853, 41120, 0}, {65535, 50115, 19018}, {2313, 1799, 514}, {26214, 17733, 6168}}
    end if
    error "Unknown color mode. Use white, green or amber." number 7107
end colorsForMode

-- Single-level snapshot: exactly 12 decimal integers separated by ASCII spaces.
-- The earlier nested "r,g,b|r,g,b|..." format could fail to parse during
-- restoration (error 7110), leaving the current tab colored.
-- No AppleScript text item delimiters are used by the serializer or parser.
on serializeColors(colorGroup)
    if (count of colorGroup) is not 4 then error "Unexpected color count." number 7109
    set snapshotText to ""
    set componentCount to 0
    repeat with rgbRef in colorGroup
        set rgbValues to contents of rgbRef as list
        if (count of rgbValues) is not 3 then error "Unexpected RGB component count." number 7108
        repeat with componentRef in rgbValues
            set numericComponent to contents of componentRef as integer
            if numericComponent < 0 or numericComponent > 65535 then error "Invalid RGB component." number 7113
            if componentCount > 0 then set snapshotText to snapshotText & " "
            set snapshotText to snapshotText & (numericComponent as text)
            set componentCount to componentCount + 1
        end repeat
    end repeat
    return snapshotText
end serializeColors

on snapshotTab(aTab)
    tell application "Terminal"
        -- Read the tab overrides; do not read or modify its settings set.
        set textRGB to normal text color of aTab
        set boldRGB to bold text color of aTab
        set backgroundRGB to background color of aTab
        set cursorRGB to cursor color of aTab
    end tell
    return my serializeColors({textRGB, boldRGB, backgroundRGB, cursorRGB})
end snapshotTab

on applyTab(aTab, colorGroup)
    tell application "Terminal"
        set normal text color of aTab to item 1 of colorGroup
        set bold text color of aTab to item 2 of colorGroup
        set background color of aTab to item 3 of colorGroup
        set cursor color of aTab to item 4 of colorGroup
    end tell
end applyTab

-- Parsing is flat and deliberately independent of delimiter state/locale.
-- Validate before changing tab colors, rather than discovering a bad snapshot
-- only when the EXIT handler tries to restore.
on parseSnapshot(snapshotText)
    if (length of snapshotText) is 0 then error "Empty color snapshot." number 7110
    repeat with characterRef in characters of snapshotText
        if (characterRef as text) is not in "0123456789 " then error "Invalid character in color snapshot." number 7112
    end repeat
    set valueTokens to words of snapshotText
    if (count of valueTokens) is not 12 then error "Snapshot must contain exactly 12 RGB integers." number 7114
    set nums to {}
    repeat with tokenRef in valueTokens
        set tokenText to contents of tokenRef as text
        set componentNumber to tokenText as integer
        if componentNumber < 0 or componentNumber > 65535 then error "RGB component out of range." number 7113
        set end of nums to componentNumber
    end repeat
    return {{item 1 of nums, item 2 of nums, item 3 of nums}, {item 4 of nums, item 5 of nums, item 6 of nums}, {item 7 of nums, item 8 of nums, item 9 of nums}, {item 10 of nums, item 11 of nums, item 12 of nums}}
end parseSnapshot

on checkTTY(requestedTTY)
    if requestedTTY does not start with "/dev/tty" then error "Invalid TTY name." number 7115
    if (length of requestedTTY) > 45 then error "Invalid TTY length." number 7116
    repeat with eachChar in characters of requestedTTY
        if (eachChar as text) is not in "/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" then error "Invalid TTY character." number 7117
    end repeat
end checkTTY

on applyTTY(modeName, requestedTTY)
    my checkTTY(requestedTTY)
    set colorGroup to my colorsForMode(modeName)
    tell application "Terminal"
        repeat with aWindow in windows
            repeat with aTab in tabs of aWindow
                set actualTTY to ""
                try
                    set actualTTY to tty of aTab as text
                end try
                if actualTTY is requestedTTY then
                    set originalSnapshot to my snapshotTab(aTab)
                    -- Fail safely before changing a single color if the snapshot
                    -- cannot be parsed or does not survive a round-trip.
                    set parsedOriginal to my parseSnapshot(originalSnapshot)
                    if (my serializeColors(parsedOriginal)) is not originalSnapshot then error "Color snapshot round-trip failed. No changes made." number 7121
                    try
                        my applyTab(aTab, colorGroup)
                    on error errMsg number errNum
                        -- Partial writes must not leave an altered tab behind.
                        try
                            my applyTab(aTab, my parseSnapshot(originalSnapshot))
                        end try
                        error errMsg number errNum
                    end try
                    -- Only return a snapshot if all four writes succeeded.
                    return originalSnapshot
                end if
            end repeat
        end repeat
    end tell
    error "Matching Terminal tab not found. No colors changed." number 7118
end applyTTY

on restoreTTY(requestedTTY, snapshotText, modeName)
    my checkTTY(requestedTTY)
    set originalColors to my parseSnapshot(snapshotText)
    tell application "Terminal"
        repeat with aWindow in windows
            repeat with aTab in tabs of aWindow
                set actualTTY to ""
                try
                    set actualTTY to tty of aTab as text
                end try
                if actualTTY is requestedTTY then
                    -- Do not clobber manual edits or another process's colors.
                    -- Terminal may round values; compare per-component with
                    -- a tolerance of one 8-bit step (257 units) for readback rounding.
                    set nowColors to my parseSnapshot(my snapshotTab(aTab))
                    if not (my colorsApproximatelyEqual(nowColors, my colorsForMode(modeName))) then
                        return "SKIPPED: Tab colors changed independently; not overwriting them."
                    end if
                    my applyTab(aTab, originalColors)
                    return "RESTORED: Original tab colors."
                end if
            end repeat
        end repeat
    end tell
    error "Matching Terminal tab not found for restoration." number 7119
end restoreTTY

on colorsApproximatelyEqual(actualColors, expectedColors)
    repeat with i from 1 to 4
        repeat with j from 1 to 3
            set difference to ((item j of (item i of actualColors)) - (item j of (item i of expectedColors)))
            if difference > 257 or difference < -257 then return false
        end repeat
    end repeat
    return true
end colorsApproximatelyEqual

on inspectTTY(requestedTTY)
    my checkTTY(requestedTTY)
    tell application "Terminal"
        repeat with aWindow in windows
            repeat with aTab in tabs of aWindow
                set actualTTY to ""
                try
                    set actualTTY to tty of aTab as text
                end try
                if actualTTY is requestedTTY then
                    return my snapshotTab(aTab)
                end if
            end repeat
        end repeat
    end tell
    error "Matching Terminal tab not found." number 7120
end inspectTTY

-- Recovery for a tab left colored by an earlier failed restoration.
-- Copies four colors FROM the tab's active settings set TO the tab only.
-- It does not rewrite the settings set or create/remove any profiles.
-- If the tab had custom overrides before the test, exact original overrides
-- cannot be reconstructed by this fallback.
on resetTTY(requestedTTY)
    my checkTTY(requestedTTY)
    tell application "Terminal"
        repeat with aWindow in windows
            repeat with aTab in tabs of aWindow
                set actualTTY to ""
                try
                    set actualTTY to tty of aTab as text
                end try
                if actualTTY is requestedTTY then
                    set activeProfile to current settings of aTab
                    set normal text color of aTab to normal text color of activeProfile
                    set bold text color of aTab to bold text color of activeProfile
                    set background color of aTab to background color of activeProfile
                    set cursor color of aTab to cursor color of activeProfile
                    return "RESET: Tab colors now match its active Terminal profile."
                end if
            end repeat
        end repeat
    end tell
    error "Matching Terminal tab not found for reset." number 7123
end resetTTY
