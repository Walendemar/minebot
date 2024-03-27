#Requires AutoHotkey v2.0

Elements := {
    PlayerInterface: {
        CreateWord: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Words\CreateWord.png"
        },
        LeftCorner: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\PlayerInterface\LeftCorner.png"
        },
        RightCorner: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\PlayerInterface\RightCorner.png"
        },
        FirstCell: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\PlayerInterface\FirstCell.png"
        },
        FirstPlayerInventoryStoreCell: {
            leftTopX: 1041,
            leftTopY: 713,
            rightBottomX: 1088,
            rightBottomY: 760
        },
        InventoryCell: {
            size: 48,
            cellGap: 6
        }
    },
    CrucibleInterface: {
        Sign: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Crucible\Sign.png"
        },
        Ruler: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Crucible\Ruler.png"
        },
        Output: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Crucible\Output.png"
        },
        LeftCorner: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Crucible\LeftCorner.png"
        },
        RightCorner: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Crucible\RightCorner.png"
        },
    },
    Tooltip: {
        LeftCorner: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\LeftCorner.png"
        },
        RightCorner: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\RightCorner.png"
        },
        Symbols: {
            Slash: {
                url: A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Symbol\Slash.png"
            }
        },
        IdPictures: {
            EmptyMold: {
                url: A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\ItemId\EmptyMold.png"
            }
        },
        Numbers: [
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\0.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\1.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\2.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\3.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\4.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\5.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\6.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\7.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\8.png",
            A_WorkingDir . "\Pictures\InterfaceElements\Tooltip\Numbers\9.png"
        ]
    }
}