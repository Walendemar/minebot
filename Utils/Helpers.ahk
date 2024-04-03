#Requires AutoHotkey v2.0
#Include ..\Constant\Screen.ahk

getScreenSize() {
    xCoord := SysGet(78)
    yCoord := SysGet(79)
    
    GameWindow.rightBottomX := xCoord
    GameWindow.rightBottomY := yCoord
}
