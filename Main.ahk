#Requires AutoHotkey v2.0
#Include GameObjects\PlayerInterface.ahk
#Include GameObjects\Tooltip\CapacityTooltip.ahk
#Include GameObjects\CrucibleInterface.ahk

SetWorkingDir A_InitialWorkingDir

F7:: ExitApp

CoordMode "Pixel"
sleep 5500

PlayerInventoryInstance := PlayerInterface()

; ----- -----
; CrucibleInterfaceInstance := CrucibleInterface('crucible')

; CrucibleInterfaceInstance.checkInventoryUIOpen()
; CrucibleInterfaceInstance.getMetalQuantity()