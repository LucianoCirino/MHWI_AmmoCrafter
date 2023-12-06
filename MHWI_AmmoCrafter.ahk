/*
  🔫 Ammo Crafter 

    Author: Luciano Cirino (TSC)
    Date: December 2023
    Language: AutoHotkey v2.0 https://www.autohotkey.com/

  📡 Description:
         Auto-crafts an ammo in the F-Menu of your inventory.
         Conditions to auto craft are met when a predefined ammo type is below a defined limit.
         Conditions are checked while holding the firing button.
         Works with both PS4 Controller and Keyboard & Mouse.

*/

#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreads 1

;;==============================[Load Libraries]===============================
SetTitleMatchMode 2  ; Avoids the need to specify the full path of files.
#Include lib/Initialization.ahk
#Include lib/MemoryLibrary.ahk
#Include lib/Functions.ahk

;;==============================[Custom Settings]==============================
global EXIT_SCRIPT_HOTKEY := "F10"

; Your framerate
global FPS := 300

; Menu craft locations
global F_MENU := "F4"   ; Menu where craft items are located. ["F1","F2","F3","F4"]
global SLOT := "2"  ; Slot of craft item in F_menu . ["","1","2","3","4","5","6","7","8"]

; Crafting conditions
global AMMO_TO_CHECK := "Dragon Ammo"
global AMMO_LIMIT := 5

; Ammo Names (for reference)
; "Normal 1", "Normal 2", "Normal 3",
; "Pierce 1", "Pierce 2", "Pierce 3", 
; "Spread 1", "Spread 2", "Spread 3", 
; "Cluster 1", "Cluster 2", "Cluster 3", 
; "Sticky 1", "Sticky 2", "Sticky 3",
; "Slicing", "Flaming", "Water",
; "Freeze", "Thunder", "Dragon Ammo",
; "Poison 1", "Poison 2", "Paralysis 1",
; "Paralysis 2", "Sleep 1", "Sleep 2",
; "Exhaust 1", "Exhaust 2", "Recovery 1",
; "Recovery 2", "Demon", "Armor", "Tranq"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Hotkey EXIT_SCRIPT_HOTKEY, ExitScript
Hotkey "~Joy8", CraftCheck     ; PS4 controller R2, aka shoot button
Hotkey "~Lbutton", CraftCheck  ; KbM default shoot button 

CraftCheck(hotkeyName:=""){
   key := StrReplace(hotkeyName, "~", "")
   QPCsleep(100)
   While Pressed(key) && CheckWindow(){
      if ((GetAmmoCount2(GetAmmoID(AMMO_TO_CHECK)) <= AMMO_LIMIT) && IsNumber(SLOT))
         TimedPulse([F_MENU, SLOT],Ceil(1000/FPS), offDelay:=Ceil(1000/FPS))
   }
}

ExitScript(hotkeyName:=""){
   ExitApp
}