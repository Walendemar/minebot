#Requires AutoHotkey v2.0
#Include C:\Users\user\Documents\minebot\Utils\ObjToStr.ahk
#Include C:\Users\user\Documents\minebot\Constant\InterfaceElements.ahk
#Include C:\Users\user\Documents\minebot\Operation\Interface.ahk
#Include C:\Users\user\Documents\minebot\Constant\Screen.ahk

class PlayerInventory {
    inventory := {
        Package : [],
        Hotbar: [],
    }

    ; TODO Разумно ли их так выносить?
    FirstCell := [
        Elements.PlayerInventory.FirstPlayerInventoryStoreCell.leftTopX,
        Elements.PlayerInventory.FirstPlayerInventoryStoreCell.leftTopY
    ]
    cellSize := Elements.PlayerInventory.InventoryCell.size
    inventoryCreateWordUrl := Elements.PlayerInventory.CreateWord.url
    
    __New() {
        isInventoryUIOpen := 0

        While isInventoryUIOpen = 0 {
            isInventoryUIOpen := this.checkInventoryUIOpen()

            if isInventoryUIOpen = 0 {
                openPlayerInterface()
            }
        }

        this.scanStore()

        Sleep(200)

        closeInventory()
    }

    ; TODO Можно ли как-то универсализировать эту функцию?
    checkInventoryUIOpen() {
        isOpen := ImageSearch(
            &xCoord,
            &yCoord,
            GameWindow.leftTopX,
            GameWindow.leftTopY,
            GameWindow.rightBottomX,
            GameWindow.rightBottomY,
            this.inventoryCreateWordUrl
        )
    
        return isOpen
    }

    scanStore() {
        Loop 3 {
            packageLine := []
            iteration := A_Index

            Loop 9 {
                leftTopCoordX := this.FirstCell[1] + (this.cellSize + 6) * (A_Index - 1)
                leftTopCoordY := this.FirstCell[2] + (this.cellSize + 6) * (iteration - 1)
                rightBottomCoordX := leftTopCoordX + this.cellSize
                rightBottomCoordY := leftTopCoordY + this.cellSize

                Item := checkInventoryCellItem([leftTopCoordX, leftTopCoordY], [rightBottomCoordX, rightBottomCoordY])
                name := Item.name
                
                packageLineCell := {
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
                    packageLineCell.id := Item.id
                }

                packageLine.Push(packageLineCell)
            }

            this.inventory.package.Push(packageLine)
        }

        StringifyAsJSON(this.inventory)
    }
}