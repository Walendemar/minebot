#Requires AutoHotkey v2.0

#Include ..\Constant\InterfaceElements.ahk
#Include ..\Constant\Items.ahk
#Include ..\Constant\Screen.ahk

openInterface() {
    Sleep(20)
    Send "{e down}"
    Sleep(20)
    Send "{e up}"
    Sleep(20)
    Sleep(200)
    MouseMove(120, 120)
    Sleep(200)
}

closeInterface() {
    MouseMove(SightPointer[1], SightPointer[2])
    Sleep(20)
    Send "{e down}"
    Sleep(20)
    Send "{e up}"
    Sleep(20)
    Sleep(200)
}
