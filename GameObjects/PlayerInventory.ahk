#Requires AutoHotkey v2.0
#Include ..\Actions\Interface.ahk

class PlayerInventory {
    Inventory := {
        Package : [],
        Hotbar: [],
    }

    ; picture urls
    cellSize := Elements.PlayerInterface.InventoryCell.size

    __New() {

    }

    scanStore(FirstCell) {
        Loop 3 {
            PackageLine := []
            iteration := A_Index

            Loop 9 {
                leftTopCoordX := FirstCell[1] + (this.cellSize + 6) * (A_Index - 1)
                leftTopCoordY := FirstCell[2] + (this.cellSize + 6) * (iteration - 1)
                rightBottomCoordX := leftTopCoordX + this.cellSize
                rightBottomCoordY := leftTopCoordY + this.cellSize

                Item := checkInventoryCellItem([leftTopCoordX, leftTopCoordY], [rightBottomCoordX, rightBottomCoordY])
                name := Item.name
                
                PackageLineCell := {
                    row: iteration,
                    column: A_Index,
                    leftTopCellCoords: [ leftTopCoordX, leftTopCoordY ],
                    rightBottomCellCoords: [ rightBottomCoordX, rightBottomCoordY ],
                    name: name,
                    amount: 0,
                    temperature: "",
                    isTaken: name == "EmptyCell" ? false : true
                }

                if Item.HasOwnProp("id") {
                    PackageLineCell.id := Item.id
                }

                PackageLine.Push(packageLineCell)
            }

            this.Inventory.package.Push(packageLine)
        }

        StringifyAsJSON(this.Inventory)
    }
}