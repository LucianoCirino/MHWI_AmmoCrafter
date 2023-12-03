/*
  🔫 Ammo Crafter 

    Author: Luciano Cirino (TSC)
    Date: December 2023
    Language: AutoHotkey v2.0 https://www.autohotkey.com/

  📡 Description:
         Auto crafts up to 3 different ammos in a select F-Menu in your inventory.
         Conditions to auto craft are met when a predefined ammo type is below a defined limit.
         Conditions are checked after you press/click the firing button or at a specified frequency while holding the firing button.
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
EXIT_SCRIPT_HOTKEY := "F10"

; Menu craft locations
global F_MENU := "F4"   ; Menu where craft items are located. ["-","F1","F2","F3","F4"]
global SLOT_1 := "4"    ; Slot of craft item in F_menu . ["","1","2","3","4","5","6","7","8"]
global SLOT_2 := "5"    ; Slot of craft item in F_menu . ["","1","2","3","4","5","6","7","8"]
global SLOT_3 := "6"    ; Slot of craft item in F_menu . ["","1","2","3","4","5","6","7","8"]

; Condition check frequency (only applicable while holding fire)
global CHECK_FREQUENCY := 1500 ;ms

; Crafting conditions
global AMMO_TO_CHECK := "Spread 3"
global AMMO_LIMIT := 10

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

AmmoCraft(){
   SendKey(F_MENU)

   QPCsleep(201)

   if IsNumber(SLOT_1)
      TimedPulse(SLOT_1,17)
   if IsNumber(SLOT_2)
      TimedPulse(SLOT_2,17)
   if IsNumber(SLOT_3)
      TimedPulse(SLOT_3,17)

   SendKey(F_MENU, "Up")

   QPCsleep(17)
}

CraftCheck(hotkeyName:=""){
   key := StrReplace(hotkeyName, "~", "")
   While Pressed(key) && CheckWindow(){
      if GetAmmoCount2(GetAmmoID(AMMO_TO_CHECK)) < AMMO_LIMIT
         AmmoCraft()
      PreciseSleep(CHECK_FREQUENCY)
   }
}

ExitScript(hotkeyName:=""){
   ExitApp
}