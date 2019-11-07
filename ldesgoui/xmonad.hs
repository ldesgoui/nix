import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad

main =
  xmonad $
  ewmh $
  def
    { borderWidth = 0
    , handleEventHook = fullscreenEventHook
    , manageHook =
        composeAll
          [ title       =? "eia3de"   --> doFloat
          , className   =? "Steam"    --> doFloat
          , scratchpadManageHook $ center (9 / 16) (9 / 9)
          ]
    , modMask = mod4Mask
    , terminal = "alacritty"
    } `additionalKeysP`
  [ ("M-C-<Return>",    spawn "xdg-open http://")
  , ("<Print>",         spawn "maim    | xclip -t image/png -selection clipboard")
  , ("M-<Print>",       spawn "maim -s | xclip -t image/png -selection clipboard")
  , ("M-=",             spawn "pamixer -i 5" *> spawn showVolume)
  , ("M--",             spawn "pamixer -d 5" *> spawn showVolume)
  , ("M-`",             scratchpadSpawnActionCustom "alacritty --class scratchpad")
  ]
  where
    center x y = W.RationalRect ((1 - x) / 2) ((1 - y) / 2) x y
    showVolume =
      unwords
        [ "notify-send"
        , "-h string:x-canonical-private-synchronous:volume-notify"
        , "\"Volume: $(pamixer --get-volume-human)\""
        ]
