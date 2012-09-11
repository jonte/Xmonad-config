import XMonad
import XMonad.Config.Xfce
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Hooks.SetWMName
 
myLayout = desktopLayoutModifiers $ tiledHalf ||| tiledTwoThirds ||| 
              tiledThreeQuarters ||| Mirror tiledTwoThirds ||| Full ||| fullscreenLayout
 where  
      -- default tiling algorithm partitions the screen into two panes  
      tiledTwoThirds = Tall nmaster delta (2/3)
      tiledThreeQuarters = Tall nmaster delta (3/4)
      tiledHalf = Tall nmaster delta (1/2)
      fullscreenLayout = avoidStruts (
        Tall 1 (3/100) (1/2)            |||
        Mirror (Tall 1 (3/100) (1/2))   |||
        noBorders (fullscreenFull Full))
   
      -- The default number of windows in the master pane  
      nmaster = 1  
   
      -- Percent of screen to increment by when resizing panes  
      delta = 5/100

myManageHook = composeAll . concat $
	[
		[manageDocks],
		[resource =? "synapse" 	--> doIgnore,
		 resource =? "xfce4-notifyd" 	--> doIgnore
		]
	]
   
main :: IO ()
main = xmonad $ xfceConfig { 
	layoutHook = myLayout,
	modMask = mod4Mask,
	manageHook = myManageHook <+> manageHook xfceConfig,
  startupHook = setWMName "LG3D" -- This is to convince Java that we're a legit WM.
}
