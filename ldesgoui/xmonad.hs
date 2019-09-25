import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.Scratchpad

x = 9 / 16
y = 9 / 9

center x y = W.RationalRect ((1 - x) / 2) ((1 - y) / 2) x y

main = xmonad $ ewmh $ def
    { borderWidth = 0
    , handleEventHook = fullscreenEventHook
    , manageHook = composeAll
        [ title     =? "eia3de" --> doFloat
        , className =? "Steam"  --> doFloat
        , scratchpadManageHook $ center x y
        ]
    , modMask = mod4Mask
    , terminal = "alacritty"
    }
    `additionalKeysP`
    [ ("M-C-<Return>",  safeSpawn "xdg-open" ["http://"])
    , ("<Print>",       spawn "maim | xclip -t image/png -selection clipboard")
    , ("M-<Print>",     spawn "maim -s | xclip -t image/png -selection clipboard")
    , ("M-`",           scratchpadSpawnActionCustom "alacritty --class scratchpad")
    ]
