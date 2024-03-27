#Requires AutoHotkey v2.0
#Include ..\..\GameObjects\Tooltip\Tooltip.ahk
#Include ..\..\Constant\InterfaceElements.ahk

class CapacityTooltip extends Tooltip {
    slashUrl := Elements.Tooltip.Symbols.Slash.url
    slashCoords := {
        coordX: "",
        coordY: ""
    }

    __New() {
        super.__New()

        this.findSlash()
    }

    findSlash() {
        if (
            this.Borders.isFoundLeftCorner and 
            this.Borders.isFoundRightCorner
        ) {
            isFound := ImageSearch(
                &slashCoordX,
                &slashCoordY,
                this.Borders.leftTopCornerX,
                this.Borders.leftTopCornerY,
                this.Borders.rightBottomCornerX,
                this.Borders.rightBottomCornerY,
                "*15 " . this.slashUrl
            )
        }
        
        this.slashCoords.coordX := slashCoordX
        this.slashCoords.coordY := slashCoordY
    }
}