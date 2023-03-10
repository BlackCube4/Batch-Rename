#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2

#NoTrayIcon

#IfWinActive ahk_class CabinetWClass

;to activate press ctrl + r

^r::

Gui, Destroy

Gui, Add, Button, x20 y20 w330 h35 , replace x with y

Gui, Add, Button, x20 y+10 w160 hp , add String at the Start
Gui, Add, Button, x+10 wp hp , add String at the End

Gui, Add, Button, x20 y+10 wp hp , remove x chars from the Start
Gui, Add, Button, x+10 wp hp , remove x chars from the End

Gui, Show, h165 w370, Choose Operation
return  ; End of auto-execute section. The script is idle until the user does something.





ButtonaddStringattheStart:
Gui, Destroy
beginningString := ""

Gui, Add, Text, x35 y19 w270 h20 +Center, Enter the String you want to put in front of the Filename.
Gui, Add, Edit, vbeginningString x55 y44 w230 h20
Gui, Add, Button, gConfirmStartString x60 y79 w110 h30 , Confirm
Gui, Add, Button, x180 y79 w100 h30 , Cancel
Gui, Show, h127 w345, add String at the Start
Return

ConfirmStartString:
Gui, Submit
if StrLen(beginningString) < 1
	return

Clipboard := ""
Send ^c
ClipWait ;waits for the clipboard to have content
vText := Clipboard
Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^(.*\\)(.*).*([.][^.]{3})", SubPart)
	Path := SubPart1
	Filename := SubPart2
	Extension := SubPart3
	
	NewPathFilename := Path . beginningString . Filename . Extension
	FileMove, % String, % NewPathFilename
}
return





ButtonaddStringattheEnd:
Gui, Destroy
endingString := ""

Gui, Add, Text, x35 y19 w270 h20 +Center, Enter the String you want to put at the end of the Filename.
Gui, Add, Edit, vendingString x55 y44 w230 h20
Gui, Add, Button, gConfirmEndString x60 y79 w110 h30 , Confirm
Gui, Add, Button, x180 y79 w100 h30 , Cancel
GuiControl, +Default, Confirm
Gui, Show, h127 w345, add String at the End
Return

ConfirmEndString:
Gui, Submit
if StrLen(endingString) < 1
	return

Clipboard := ""
Send ^c
ClipWait ;waits for the clipboard to have content
vText := Clipboard
Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^(.*\\)(.*).*([.][^.]{3})", SubPart)
	Path := SubPart1
	Filename := SubPart2
	Extension := SubPart3
	
	NewPathFilename := Path . Filename . endingString . Extension
	FileMove, % String, % NewPathFilename
}
return





ButtonremovexcharsfromtheStart:
Gui, Destroy

Gui, Add, Text, x25 y19 w250 h30 +Center, Enter the Number of Chars you want to remove from the Start of the Filename.
Gui, Add, Edit, x110 y60 w80 h20 +Center
Gui, Add, UpDown, vnumberOfChars Range1-200, 3
Gui, Add, Button, gConfirmStartRemove x35 y90 w110 h30 , Confirm
Gui, Add, Button, x155 y90 w110 h30 , Cancel
GuiControl, +Default, Confirm
Gui, Show, h140 w300, remove from Start
Return

ConfirmStartRemove:
Gui, Submit
if numberOfChars < 1
	return

Clipboard := ""
Send ^c
ClipWait ;waits for the clipboard to have content
vText := Clipboard
Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^(.*\\)(.*).*([.][^.]{3})", SubPart)
	Path := SubPart1
	Filename := SubPart2
	Extension := SubPart3
	
	StringTrimLeft, Filename, Filename, numberOfChars
	NewPathFilename := Path . Filename . Extension
	FileMove, % String, % NewPathFilename
}
return





ButtonremovexcharsfromtheEnd:
Gui, Destroy

Gui, Add, Text, x25 y19 w250 h30 +Center, Enter the Number of Chars you want to remove from the End of the Filename.
Gui, Add, Edit, x110 y60 w80 h20 +Center
Gui, Add, UpDown, vnumberOfChars Range1-200, 3
Gui, Add, Button, gConfirmEndRemove x35 y90 w110 h30 , Confirm
Gui, Add, Button, x155 y90 w110 h30 , Cancel
GuiControl, +Default, Confirm
Gui, Show, h140 w300, remove from End
Return

ConfirmEndRemove:
Gui, Submit
if numberOfChars < 1
	return

Clipboard := ""
Send ^c
ClipWait ;waits for the clipboard to have content
vText := Clipboard
Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^(.*\\)(.*).*([.][^.]{3})", SubPart)
	Path := SubPart1
	Filename := SubPart2
	Extension := SubPart3
	
	StringTrimRight, Filename, Filename, numberOfChars
	NewPathFilename := Path . Filename . Extension
	FileMove, % String, % NewPathFilename
}
return





Buttonreplacexwithy:
Gui, Destroy

Gui, Add, Text, x20 y19 w260 h30 +Center, Enter the String you want to replace.
Gui, Add, Edit, vStringToReplace x20 y60 w260 h20, x
Gui, Add, Edit, vReplaceString x20 y+10 w260 h20, y
Gui, Add, Button, gConfirmReplace x35 y140 w110 h30 , Confirm
Gui, Add, Button, x+10 y140 w110 h30, Cancel
GuiControl, +Default, Confirm
Gui, Show, h190 w300, replace x with y
Return

ConfirmReplace:
Gui, Submit
if StrLen(StringToReplace) < 1
	return

Clipboard := ""
Send ^c
ClipWait ;waits for the clipboard to have content
vText := Clipboard
Loop, Parse, vText, `n, `r
{
	String := A_LoopField
	RegexMatch(String, "^(.*\\)(.*).*([.][^.]{3})", SubPart)
	Path := SubPart1
	Filename := SubPart2
	Extension := SubPart3

	Filename := RegexReplace(SubPart2, StringToReplace, ReplaceString)
	
	NewPathFilename := Path . Filename . Extension
	FileMove, % String, % NewPathFilename
}
return





ButtonCancel:
Gui, Destroy
return