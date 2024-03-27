#Requires AutoHotkey v2.0
#Include C:\Users\user\Documents\minebot\Utils\ObjToStr.ahk
#Include C:\Users\user\Documents\minebot\Constant\InterfaceElements.ahk
#Include C:\Users\user\Documents\minebot\Actions\Interface.ahk
#Include C:\Users\user\Documents\minebot\Constant\Screen.ahk

class PlayerInterface {
    Inventory := {
        Package : [],
        Hotbar: [],
    }

    ; TODO Разумно ли их так выносить?
    FirstCell := [
        Elements.PlayerInterface.FirstPlayerInventoryStoreCell.leftTopX,
        Elements.PlayerInterface.FirstPlayerInventoryStoreCell.leftTopY
    ]
    cellSize := Elements.PlayerInterface.InventoryCell.size
    inventoryCreateWordUrl := Elements.PlayerInterface.CreateWord.url
    
    __New() {
        isInventoryUIOpen := 0

        While isInventoryUIOpen = 0 {
            isInventoryUIOpen := this.checkInventoryUIOpen()

            if isInventoryUIOpen = 0 {
                openInterface()
            }
        }

        this.scanStore()

        Sleep(100)

        closeInterface()
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
            PackageLine := []
            iteration := A_Index

            Loop 9 {
                leftTopCoordX := this.FirstCell[1] + (this.cellSize + 6) * (A_Index - 1)
                leftTopCoordY := this.FirstCell[2] + (this.cellSize + 6) * (iteration - 1)
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