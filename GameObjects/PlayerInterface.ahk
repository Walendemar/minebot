#Requires AutoHotkey v2.0
#Include ..\Utils\ObjToStr.ahk
#Include ..\Constant\InterfaceElements.ahk
#Include ..\Actions\Interface.ahk
#Include ..\Constant\Screen.ahk
#Include ..\GameObjects\PlayerInventory.ahk

class PlayerInterface extends PlayerInventory {
    ; TODO Разумно ли их так выносить?
    FirstCell := []
    Corners := [
        [],
        []
    ]
    isFirstCellFound := 0
    isCornersFound := 0

    ; picture urls
    inventoryCreateWordUrl := Elements.PlayerInterface.CreateWord.url
    leftCornerUrl := Elements.PlayerInterface.LeftCorner.url
    rightCornerUrl := Elements.PlayerInterface.RightCorner.url
    firstCellUrl := Elements.PlayerInterface.FirstCell.url
    
    __New() {
        super.__New()

        isInventoryUIOpen := 0

        While isInventoryUIOpen = 0 {
            isInventoryUIOpen := this.checkInventoryUIOpen()

            if isInventoryUIOpen = 0 {
                openInterface()
            }
        }

        this.getCorner()
        this.getFirstCellCoors()
        if (this.FirstCell.Length > 0) {
            this.scanStore(this.FirstCell)
        } else {
            MsgBox "error!"
        }

        Sleep(100)

        closeInterface()
    }

    getCorner() {
        isFoundLeftCorner := ImageSearch(
            &leftCornerCoordX,
            &leftCornerCoordY,
            GameWindow.leftTopX,
            GameWindow.leftTopY,
            GameWindow.rightBottomX,
            GameWindow.rightBottomY,
            this.leftCornerUrl
        )

        if (!isFoundLeftCorner) {
            MsgBox "Error: Not Found - LeftCorner"

            return
        }

        isFoundRightCorner := ImageSearch(
            &rightCornerCoordX,
            &rightCornerCoordY,
            GameWindow.leftTopX,
            GameWindow.leftTopY,
            GameWindow.rightBottomX,
            GameWindow.rightBottomY,
            this.rightCornerUrl
        )

        if (!isFoundLeftCorner) {
            MsgBox "Error: Not Found - RightCorner"

            return
        }

        this.Corners := [
            [
                leftCornerCoordX,
                leftCornerCoordY
            ],
            [
                rightCornerCoordX,
                rightCornerCoordY
            ]
        ]
        this.isCornersFound := 1
    }

    getFirstCellCoors() {
        if (!this.isCornersFound) {
            return
        }

        isFound := ImageSearch(
            &firstCellCoordX,
            &firstCellCoordY,
            this.Corners[1][1],
            this.Corners[1][2],
            this.Corners[2][1],
            this.Corners[2][2],
            this.firstCellUrl
        )

        this.FirstCell := [
            firstCellCoordX + 3,
            firstCellCoordY + 3
        ]
        this.isFirstCellFound := 1
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
}