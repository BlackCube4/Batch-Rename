#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include %A_ScriptDir%\Class_ImageButton.ahk
#Include %A_ScriptDir%\UseGDIP.ahk
#Include %A_ScriptDir%\sTooltip.ahk
#Include %A_ScriptDir%\GetPathOfSelectedFiles.ahk
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
#SingleInstance Force
#NoTrayIcon
CoordMode, ToolTip, Screen

#IfWinActive ahk_class CabinetWClass

;to activate press ctrl + shift + r

^+r::

vText := Explorer_GetSelected()
msgbox %vText%
if (vText="")
	return

Gui, Destroy

;Create a Gui with dark Title bar
Gui, New , HwndBatchRenamer, Batch Renamer
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", BatchRenamer, "int", "20", "int*", true, "int", 4)

;Set Margin Color and Font
GuiColor := "0x191919"
GuiElementsColor := "0x333333"
GuiElementsBorderColor := "0x454545"
GuiElementsRadius := 5
Gui, Margin, 15, 15
Gui, Font, s10 q4, Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]

Gui, Add, Button, w160 h35 hwndHBT1, replace x with y
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 wp hp hwndHBT1, remove String
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

Gui, Add, Button, x15 y+10 wp hp hwndHBT1, add String at the Start
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 wp hp hwndHBT1, add String at the End
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

Gui, Add, Button, x15 y+10 wp h50 hwndHBT1, remove x chars`nfrom the Start
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 wp hp hwndHBT1, remove x chars`nfrom the End
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

Gui, Show
return  ; End of auto-execute section. The script is idle until the user does something.





ButtonaddStringattheStart:
Gui, Destroy
beginningString := ""

;Create a Gui with dark Title bar
Gui, New, HwndAddStart, add String at the Start
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", AddStart, "int", "20", "int*", true, "int", 4)

;Set Margin Color and Font
GuiColor := "0x191919"
GuiElementsColor := "0x333333"
GuiElementsBorderColor := "0x454545"
GuiElementsRadius := 5
Gui, Margin, 15, 15
Gui, Font, s10 q4 cWhite, Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]

Gui, Add, Text, w230 h40 +Center, Enter the String you want to put in front of the Filename.

Gui, Add, Button, y+10 w230 h30 hwndHBT1 vBackground1,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, vbeginningString x+-225 y+-24 w220 h18 -E0x200, ;-E0x200 -> no border

Gui, Add, Button, gConfirmStartString x15 y+16 w110 h30 hwndHBT1, Confirm
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 w110 h30 hwndHBT1, Cancel
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

;Disable Background Buttons
loop 1
	GuiControl, Disable, % "Background" . A_Index

Gui, Show
Return

ConfirmStartString:
Gui, Submit
if StrLen(beginningString) < 1
	return

Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^.*\\(.*)(\..*)", SubPart)
	Filename := SubPart1
	Extension := SubPart2
	
	NewFilename := beginningString . Filename . Extension
	Run, %ComSpec% /c ren "%String%" "%NewFilename%", ,Hide
}
sTooltip( "finished renaming", 2, "0xFFFFFF", "0x000000")
return





ButtonaddStringattheEnd:
Gui, Destroy
endingString := ""

;Create a Gui with dark Title bar
Gui, New, HwndAddEnd, add String at the End
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", AddEnd, "int", "20", "int*", true, "int", 4)

;Set Margin Color and Font
GuiColor := "0x191919"
GuiElementsColor := "0x333333"
GuiElementsBorderColor := "0x454545"
GuiElementsRadius := 5
Gui, Margin, 15, 15
Gui, Font, s10 q4 cWhite, Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]

Gui, Add, Text, w230 h40 +Center, Enter the String you want to put at the end of the Filename.

Gui, Add, Button, y+10 w230 h30 hwndHBT1 vBackground1,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, vendingString x+-225 y+-24 w220 h18 -E0x200, ;-E0x200 -> no border

Gui, Add, Button, gConfirmEndString x15 y+16 w110 h30 hwndHBT1, Confirm
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 w110 h30 hwndHBT1, Cancel
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

;Disable Background Buttons
loop 1
	GuiControl, Disable, % "Background" . A_Index

