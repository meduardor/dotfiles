import XMonad
import XMonad.Operations
import System.IO
import System.Exit
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Actions.SpawnOn
import XMonad.Util.NamedScratchpad
import XMonad.Util.EZConfig(additionalKeys)

import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.CycleWS
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks    -- dock/tray mgmt
import Data.Monoid
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import System.Exit
--Layouts
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Fullscreen
import XMonad.Layout.ToggleLayouts          -- Full window at any time
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Mosaic
import XMonad.Layout.ThreeColumns

myTerminal = "alacritty"
myBrowser = "firefox"
myXmobarrc = "/home/merds/.xmobarrc"
---- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myWorkspaces            :: [String]
myWorkspaces            =  ["1:web","2:chat","3:code", "4:down","5:film","6:a","7:b","8:c","9"]

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask,              xK_Return), spawn myTerminal)

    -- launch dmenu
    , ((modMask,               xK_d     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")

    , ((modMask,               xK_i     ), spawn myBrowser)
    -- launch gmrun
    , ((modMask .|. shiftMask, xK_p     ), spawn "telegram-desktop")
   -- close focused window
    , ((modMask .|. shiftMask, xK_BackSpace     ), kill)
     -- switch keyboard layout
  --  , ((modMask .|. mod1Mask,               xK_u     ), spawn "setxkbmap -layout us")
  --  , ((modMask .|. mod1Mask, xK_d     ), spawn "setxkbmap -layout dvorak")
    --- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modMask,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), windows W.focusUp  )
    -- Volume Control
    ,((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%- unmute")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+ unmute")

    -- Brightness Control
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10")
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 10")

    -- Move focus to the master window
    , ((modMask,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling

    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
     , ((modMask              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    -- Screenshot
    , ((controlMask .|. mod1Mask, xK_p), spawn "scrot -s")
    , ((controlMask, xK_p), spawn "scrot")

    -- Restart xmonad
    , ((mod1Mask .|. shiftMask             , xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modMask              , xK_o    ), namedScratchpadAction myScratchPads "terminal")
    , ((modMask,                xK_p    ), namedScratchpadAction myScratchPads "music")
    , ((modMask              , xK_f), sendMessage (Toggle "Full"))
    , ((controlMask .|. mod1Mask, xK_Right), nextWS)
    , ((controlMask .|. mod1Mask, xK_Left), prevWS)
    ]
     ++


    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++


    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
---spawn
--
myStartupHook = do
  setWMName "LG3D"
  -- spawnOnce "~/runpaper.sh"
  spawnOnce "watch -n 1200 feh randomize --bg-fill ~/Imagens/*.jpg &"
  -- spawnOnce "/home/merds/.config/polybar/launch.sh"
    
myScratchPads = [ NS "terminal" spawnTerm  findTerm manageTerm
		, NS "music" spawnPav findPav  managePav
		]
	where

    spawnTerm = myTerminal ++  " -name scratchpad -e cmus"
    findTerm = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h -- and I'd like it fixed using the geometry below

	where

        -- reusing these variables is ok since they're confined to their own
        -- where clauses
        h = 1       -- height, 10%
        w = 1         -- width, 100%
        t = 1 - h     -- bottom edge
        l = 1 -w -- centered left/right
    spawnPav = "spotify"
    findPav = className =? "Spotify"
    managePav = customFloating $ W.RationalRect l t w h -- and I'd like it fixed using the geometry below

	where

        -- reusing these variables is ok since they're confined to their own
        -- where clauses
        h = 1      -- height, 10%
        w = 1         -- width, 100%
        t = 1 -h      -- bottom edge
        l = 1 -w -- centered left/right

myManageHook = composeAll
    [ className =? "stalonetray"    --> doIgnore
      , className =? "Firefox"      --> doFullFloat
      , title =? "FEZ"              --> doFullFloat
      , title =? "Don't Starve"     --> doFullFloat
      , className =? "telegram-desktop"     --> doCenterFloat
      , manageDocks
      , isFullscreen                --> (doF W.focusDown <+> doFullFloat)
    ] <+> namedScratchpadManageHook myScratchPads

-- Mouse bindings

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

myLayoutHook = avoidStruts (
       toggleLayouts Full (Grid) ||| toggleLayouts Full (ThreeColMid 1 (1/20) (1/2)) ||| simpleTabbed ||| toggleLayouts Full (tiled) ||| Mirror tiled)
        where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
delta = 3/100
----Main Function
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh $ docks $ defaults {
	logHook = dynamicLogWithPP $ xmobarPP {
	    ppOutput = hPutStrLn xmproc
	    ,ppVisible = xmobarColor "#7F7F7F" ""
	    ,ppTitle = xmobarColor "#FFFFFF" ""
	    ,ppCurrent = xmobarColor "#2E9AFE" ""
        ,ppHidden  = xmobarColor "#7F7F7F" ""
	    ,ppLayout = xmobarColor"#7F7F7F" ""
        ,ppUrgent = xmobarColor "#900000" "" . wrap "[" "]"
        }
	, manageHook = manageDocks <+> myManageHook
	, startupHook = myStartupHook <+> startupHook defaults
    }

defaults = def{
    modMask= mod4Mask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    , keys = myKeys
    , layoutHook = smartBorders $ myLayoutHook
    , focusedBorderColor = "#2E9AFE"
    , normalBorderColor = "#000000"
    , mouseBindings = myMouseBindings
    , manageHook = myManageHook <+> manageHook def
    , borderWidth         = 2
    , startupHook = myStartupHook
}
