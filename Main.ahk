#Requires AutoHotkey v2.0
#Include C:\Users\user\Documents\minebot\GameObjects\PlayerInterface.ahk
#Include C:\Users\user\Documents\minebot\GameObjects\Tooltip\CapacityTooltip.ahk
#Include C:\Users\user\Documents\minebot\GameObjects\CrucibleInterface.ahk

F7:: ExitApp

CoordMode "Pixel"
sleep 5500

; PlayerInventoryInstance := PlayerInterface()

; CapacityTooltipInstance := CapacityTooltip()

CrucibleInterfaceInstance := CrucibleInterface('crucible')

CrucibleInterfaceInstance.checkInventoryUIOpen()
CrucibleInterfaceInstance.getMetalQuantity()