Gui, Show
Return

ConfirmEndString:
Gui, Submit
if StrLen(endingString) < 1
	return

Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^.*\\(.*)(\..*)", SubPart)
	Filename := SubPart1
	Extension := SubPart2
	
	NewFilename := Filename . endingString . Extension
	Run, %ComSpec% /c ren "%String%" "%NewFilename%", ,Hide
}
sTooltip( "finished renaming", 2, "0xFFFFFF", "0x000000")
return





ButtonremovexcharsfromtheStart:
Gui, Destroy

;Create a Gui with dark Title bar
Gui, New, HwndRemoveStart, remove from Start
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", RemoveStart, "int", "20", "int*", true, "int", 4)

;Set Margin Color and Font
GuiColor := "0x191919"
GuiElementsColor := "0x333333"
GuiElementsBorderColor := "0x454545"
GuiElementsRadius := 5
Gui, Margin, 15, 15
Gui, Font, s10 q4 cWhite, Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]

Gui, Add, Text, w230 h40 +Center, Enter the Number of Chars to remove from the Start of the Filename.

Gui, Add, Button, x15 y+10 w230 h26 hwndHBT1 vBackground1,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, x+-225 y+-23 w220 h18 Center -E0x200 cWhite
Gui, Add, UpDown, Hidden vnumberOfChars Range1-200, 3
Gui, Add, Picture, x+-14 y+-21 gUpRound, UpRound.png
Gui, Add, Picture, y+-0 gDownRound, DownRound.png

Gui, Add, Button, gConfirmStartRemove x15 y+10 w110 h30 hwndHBT1, Confirm
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 w110 h30 hwndHBT1, Cancel
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

;Disable Background Buttons
loop 1
	GuiControl, Disable, % "Background" . A_Index

Gui, Show
Return

ConfirmStartRemove:
Gui, Submit
if numberOfChars < 1
	return

Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^.*\\(.*)(\..*)", SubPart)
	Filename := SubPart1
	Extension := SubPart2

	Filename := SubStr(Filename, numberOfChars+1)
	NewFilename := Filename . Extension
	Run, %ComSpec% /c ren "%String%" "%NewFilename%", ,Hide
}
sTooltip( "finished renaming", 2, "0xFFFFFF", "0x000000")
return

UpRound:
Gui, Submit, NoHide
GuiControl, , numberOfChars, % numberOfChars + 1
return

DownRound:
Gui, Submit, NoHide
GuiControl, , numberOfChars, % numberOfChars - 1
return






ButtonremovexcharsfromtheEnd:
Gui, Destroy

;Create a Gui with dark Title bar
Gui, New, HwndRemoveEnd, remove from End
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", RemoveEnd, "int", "20", "int*", true, "int", 4)

;Set Margin Color and Font
GuiColor := "0x191919"
GuiElementsColor := "0x333333"
GuiElementsBorderColor := "0x454545"
GuiElementsRadius := 5
Gui, Margin, 15, 15
Gui, Font, s10 q4 cWhite, Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]

Gui, Add, Text, w230 h40 +Center, Enter the Number of Chars to remove from the End of the Filename.

Gui, Add, Button, x15 y+10 w230 h26 hwndHBT1 vBackground1,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, x+-225 y+-23 w220 h18 Center -E0x200 cWhite
Gui, Add, UpDown, Hidden vnumberOfChars Range1-200, 3
Gui, Add, Picture, x+-14 y+-21 gUpRound, UpRound.png
Gui, Add, Picture, y+-0 gDownRound, DownRound.png

Gui, Add, Button, gConfirmEndRemove x15 y+10 w110 h30 hwndHBT1, Confirm
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 w110 h30 hwndHBT1, Cancel
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

;Disable Background Buttons
loop 1
	GuiControl, Disable, % "Background" . A_Index

Gui, Show
Return

ConfirmEndRemove:
Gui, Submit
if numberOfChars < 1
	return

Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^.*\\(.*)(\..*)", SubPart)
	Filename := SubPart1
	Extension := SubPart2

	Filename := SubStr(Filename, 1, -numberOfChars)
	NewFilename := Filename . Extension
	Run, %ComSpec% /c ren "%String%" "%NewFilename%", ,Hide
}
sTooltip( "finished renaming", 2, "0xFFFFFF", "0x000000")
return





