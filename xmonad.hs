import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
--import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Hooks.SetWMName
import XMonad.Layout.ResizableTile
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog


myLayout = desktopLayoutModifiers $ tiledHalf ||| 
              Mirror tiledTwoThirds ||| noBorders Full 
 where  
      -- default tiling algorithm partitions the screen into two panes  
      tiledTwoThirds = ResizableTall nmaster delta (2/3) []
--      tiledThreeQuarters = Tall nmaster delta (3/4)
      tiledHalf = ResizableTall nmaster delta (1/2) []
--      fullscreenLayout = avoidStruts (
--        Tall 1 (3/100) (1/2)            |||
--        Mirror (Tall 1 (3/100) (1/2))   |||
--        noBorders (fullscreenFull Full))
   
      -- The default number of windows in the master pane  
      nmaster = 1  
   
      -- Percent of screen to increment by when resizing panes  
      delta = 10/100

myManageHook = composeAll . concat $
	[
		[manageDocks],
		[resource =? "synapse" 	--> doIgnore,
		 resource =? "xfce4-notifyd" 	--> doIgnore
		]
	]

myKeys :: [(String, X ())]
myKeys = [
            ("M-a", sendMessage MirrorExpand)
          , ("M-z", sendMessage MirrorShrink)
          , ("M1-<F2>", spawn "synapse")
          , ("<XF86TouchpadToggle>", spawn "~/touchpadToggle.sh")
          ]

main :: IO ()
main =
  xmonad $ defaultConfig { 
	layoutHook = myLayout,
	modMask = mod4Mask,
	manageHook = myManageHook,
  startupHook = setWMName "LG3D" -- This is to convince Java that we're a legit WM.
} `additionalKeysP` myKeys
