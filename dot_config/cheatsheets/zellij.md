# keybinds
## normal
- Alt + c Copy

## locked 
- Ctrl + g Toggle Lock Mode

## resize 
- Ctrl n SwitchToMode Normal
- h Left Increase Left 
- j Down Increase Down 
- k Up Increase Up
- l Right Increase Right
- H Decrease Left
- J Decrease Down
- K Decrease Up
- L Decrease Right
- = Increase
- - Decrease
 
## pane 
- Ctrl p SwitchToMode Normal ; 
- h Left MoveFocus Left ; 
- l Right MoveFocus Right ; 
- j Down MoveFocus Down ; 
- k Up MoveFocus Up ; 
- p SwitchFocus; 
- n NewPane; SwitchToMode Normal ; 
- d NewPane Down ; SwitchToMode Normal ; 
- r NewPane Right ; SwitchToMode Normal ; 
- x CloseFocus; SwitchToMode Normal ; 
- f ToggleFocusFullscreen; SwitchToMode Normal ; 
- z TogglePaneFrames; SwitchToMode Normal ; 
- w ToggleFloatingPanes; SwitchToMode Normal ; 
- e TogglePaneEmbedOrFloating; SwitchToMode Normal ; 
- c SwitchToMode RenamePane ; PaneNameInput 0;
 
## move 
- Ctrl h SwitchToMode Normal ; 
- n Tab MovePane; 
- p MovePaneBackwards; 
- h Left MovePane Left ; 
- j Down MovePane Down ; 
- k Up MovePane Up ; 
- l Right MovePane Right ; 
 
## tab 
- Ctrl t SwitchToMode Normal ; 
- r SwitchToMode RenameTab ; TabNameInput 0; 
- h Left Up k GoToPreviousTab; 
- l Right Down j GoToNextTab; 
- n NewTab; SwitchToMode Normal ; 
- x CloseTab; SwitchToMode Normal ; 
- s ToggleActiveSyncTab; SwitchToMode Normal ; 
- 1 GoToTab 1; SwitchToMode Normal ; 
- 2 GoToTab 2; SwitchToMode Normal ; 
- 3 GoToTab 3; SwitchToMode Normal ; 
- 4 GoToTab 4; SwitchToMode Normal ; 
- 5 GoToTab 5; SwitchToMode Normal ; 
- 6 GoToTab 6; SwitchToMode Normal ; 
- 7 GoToTab 7; SwitchToMode Normal ; 
- 8 GoToTab 8; SwitchToMode Normal ; 
- 9 GoToTab 9; SwitchToMode Normal ; 
- Tab ToggleTab; 
 
## scroll 
- Ctrl s SwitchToMode Normal ; 
- e EditScrollback; SwitchToMode Normal ; 
- s SwitchToMode EnterSearch ; SearchInput 0; 
- Ctrl c ScrollToBottom; SwitchToMode Normal ; 
- j Down ScrollDown; 
- k Up ScrollUp; 
- Ctrl f PageDown Right l PageScrollDown; 
- Ctrl b PageUp Left h PageScrollUp; 
- d HalfPageScrollDown; 
- u HalfPageScrollUp; 
- // uncomment this and adjust key if using copy_on_select=false
- // Alt c Copy; 
 
## search 
- Ctrl s SwitchToMode Normal ; 
- Ctrl c ScrollToBottom; SwitchToMode Normal ; 
- j Down ScrollDown; 
- k Up ScrollUp; 
- Ctrl f PageDown Right l PageScrollDown; 
- Ctrl b PageUp Left h PageScrollUp; 
- d HalfPageScrollDown; 
- u HalfPageScrollUp; 
- n Search down ; 
- p Search up ; 
- c SearchToggleOption CaseSensitivity ; 
- w SearchToggleOption Wrap ; 
- o SearchToggleOption WholeWord ; 
 
## entersearch 
- Ctrl c Esc SwitchToMode Scroll ; 
- Enter SwitchToMode Search ; 
 
## renametab 
- Ctrl c SwitchToMode Normal ; 
- Esc UndoRenameTab; SwitchToMode Tab ; 
 
## renamepane 
- Ctrl c SwitchToMode Normal ; 
- Esc UndoRenamePane; SwitchToMode Pane ; 
 
## session 
- Ctrl o SwitchToMode Normal ; 
- Ctrl s SwitchToMode Scroll ; 
- d Detach; 
 
## tmux 
- [ SwitchToMode Scroll ; 
- Ctrl b Write 2; SwitchToMode Normal ; 
- \ NewPane Down ; SwitchToMode Normal ; 
- % NewPane Right ; SwitchToMode Normal ; 
- z ToggleFocusFullscreen; SwitchToMode Normal ; 
- c NewTab; SwitchToMode Normal ; 
- , SwitchToMode RenameTab ; 
- p GoToPreviousTab; SwitchToMode Normal ; 
- n GoToNextTab; SwitchToMode Normal ; 
- Left MoveFocus Left ; SwitchToMode Normal ; 
- Right MoveFocus Right ; SwitchToMode Normal ; 
- Down MoveFocus Down ; SwitchToMode Normal ; 
- Up MoveFocus Up ; SwitchToMode Normal ; 
- h MoveFocus Left ; SwitchToMode Normal ; 
- l MoveFocus Right ; SwitchToMode Normal ; 
- j MoveFocus Down ; SwitchToMode Normal ; 
- k MoveFocus Up ; SwitchToMode Normal ; 
- o FocusNextPane; 
- d Detach; 
- Space NextSwapLayout; 
- x CloseFocus; SwitchToMode Normal ; 
 
## shared_except locked 
- Ctrl g SwitchToMode Locked ; 
- Ctrl q Quit; 
- Alt n NewPane; 
- Alt h Alt Left MoveFocusOrTab Left ; 
- Alt l Alt Right MoveFocusOrTab Right ; 
- Alt j Alt Down MoveFocus Down ; 
- Alt k Alt Up MoveFocus Up ; 
- Alt = Alt + Increase ; 
- Alt - Decrease ; 
- Alt [ PreviousSwapLayout; 
- Alt ] NextSwapLayout; 
 
## shared_except normal locked 
- Enter Esc SwitchToMode Normal ; 
 
## shared_except pane locked 
- Ctrl p SwitchToMode Pane ; 
 
## shared_except resize locked 
- Ctrl n SwitchToMode ; 
 
## shared_except scroll locked 
- Ctrl s SwitchToMode Scroll ; 
 
## shared_except session locked 
- Ctrl o SwitchToMode Session ; 
 
## shared_except tab locked 
- Ctrl t SwitchToMode Tab ; 
 
## shared_except move locked 
- Ctrl h SwitchToMode Move ; 
 
## shared_except tmux locked 
- Ctrl b SwitchToMode Tmux ; 
 