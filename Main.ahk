#Requires AutoHotkey v2.0
#Include GameObjects\PlayerInterface.ahk
#Include GameObjects\Tooltip\CapacityTooltip.ahk
#Include GameObjects\CrucibleInterface.ahk
#Include Actions\Interface.ahk
#Include Utils\Helpers.ahk

SetWorkingDir A_InitialWorkingDir

F7:: ExitApp
CoordMode "Pixel"

getScreenSize()
sleep 5500

openInterface()
PlayerInventoryInstance := PlayerInterface()

; ----- -----
; CrucibleInterfaceInstance := CrucibleInterface('crucible')

; CrucibleInterfaceInstance.checkInventoryUIOpen()
; CrucibleInterfaceInstance.getMetalQuantity()