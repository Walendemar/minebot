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

        isOpen := 0

        if (this.Signs.%this.interfaceType%.HasOwnProp("url")) {
            isOpen := ImageSearch(
                &xCoord,
                &yCoord,
                GameWindow.leftTopX,
                GameWindow.leftTopY,
                GameWindow.rightBottomX,
                GameWindow.rightBottomY,
                this.Signs.%this.interfaceType%.url
            )
        }

        
        if (this.Signs.%this.interfaceType%.HasOwnProp("firstUrl") and this.Signs.%this.interfaceType%.HasOwnProp("secondUrl")) {
            isFirstOpen := ImageSearch(
                &xCoord,
                &yCoord,
                GameWindow.leftTopX,
                GameWindow.leftTopY,
                GameWindow.rightBottomX,
                GameWindow.rightBottomY,
                this.Signs.%this.interfaceType%.firstUrl
            )

            isSecondOpen := ImageSearch(
                &xCoord,
                &yCoord,
                GameWindow.leftTopX,
                GameWindow.leftTopY,
                GameWindow.rightBottomX,
                GameWindow.rightBottomY,
                this.Signs.%this.interfaceType%.secondUrl
            )

            isOpen := isFirstOpen and isSecondOpen
        }
    
        return isOpen
    }

    getInterfaceType() {
        for key, value in this.Signs.OwnProps() {
            if (value.HasOwnProp("url")) {
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

            if (value.HasOwnProp("firstUrl") and value.HasOwnProp("secondUrl")) {
                isFoundFirst := ImageSearch(
                    &xCoord,
                    &yCoord,
                    GameWindow.leftTopX,
                    GameWindow.leftTopY,
                    GameWindow.rightBottomX,
                    GameWindow.rightBottomY,
                    value.firstUrl
                )

                isFoundSecond := ImageSearch(
                    &xCoord,
                    &yCoord,
                    GameWindow.leftTopX,
                    GameWindow.leftTopY,
                    GameWindow.rightBottomX,
                    GameWindow.rightBottomY,
                    value.secondUrl
                )


                if (isFoundFirst and isFoundSecond) {
                    this.interfaceType := key
    
                    return
                } 
            }
        }

         MsgBox "Error: Not Found - interfaceType"
    }
}