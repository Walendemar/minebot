#Requires AutoHotkey v2.0
#Include ..\Utils\ObjToStr.ahk
#Include ..\Constant\InterfaceElements.ahk
#Include ..\Actions\Interface.ahk
#Include ..\Constant\Screen.ahk
#Include ..\GameObjects\PlayerInventory.ahk

class PlayerInterface extends PlayerInventory {
    __New() {
        super.__New()

        isInventoryUIOpen := 0

        While isInventoryUIOpen = 0 {
            isInventoryUIOpen := this.checkUIOpen()

            if isInventoryUIOpen = 0 {
                openInterface()
            }
        }
                
        if (this.FirstCell.Length > 0) {
            this.scanStore(this.FirstCell)
        } else {
            MsgBox "error!"
        }

        Sleep(100)

        closeInterface()
    }
}