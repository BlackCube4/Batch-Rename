sTooltip(sTooltipTxt,seconds=2,bg=0xFFFFE7,fg=0x0,x=-1,y=-1) {
   ; (w) derRaphael / zLib Style released / v 0.3

   if (Seconds<1) ; If the Seconds in the call is less than 1 it stays on forever.
	gosub, contRun
   StartTime := EndTime := A_Now
   EnvAdd,EndTime,Seconds,Seconds

contRun:
	fg := ((fg&255)<<16)+(((fg>>8)&255)<<8)+(fg>>16) ; rgb -> bgr
	bg := ((bg&255)<<16)+(((bg>>8)&255)<<8)+(bg>>16) ; rgb -> bgr
   
   tooltip,% (ttID:="TooltipColor " A_TickCount)
   tThWnd1:=WinExist(ttID ahk_class tooltips_class32)

; remove border
;WinSet,Style,-0x800000,ahk_id %tThWnd1%

   SendMessage, 0x413, bg,0,, ahk_id %tThWnd1%   ; 0x413 is TTM_SETTIPBKCOLOR
   SendMessage, 0x414, fg,0,, ahk_id %tThWnd1%   ; 0x414 is TTM_SETTIPTEXTCOLOR
   ; according to http://msdn.microsoft.com/en-us/library/bb760411(VS.85).aspx
   ; there is no limitation on vista for this.

   Loop,
   {
      if (EndTime=A_Now)
         Break
      else
         if (x<0) || (y<0)
            ToolTip, %sTooltipTxt%
         else
            ToolTip, %sTooltipTxt%, %x%, %y%
      sleep, 15
   }
   ToolTip
}

return