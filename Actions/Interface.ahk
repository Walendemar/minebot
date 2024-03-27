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