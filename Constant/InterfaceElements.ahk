#Requires AutoHotkey v2.0

Elements := {
    Interface: {
        LeftCorner: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\PlayerInterface\LeftCorner.png"
        },
        RightCorner: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\PlayerInterface\RightCorner.png"
        },
    },
    PlayerInterface: {
        FirstCell: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\PlayerInterface\FirstCell.png"
        },
        InventoryCell: {
            size: 48,
            cellGap: 6
        }
    },
    CrucibleInterface: {
        Ruler: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Crucible\Ruler.png"
        },
        Output: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Crucible\Output.png"
        }
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
    },
    Signs: {
        Crucible: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Crucible\Sign.png"
        },
        PlayerInterface: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\PlayerInterface\Sign.png"
        },
        Anvil: {
            url: A_WorkingDir . "\Pictures\InterfaceElements\Anvil\Sign.png"
        }
    }
}