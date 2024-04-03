#Requires AutoHotkey v2.0

class InterfaceShell {
    Corners := [
        [],
        []
    ]
    isCornersFound := 0
    interfaceType := ""

    ; picture url
    leftCornerUrl := Elements.Interface.LeftCorner.url
    rightCornerUrl := Elements.Interface.RightCorner.url
    Signs := Elements.Signs

    __New() {
        this.getCorner()
        this.getInterfaceType()
        Sleep(25)
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

    checkUIOpen() {
        if (!this.interfaceType) {
            this.getInterfaceType()
        }

        isOpen := ImageSearch(
            &xCoord,
            &yCoord,
            GameWindow.leftTopX,
            GameWindow.leftTopY,
            GameWindow.rightBottomX,
            GameWindow.rightBottomY,
            this.Signs.%this.interfaceType%.url
        )
    
        return isOpen
    }

    getInterfaceType() {
        for key, value in this.Signs.OwnProps() {
            isFound := ImageSearch(
                &xCoord,
                &yCoord,
                GameWindow.leftTopX,
                GameWindow.leftTopY,
                GameWindow.rightBottomX,
                GameWindow.rightBottomY,
                value.url
            )

            if (isFound) {
                this.interfaceType := key

                return
            }
        }
    }
}