Buttonreplacexwithy:
Gui, Destroy

;Create a Gui with dark Title bar
Gui, New, HwndReplace, replace x with y
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", Replace, "int", "20", "int*", true, "int", 4)

;Set Margin Color and Font
GuiColor := "0x191919"
GuiElementsColor := "0x333333"
GuiElementsBorderColor := "0x454545"
GuiElementsRadius := 5
Gui, Margin, 15, 15
Gui, Font, s10 q4 cWhite, Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]

Gui, Add, Text, w230 h20 +Center, Enter the String you want to replace.

Gui, Add, Button, y+10 w230 h30 hwndHBT1 vBackground1,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, vStringToReplace x+-225 y+-24 w220 h18 -E0x200, x ;-E0x200 -> no border

Gui, Add, Button,  x15 y+16 w230 h30 hwndHBT1 vBackground2,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, vReplaceString x+-225 y+-24 w220 h18 -E0x200, y ;-E0x200 -> no border

Gui, Add, Button, gConfirmReplace x15 y+16 w110 h30 hwndHBT1, Confirm
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 w110 h30 hwndHBT1, Cancel
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)

;Disable Background Buttons
loop 2
	GuiControl, Disable, % "Background" . A_Index

Gui, Show
Return

ConfirmReplace:
Gui, Submit
if StrLen(StringToReplace) < 1
	return

Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^.*\\(.*)(\..*)", SubPart)
	Extension := SubPart2
	Filename := RegexReplace(SubPart1, StringToReplace, ReplaceString)
	NewFilename := Filename . Extension
	Run, %ComSpec% /c ren "%String%" "%NewFilename%", ,Hide
}
sTooltip( "finished renaming", 2, "0xFFFFFF", "0x000000")
return










ButtonremoveString:
Gui, Destroy

;Create a Gui with dark Title bar
Gui, New, HwndRemoveString, remove String
DllCall("dwmapi\DwmSetWindowAttribute", "ptr", RemoveString, "int", "20", "int*", true, "int", 4)

;Set Margin Color and Font
GuiColor := "0x191919"
GuiElementsColor := "0x333333"
GuiElementsBorderColor := "0x454545"
GuiElementsRadius := 5
Gui, Margin, 15, 15
Gui, Font, s10 q4 cWhite, Segoe UI
Gui, Color, %GuiColor%, %GuiElementsColor%
ImageButton.SetGuiColor(GuiColor)

;Options for Buttons
Opt1 := [0, GuiElementsColor, , "White", GuiElementsRadius, , GuiElementsBorderColor, 1]
Opt2 := [0, 0x414141]

Gui, Add, Text, w230 h20 +Center, Enter the String you want to remove.

Gui, Add, Button, y+10 w230 h30 hwndHBT1 vBackground1,
ImageButton.Create(HBT1, Opt1, Opt1, , , Opt1)
Gui, Add, Edit, -WantReturn vStringToRemove x+-225 y+-24 w220 h18 -E0x200, ;-E0x200 -> no border

Gui, Add, Button, gConfirmRemove x15 y+16 w110 h30 hwndHBT1, Confirm
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
Gui, Add, Button, x+10 w110 h30 hwndHBT1, Cancel
ImageButton.Create(HBT1, Opt1, Opt2, , , Opt1)
GuiControl, +Default, Confirm

;Disable Background Buttons
loop 1
	GuiControl, Disable, % "Background" . A_Index

Gui, Show
Return

ConfirmRemove:
Gui, Submit
if StrLen(StringToRemove) < 1
	return

Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^.*\\(.*)(\..*)", SubPart)
	Extension := SubPart2
	Filename := RegexReplace(SubPart1, StringToRemove)
	NewFilename := Filename . Extension
	Run, %ComSpec% /c ren "%String%" "%NewFilename%", ,Hide
}
sTooltip( "finished renaming", 2, "0xFFFFFF", "0x000000")
return








ButtonCancel:
Gui, Destroy
return
