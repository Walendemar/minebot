#Requires AutoHotkey v2.0
#Include C:\Users\user\Documents\minebot\Constant\Screen.ahk
#Include C:\Users\user\Documents\minebot\Constant\InterfaceElements.ahk
#Include C:\Users\user\Documents\minebot\Utils\ObjToStr.ahk

class Tooltip {
    Borders := {
        leftTopCornerX: "",
        leftTopCornerY: "",
        rightBottomCornerX: "",
        rightBottomCornerY: "",
        isFoundLeftCorner: 0,
        isFoundRightCorner: 0
    },
    NumberUrls := Elements.Tooltip.Numbers

    __New() {
        Borders := this.findTooltipCorner(15)
    }

    findLeftTooltipCorner(gradation := 0) {
        isLeftCornerFound := ImageSearch(
            &leftCornerX,
            &leftCornerY,
            GameWindow.leftTopX,
            GameWindow.leftTopY,
            GameWindow.rightBottomX,
            GameWindow.rightBottomY,
            "*" . gradation . " " . Elements.Tooltip.LeftCorner.url
        )

        return {
            Coords: [leftCornerX, leftCornerY],
            isFound: isLeftCornerFound
        }
    }

    findRightTooltipCorner(LeftCorner, gradation) {
        isRightCornerFound := ImageSearch(
            &rightCornerX,
            &rightCornerY,
            LeftCorner[1] + 20,
            LeftCorner[2] + 20,
            GameWindow.rightBottomX,
            GameWindow.rightBottomY,
            "*" . gradation . " " . Elements.Tooltip.RightCorner.url
        )

        if (!isRightCornerFound) {
            MsgBox "Error: Not Found - RightCorner"
        }

        return {
            Coords: [rightCornerX, rightCornerY],
            isFound: isRightCornerFound
        }
    }

    findTooltipCorner(gradation := 0) {
        LeftCorner := this.findLeftTooltipCorner(gradation)
        RightCorner := {
            Coords: ["", ""],
            isFound: 0
        }

        if (LeftCorner.isFound) {
            RightCorner := this.findRightTooltipCorner(LeftCorner.Coords, gradation)
        } else {
            MsgBox "Error: Not Found - LeftCorner"
        }


        if (LeftCorner.isFound and RightCorner.isFound) {
            this.Borders.leftTopCornerX := LeftCorner.Coords[1],
            this.Borders.leftTopCornerY := LeftCorner.Coords[2],
            this.Borders.rightBottomCornerX := RightCorner.Coords[1],
            this.Borders.rightBottomCornerY := RightCorner.Coords[2],
            this.Borders.isFoundLeftCorner := LeftCorner.isFound,
            this.Borders.isFoundRightCorner := RightCorner.isFound
        }
    }

    getNumber(leftTopX, leftTopY, rightBottomX, rightBottomY) {
        Numbers := []

        Loop 10 {
            leftBorderX := leftTopX
            isFound := 1
            currentIteration := A_Index

            while isFound {
                isNumberFound := ImageSearch(
                    &numberCoordX,
                    &numberCoordY,
                    leftBorderX,
                    leftTopY,
                    rightBottomX,
                    rightBottomY,
                    "*15 " . this.NumberUrls[currentIteration]
                )

                if (isNumberFound) {
                    Numbers.Push({
                        coordX: numberCoordX,
                        coordY: numberCoordY,
                        id: currentIteration - 1
                    })

                    leftBorderX := numberCoordX + 18
                }

                if (!isNumberFound) {
                    isFound := 0
                }
            }
        }

        for numberKey, numberValue in Numbers {
            if (A_Index = 4) {
                break
            }

            currentChecked := A_Index + 1
            currentIndex := A_Index

            while (currentChecked < Numbers.Length + 1) {
                if (Numbers[currentIndex].coordX > Numbers[currentChecked].coordX) {
                    BufferValue := Numbers[currentChecked]
                    Numbers[currentChecked] := Numbers[currentIndex]
                    Numbers[currentIndex] := BufferValue
                }

                currentChecked := currentChecked + 1
            }
        }

        metalQuantity := ""

        for _key, value in Numbers {
            metalQuantity := metalQuantity . value.id
        }


        MsgBox Integer(metalQuantity)
        return Integer(metalQuantity)
    }
}
