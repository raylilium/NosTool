InArray(haystack, needle) {
	if !(IsObject(haystack)) || (haystack.Length() = 0)
		return 0
	for index, value in haystack
		if (value = needle)
			return index
	return 0
}

;String2Bool(v) { ; anything but 'true' returns false
;	return v = "true"
;}
ONOFF2Bool(v) { ; anything but 'true' returns false
	return v = "ON"
}
;Bool2ONOFF(v) { ; anything but 'true' returns false
;	return v == true? "ON" : "OFF"
;}

GoBackWorkingWindow(){
	global CurrentCheckingActiveWindowID
	global IsUnfocus
	
	if(IsUnfocus){
		;WinActivate, ahk_id %CurrentCheckingActiveWindowID%
	}
}

ActivateWindowByTitle(id, title){
	WinActivate, %title%
	global CurrentActiveWindowID := id
	global CurrentActiveTitle := title
}

NumberNear(number, target, near){
	if((number-near)<target and (number+near)>target){
		return true
	}
	return false
}

PrintDebug(string:=""){
	Static
	string := string ? string . "`r`n" . lastStr : "", lastStr := string
	If !WinActive("ahk_class AutoHotkey"){
		ListVars
		WinWait ahk_id %A_ScriptHwnd%
		WinGetTitle, title, ahk_id %A_ScriptHwnd%
	}Else If !string{
		PostMessage, 0x112, 0xF060,,, %title% ; 0x112 = WM_SYSCOMMAND, 0xF060 = SC_CLOSE
		Return
	}
	ControlSetText Edit1, %string%, ahk_id %A_ScriptHwnd%
}

Speak(text){
	spovice:=ComObjCreate("sapi.spvoice")
	spovice.Speak(text)
}

update_trading_result(){
	global bid_price, ask_price, bid_quantity, ask_quantity
	
	if(bid_quantity <= 0){
		bid_price -= 10000
		ask_price -= 10000
		bid_quantity = 5
	}
	
	if(ask_quantity <= 0){
		bid_price += 10000
		ask_price += 10000
		ask_quantity = 5
	}
	
	guiControl,, bid_price , %bid_price%
	guiControl,, ask_price , %ask_price%
	guiControl,, bid_quantity , %bid_quantity%
	guiControl,, ask_quantity , %ask_quantity%
	
	calculate_bid_ask_x5()
}

calculate_bid_ask_x5(){
	global bid_price, ask_price
	
	GuiControl,,  bid_price_x1 , % bid_price * 1
	GuiControl,,  bid_price_x2 , % bid_price * 2
	GuiControl,,  bid_price_x3 , % bid_price * 3
	GuiControl,,  bid_price_x4 , % bid_price * 4
	GuiControl,,  bid_price_x5 , % bid_price * 5
	
	GuiControl,,  ask_price_x1 , % ask_price * 1
	GuiControl,,  ask_price_x2 , % ask_price * 2
	GuiControl,,  ask_price_x3 , % ask_price * 3
	GuiControl,,  ask_price_x4 , % ask_price * 4
	GuiControl,,  ask_price_x5 , % ask_price * 5
}

copy_price_to_board(){
	Sleep 1000
	MouseClick, Left, 300, 400
	Sleep 1000
	Send ^v
	Sleep 1000
	MouseClick, Left, 300, 565
}

/*

ConfigFile := FileOpen(ConfigFileName, "r-d")
if !IsObject(ConfigFile)
{
    MsgBox Can't open "%ConfigFileName%" for reading.
    return
}
Loop
{
    FileReadLine, line, %ConfigFileName%, %A_Index%
    if ErrorLevel
        break
    MsgBox, 4, , Line #%A_Index% is "%line%".  Continue?
}
*/