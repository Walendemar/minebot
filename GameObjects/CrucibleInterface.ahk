#Requires AutoHotkey v2.0

#Include ..\Constant\Screen.ahk
#Include ..\Constant\InterfaceElements.ahk
#Include ..\GameObjects\Tooltip\CapacityTooltip.ahk

class CrucibleInterface {
    name := ''
    Sign := {
        url: Elements.CrucibleInterface.Sign.url,
        Coords: []
    }
    metalQuantity := 0

    rulerUrl := Elements.CrucibleInterface.Ruler.url
    outputUrl := Elements.CrucibleInterface.Output.url

    __New(crucibleName) {
        name := crucibleName
    }

    checkInventoryUIOpen() {
        isOpen := ImageSearch(
            &xCoord,
            &yCoord,
            CrucibleInterfaceWindow.leftTopX,
            CrucibleInterfaceWindow.leftTopY,
            CrucibleInterfaceWindow.rightBottomX,
            CrucibleInterfaceWindow.rightBottomY,
            this.Sign.url
        )

        if (this.Sign.Coords.Length = 0) {
            this.Sign.Coords := [xCoord, yCoord]
        }
    
        return isOpen
    }

    checkCrucibleIsEmpty() {
        isEmpty := !ImageSearch(
            &xCoord,
            &yCoord,
            CrucibleRulerPlace.leftTopX,
            CrucibleRulerPlace.leftTopY,
            CrucibleRulerPlace.rightBottomX,
            CrucibleRulerPlace.rightBottomY,
            this.rulerUrl
        )
    
        return isEmpty
    }

    checkCrucibleOutputIsEmpty() {
        isEmpty := !ImageSearch(
            &xCoord,
            &yCoord,
            CrucibleOutputPlace.leftTopX,
            CrucibleOutputPlace.leftTopY,
            CrucibleOutputPlace.rightBottomX,
            CrucibleOutputPlace.rightBottomY,
            this.outputUrl
        )
    
        return isEmpty
    }

    getMetalQuantity() {
        MouseMove(this.Sign.Coords[1], this.Sign.Coords[2] + 60)

        Sleep(100)

        crucibleTooltip := CapacityTooltip()

        metalQuantity := crucibleTooltip.getNumber(
            crucibleTooltip.Borders.leftTopCornerX,
            crucibleTooltip.slashCoords.coordY - 5,
            crucibleTooltip.slashCoords.coordX,
            crucibleTooltip.slashCoords.coordY + 40
        )
    }
}