#Requires AutoHotkey v2.0
#Include ..\Actions\Interface.ahk
#Include InterfaceShell.ahk

class PlayerInventory extends InterfaceShell {
    Inventory := {
        Package : [],
        Hotbar: [],
    }
    isFirstCellFound := 0
    FirstCell := []

    ; picture urls
    cellSize := Elements.PlayerInterface.InventoryCell.size
    firstCellUrl := Elements.PlayerInterface.FirstCell.url

    __New() {
        super.__New()

        this.getFirstCellCoors()
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

    scanStore(FirstCell) {
        Loop 3 {
            PackageLine := []
            iteration := A_Index

            Loop 9 {
                leftTopCoordX := FirstCell[1] + (this.cellSize + 6) * (A_Index - 1)
                leftTopCoordY := FirstCell[2] + (this.cellSize + 6) * (iteration - 1)
                rightBottomCoordX := leftTopCoordX + this.cellSize
                rightBottomCoordY := leftTopCoordY + this.cellSize

                Item := this.checkInventoryCellItem([leftTopCoordX, leftTopCoordY], [rightBottomCoordX, rightBottomCoordY])
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

    checkInventoryCellItem(leftTopCoords, rightBottomCoords, gradation := 0) {
        findedItemId := ""
        emptyInventoryCellUrl := Items.EmptyInventoryCell.url

        isEmptyCell := ImageSearch(
            &xCoord,
            &yCoord,
            leftTopCoords[1],
            leftTopCoords[2],
            rightBottomCoords[1],
            rightBottomCoords[2],
            emptyInventoryCellUrl
        )

        if isEmptyCell {
            return { name: "EmptyInventoryCell" }
        }

        for itemName, ItemValue in Items.OwnProps() {
            if ItemValue.url = "" {
                ; Обработать ошибку
                return { name: "FindError" }
            }

            isFound := ImageSearch(
                &foundX,
                &foundY,
                leftTopCoords[1],
                leftTopCoords[2],
                rightBottomCoords[1],
                rightBottomCoords[2],
                "*" . gradation . " " . ItemValue.url
            )

            if (isFound) {
                return { name: itemName, id: ItemValue.id }
            }
        }

        return { name: "FindError" }
    }
}