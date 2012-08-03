import XMonad
import XMonad.Config.Xfce
import XMonad.Config.Desktop
 
myLayout = desktopLayoutModifiers $ tiledHalf ||| tiledTwoThirds ||| tiledThreeQuarters ||| Mirror tiledTwoThirds ||| Full  
 where  
      -- default tiling algorithm partitions the screen into two panes  
      tiledTwoThirds = Tall nmaster delta (2/3)
      tiledThreeQuarters = Tall nmaster delta (3/4)
      tiledHalf = Tall nmaster delta (1/2)
   
      -- The default number of windows in the master pane  
      nmaster = 1  
   
      -- Percent of screen to increment by when resizing panes  
      delta = 5/100  
   
main = xmonad $ xfceConfig { layoutHook = myLayout }
