import XMonad
import XMonad.Config.Azerty
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

-- Define amount and names of workspaces  
myWorkspaces = ["1:main","2:web","3:multimedia","4","5","6","7","8"]
 
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "Firefox-bin"   --> doShift "2:web"
    ]
 
main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/superancetre/.xmobarrc"
    xmonad $ azertyConfig
        { manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook azertyConfig
        , layoutHook = avoidStruts  $  layoutHook azertyConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        }
