#Include NosToolLib.ahk


;VM setting
VMSettings := []
index = 0;
;VM1
index++
VMSettings[index] := {}
VMSettings[index].enable := true					;開關此VM, value: true/false
VMSettings[index].title := "win 8.1 1 [Running] - Oracle VM VirtualBox" ;VM name
VMSettings[index].needExpSkill := false				;開關經驗值技
VMSettings[index].needCuttingSkill := true			;開關防斷線技
VMSettings[index].needBaitSkill := true				;開關魚餌技
VMSettings[index].needBigFishingSkill := true		;開關大師級釣技
VMSettings[index].expSkillButton := 1				;經驗值技按鈕
VMSettings[index].cuttingSkillButton := 3			;防斷線技按鈕
VMSettings[index].baitSkillButton := 2				;魚餌技按鈕
VMSettings[index].bigFishingSkillButton := "t"		;大師級釣技按鈕
VMSettings[index].fishingSkillButton := "w"			;岸釣技按鈕
VMSettings[index].hookSkillButton := "e"			;收杆按鈕
;VM2
index++
VMSettings[index] := {}
VMSettings[index].enable := true
VMSettings[index].title := "win 8.1 2 [Running] - Oracle VM VirtualBox"
VMSettings[index].needExpSkill := false
VMSettings[index].needCuttingSkill := true
VMSettings[index].needBaitSkill := true
VMSettings[index].needBigFishingSkill := true
VMSettings[index].expSkillButton := 3
VMSettings[index].cuttingSkillButton := 2
VMSettings[index].baitSkillButton := 0
VMSettings[index].bigFishingSkillButton := "t"
VMSettings[index].fishingSkillButton := "w"
VMSettings[index].hookSkillButton := 1
;VM
index++
VMSettings[index] := {}
VMSettings[index].enable := true
VMSettings[index].title := "win 8.1 3 [Running] - Oracle VM VirtualBox"
VMSettings[index].needExpSkill := false
VMSettings[index].needCuttingSkill := true
VMSettings[index].needBaitSkill := true
VMSettings[index].needBigFishingSkill := true
VMSettings[index].expSkillButton := 1
VMSettings[index].cuttingSkillButton := 3
VMSettings[index].baitSkillButton := 2
VMSettings[index].bigFishingSkillButton := "t"
VMSettings[index].fishingSkillButton := "w"
VMSettings[index].hookSkillButton := "e"
;VM4
index++
VMSettings[index] := {}
VMSettings[index].enable := false
VMSettings[index].title := "win 8.1 4 [Running] - Oracle VM VirtualBox"
VMSettings[index].needExpSkill := false
VMSettings[index].needCuttingSkill := false
VMSettings[index].needBaitSkill := false
VMSettings[index].needBigFishingSkill := false
VMSettings[index].expSkillButton := 1
VMSettings[index].cuttingSkillButton := 3
VMSettings[index].baitSkillButton := 2
VMSettings[index].bigFishingSkillButton := "t"
VMSettings[index].fishingSkillButton := "w"
VMSettings[index].hookSkillButton := 2
VMSettings[index].checkingArea := "light"

AlertAudioPath := "C:\Users\Ray\Desktop\cat-purring-and-meow-5928.mp3"
;ConfigFileName = %A_WorkingDir%\\NosToolConfig.txt
ConfigFileName = %A_ScriptDir%\\NosToolConfig.txt

debug := false
leave := false

;cool down time for skill; all plus 5 second buffer
ExpSkillCooldownTime := 205000
CuttingSkillCooldownTime := 125000
BaitSkillCooldownTime := 125000
AntiPluginCooldownTime := 60 * 60 * 1000
AntiPluginCooldownTime := 3 * 60 * 1000

;try to take action after the time, idea for lag and action animation
WaitingWaitingTime := 5000
ExpSkillWaitingTime := 2000
CuttingSkillWaitingTime := 3000
BaitSkillWaitingTime := 3000
FishingSkillWaitingTime := 5000

;point to detect fish
pointerX := 561
pointerY := 477

;checking anti-plugin color
AntiPluginRChecking := 32
AntiPluginGChecking := 37
AntiPluginBChecking := 43

;point to detect anti-plugin
PointerDesctingAntiPluginX := 897
PointerDesctingAntiPluginY := 640

;point to click anti-plugin confirm
PointerAntiPluginConfirmX := 938
PointerAntiPluginConfirmY := 676

;VM full width and height, from window spy
FullVMWidth := 1040
FullVMHeight := 849

;mainly scollbar width and height
SizedVMWidthAdjustment := 17
SizedVMHeightAdjustment := 17

;ConfigVarBool := ["debug","leave"]
ConfigVarString := ["vm1_onoff","vm1_name","vm1_onoff_needExpSkill","vm1_onoff_needCuttingSkill","vm1_onoff_needBaitSkill","vm1_onoff_needBigFishingSkill","vm1_expSkillButton","vm1_cuttingSkillButton","vm1_baitSkillButton","vm1_bigFishingSkillButton","vm1_fishingSkillButton","vm1_hookSkillButton","vm2_onoff","vm2_name","vm2_onoff_needExpSkill","vm2_onoff_needCuttingSkill","vm2_onoff_needBaitSkill","vm2_onoff_needBigFishingSkill","vm2_expSkillButton","vm2_cuttingSkillButton","vm2_baitSkillButton","vm2_bigFishingSkillButton","vm2_fishingSkillButton","vm2_hookSkillButton","vm3_onoff","vm3_name","vm3_onoff_needExpSkill","vm3_onoff_needCuttingSkill","vm3_onoff_needBaitSkill","vm3_onoff_needBigFishingSkill","vm3_expSkillButton","vm3_cuttingSkillButton","vm3_baitSkillButton","vm3_bigFishingSkillButton","vm3_fishingSkillButton","vm3_hookSkillButton","vm_atuo_trading_name","bid_price","ask_price","bid_quantity","ask_quantity"]
ConfigVarString.Push("debug")
ConfigVarString.Push("leave")
ConfigVarInt := [""]

FishingArray := [] ;store all window status
CurrentActiveWindowID := "" ; store current window ID
CurrentActiveTitle := "" ; store current window title

;;;;;;;;;;auto trading boomb protector
vm_atuo_trading_name := "win 8.1 1 [Running] - Oracle VM VirtualBox"
bid_price := 2510000
ask_price := 2560000
bid_quantity := 2
ask_quantity := 3

auto_trading_stage := 1
stop_auto_trading := false

bid_price_x1 := 1
bid_price_x2 := 1
bid_price_x3 := 1
bid_price_x4 := 1
bid_price_x5 := 1
ask_price_x1 := 1
ask_price_x2 := 1
ask_price_x3 := 1
ask_price_x4 := 1
ask_price_x5 := 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; start programe

Goto, GUIstart

MButton::
ExitApp
return

^k::
debug := true
return
;leave := false
;loop{
;	if(leave){
;		MsgBox, bye bye
;		return
;	}
;	
;	Send, ^v
;	sleep 6000
;}
;return


^j::
GUIstart:
Loop, Read, %ConfigFileName%
{
	StringSplit, var, A_LoopReadLine, =
 
	;simple check for valid line
	if (var0 == 2 and var1 != "" and var2 != "") {
		%var1% := var2
		;MsgBox %var2%
		if(InArray(ConfigVarString, var1)) > 0{
			;MsgBox %var2%
			%var1% := var2
		} else {
			%var1% := floor(var2) ;number
		}
	}
	var1 :=  ""
	var2 :=  ""
}

Gui, Add, Tab3,, 想釣魚|想打怪|想自動買賣防爆

Gui, Tab, 1

Gui, Add, Text, ys , VM name:
Gui, Add, Text,, VM
Gui, Add, Text,, 開關此VM:
Gui, Add, Text,, 開關經驗值技:
Gui, Add, Text,, 開關防斷線技:
Gui, Add, Text,, 開關魚餌技:
Gui, Add, Text,, 開關大師級釣技:
Gui, Add, Text,, 經驗值技按鈕:
Gui, Add, Text,, 防斷線技按鈕:
Gui, Add, Text,, 魚餌技按鈕:
Gui, Add, Text,, 大師級釣技按鈕:
Gui, Add, Text,, 岸釣技按鈕:
Gui, Add, Text,, 收杆按鈕:

Gui, Add, Text , ys, VM1
Gui, Add, Edit, vvm1_name , %vm1_name%
Gui, Add, ComboBox, vvm1_onoff, ON|OFF
Gui, Add, ComboBox, vvm1_onoff_needExpSkill, ON|OFF
Gui, Add, ComboBox, vvm1_onoff_needCuttingSkill, ON|OFF
Gui, Add, ComboBox, vvm1_onoff_needBaitSkill, ON|OFF
Gui, Add, ComboBox, vvm1_onoff_needBigFishingSkill, ON|OFF
Gui, Add, ComboBox, vvm1_expSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm1_cuttingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm1_baitSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm1_bigFishingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm1_fishingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm1_hookSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0

Gui, Add, Text , ys, VM2
Gui, Add, Edit, vvm2_name , %vm2_name%
Gui, Add, ComboBox, vvm2_onoff, ON|OFF
Gui, Add, ComboBox, vvm2_onoff_needExpSkill, ON|OFF
Gui, Add, ComboBox, vvm2_onoff_needCuttingSkill, ON|OFF
Gui, Add, ComboBox, vvm2_onoff_needBaitSkill, ON|OFF
Gui, Add, ComboBox, vvm2_onoff_needBigFishingSkill, ON|OFF
Gui, Add, ComboBox, vvm2_expSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm2_cuttingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm2_baitSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm2_bigFishingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm2_fishingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm2_hookSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0

Gui, Add, Text , ys, VM3
Gui, Add, Edit, vvm3_name , %vm3_name%
Gui, Add, ComboBox, vvm3_onoff, ON|OFF
Gui, Add, ComboBox, vvm3_onoff_needExpSkill, ON|OFF
Gui, Add, ComboBox, vvm3_onoff_needCuttingSkill, ON|OFF
Gui, Add, ComboBox, vvm3_onoff_needBaitSkill, ON|OFF
Gui, Add, ComboBox, vvm3_onoff_needBigFishingSkill, ON|OFF
Gui, Add, ComboBox, vvm3_expSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm3_cuttingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm3_baitSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm3_bigFishingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm3_fishingSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0
Gui, Add, ComboBox, vvm3_hookSkillButton, 1|2|3|4|5|6|7|8|9|0|q|w|e|r|t|^q|^w|^e|^r|^t|^1|^2|^3|^4|^5|^6|^7|^8|^9|^0


;Gui, Add, Edit, vLastName
Gui, Add, Text , ys, 
Gui, Add, Button, ,開始釣魚
Gui, Add, Button, ,停止釣魚
Gui, Add, Button, ,儲存設定

Gui, Tab, 2
;Gui, Add, Button, ,開始打怪
Gui, Add, Button, ,開始打BEE
Gui, Add, Button, ,開始打龍屍
Gui, Add, Button, ,開始打龍之巢穴
Gui, Add, Button, ,開始打龍之巢穴龍人
Gui, Add, Button, ,開始打龍之巢穴內部
Gui, Add, Button, ,開始打冰之地牢

Gui, Tab, 3
Gui, Add, Text , ys, 
Gui, Add, Text ,, VM
Gui, Add, Edit, vvm_atuo_trading_name , %vm_atuo_trading_name%
Gui, Add, Text ,, 買入價
Gui, Add, Edit, vbid_price , %bid_price%
Gui, Add, Text ,, 賣出價
Gui, Add, Edit, vask_price , %ask_price%
Gui, Add, Text ,, 尚餘(收)買入數量
Gui, Add, Edit, vbid_quantity , %bid_quantity%
Gui, Add, Text ,, 尚餘(放)賣出數量
Gui, Add, Edit, vask_quantity , %ask_quantity%

Gui, Add, Text , ys, 
Gui, Add, Text ,, 用錢收防爆
Gui, Add, Text, w100 vbid_price_x1, %bid_price_x1%
Gui, Add, Text, w100 vbid_price_x2, %bid_price_x2%
Gui, Add, Text, w100 vbid_price_x3, %bid_price_x3%
Gui, Add, Text, w100 vbid_price_x4, %bid_price_x4%
Gui, Add, Text, w100 vbid_price_x5, %bid_price_x5%
Gui, Add, Text ,, 比防爆人地
Gui, Add, Text, w100 vask_price_x1, %ask_price_x1%
Gui, Add, Text, w100 vask_price_x2, %ask_price_x2%
Gui, Add, Text, w100 vask_price_x3, %ask_price_x3%
Gui, Add, Text, w100 vask_price_x4, %ask_price_x4%
Gui, Add, Text, w100 vask_price_x5, %ask_price_x5%


Gui, Add, Text , ys, 
Gui, Add, Text ,, 複雜錢
Gui, Add, Button, ,複雜收1
Gui, Add, Button, ,複雜收2
Gui, Add, Button, ,複雜收3
Gui, Add, Button, ,複雜收4
Gui, Add, Button, ,複雜收5

Gui, Add, Text , ys, 
Gui, Add, Button, ,開始自動買賣防爆
Gui, Add, Button, ,停止自動買賣防爆
Gui, Add, Text ,, 用錢收左防爆
Gui, Add, Button, ,已收1
Gui, Add, Button, ,已收2
Gui, Add, Button, ,已收3
Gui, Add, Button, ,已收4
Gui, Add, Button, ,已收5
Gui, Add, Text ,, 比左防爆人地
Gui, Add, Button, ,已放1
Gui, Add, Button, ,已放2
Gui, Add, Button, ,已放3
Gui, Add, Button, ,已放4
Gui, Add, Button, ,已放5
Gui, Add, Button, ,儲存設定
Gui, Show,, morning

calculate_bid_ask_x5()


GuiControl, ChooseString, vm1_onoff, %vm1_onoff%
GuiControl, ChooseString, vm1_onoff_needExpSkill, %vm1_onoff_needExpSkill%
GuiControl, ChooseString, vm1_onoff_needCuttingSkill, %vm1_onoff_needCuttingSkill%
GuiControl, ChooseString, vm1_onoff_needBaitSkill, %vm1_onoff_needBaitSkill%
GuiControl, ChooseString, vm1_onoff_needBigFishingSkill, %vm1_onoff_needBigFishingSkill%
GuiControl, ChooseString, vm1_expSkillButton, %vm1_expSkillButton%
GuiControl, ChooseString, vm1_cuttingSkillButton, %vm1_cuttingSkillButton%
GuiControl, ChooseString, vm1_baitSkillButton, %vm1_baitSkillButton%
GuiControl, ChooseString, vm1_bigFishingSkillButton, %vm1_bigFishingSkillButton%
GuiControl, ChooseString, vm1_fishingSkillButton, %vm1_fishingSkillButton%
GuiControl, ChooseString, vm1_hookSkillButton, %vm1_hookSkillButton%

GuiControl, ChooseString, vm2_onoff, %vm2_onoff%
GuiControl, ChooseString, vm2_onoff_needExpSkill, %vm2_onoff_needExpSkill%
GuiControl, ChooseString, vm2_onoff_needCuttingSkill, %vm2_onoff_needCuttingSkill%
GuiControl, ChooseString, vm2_onoff_needBaitSkill, %vm2_onoff_needBaitSkill%
GuiControl, ChooseString, vm2_onoff_needBigFishingSkill, %vm2_onoff_needBigFishingSkill%
GuiControl, ChooseString, vm2_expSkillButton, %vm2_expSkillButton%
GuiControl, ChooseString, vm2_cuttingSkillButton, %vm2_cuttingSkillButton%
GuiControl, ChooseString, vm2_baitSkillButton, %vm2_baitSkillButton%
GuiControl, ChooseString, vm2_bigFishingSkillButton, %vm2_bigFishingSkillButton%
GuiControl, ChooseString, vm2_fishingSkillButton, %vm2_fishingSkillButton%
GuiControl, ChooseString, vm2_hookSkillButton, %vm2_hookSkillButton%

GuiControl, ChooseString, vm3_onoff, %vm3_onoff%
GuiControl, ChooseString, vm3_onoff_needExpSkill, %vm3_onoff_needExpSkill%
GuiControl, ChooseString, vm3_onoff_needCuttingSkill, %vm3_onoff_needCuttingSkill%
GuiControl, ChooseString, vm3_onoff_needBaitSkill, %vm3_onoff_needBaitSkill%
GuiControl, ChooseString, vm3_onoff_needBigFishingSkill, %vm3_onoff_needBigFishingSkill%
GuiControl, ChooseString, vm3_expSkillButton, %vm3_expSkillButton%
GuiControl, ChooseString, vm3_cuttingSkillButton, %vm3_cuttingSkillButton%
GuiControl, ChooseString, vm3_baitSkillButton, %vm3_baitSkillButton%
GuiControl, ChooseString, vm3_bigFishingSkillButton, %vm3_bigFishingSkillButton%
GuiControl, ChooseString, vm3_fishingSkillButton, %vm3_fishingSkillButton%
GuiControl, ChooseString, vm3_hookSkillButton, %vm3_hookSkillButton%

debug := ONOFF2Bool(debug)
leave := ONOFF2Bool(leave)

return

Button停止釣魚:
leave := true
;MsgBox "%vm2_onoff%"
return

GuiClose:
ExitApp

Button儲存設定:
Save_setting:
Gui, Submit, Nohide  ; Save the input from the user to each control's associated variable.
FileDelete %ConfigFileName%
;FileAppend, % "debug=" Bool2ONOFF(debug) "`n", %ConfigFileName%
FileAppend, debug=%debug%`n, %ConfigFileName%
FileAppend, leave=%leave%`n, %ConfigFileName%
FileAppend, ExpSkillCooldownTime=%ExpSkillCooldownTime%`n, %ConfigFileName%
FileAppend, CuttingSkillCooldownTime=%CuttingSkillCooldownTime%`n, %ConfigFileName%
FileAppend, BaitSkillCooldownTime=%BaitSkillCooldownTime%`n, %ConfigFileName%
FileAppend, AntiPluginCooldownTime=%AntiPluginCooldownTime%`n, %ConfigFileName%
FileAppend, WaitingWaitingTime=%WaitingWaitingTime%`n, %ConfigFileName%
FileAppend, ExpSkillWaitingTime=%ExpSkillWaitingTime%`n, %ConfigFileName%
FileAppend, CuttingSkillWaitingTime=%CuttingSkillWaitingTime%`n, %ConfigFileName%
FileAppend, BaitSkillWaitingTime=%BaitSkillWaitingTime%`n, %ConfigFileName%
FileAppend, FishingSkillWaitingTime=%FishingSkillWaitingTime%`n, %ConfigFileName%
FileAppend, pointerX=%pointerX%`n, %ConfigFileName%
FileAppend, pointerY=%pointerY%`n, %ConfigFileName%
FileAppend, AntiPluginRChecking=%AntiPluginRChecking%`n, %ConfigFileName%
FileAppend, AntiPluginGChecking=%AntiPluginGChecking%`n, %ConfigFileName%
FileAppend, AntiPluginBChecking=%AntiPluginBChecking%`n, %ConfigFileName%
FileAppend, PointerDesctingAntiPluginX=%PointerDesctingAntiPluginX%`n, %ConfigFileName%
FileAppend, PointerDesctingAntiPluginY=%PointerDesctingAntiPluginY%`n, %ConfigFileName%
FileAppend, PointerAntiPluginConfirmX=%PointerAntiPluginConfirmX%`n, %ConfigFileName%
FileAppend, PointerAntiPluginConfirmY=%PointerAntiPluginConfirmY%`n, %ConfigFileName%
FileAppend, FullVMWidth=%FullVMWidth%`n, %ConfigFileName%
FileAppend, FullVMHeight=%FullVMHeight%`n, %ConfigFileName%
FileAppend, SizedVMWidthAdjustment=%SizedVMWidthAdjustment%`n, %ConfigFileName%
FileAppend, SizedVMHeightAdjustment=%SizedVMHeightAdjustment%`n, %ConfigFileName%
FileAppend, `n, %ConfigFileName%
FileAppend, vm1_onoff=%vm1_onoff%`n, %ConfigFileName%
FileAppend, vm1_name=%vm1_name%`n, %ConfigFileName%
FileAppend, vm1_onoff_needExpSkill=%vm1_onoff_needExpSkill%`n, %ConfigFileName%
FileAppend, vm1_onoff_needCuttingSkill=%vm1_onoff_needCuttingSkill%`n, %ConfigFileName%
FileAppend, vm1_onoff_needBaitSkill=%vm1_onoff_needBaitSkill%`n, %ConfigFileName%
FileAppend, vm1_onoff_needBigFishingSkill=%vm1_onoff_needBigFishingSkill%`n, %ConfigFileName%
FileAppend, vm1_expSkillButton=%vm1_expSkillButton%`n, %ConfigFileName%
FileAppend, vm1_cuttingSkillButton=%vm1_cuttingSkillButton%`n, %ConfigFileName%
FileAppend, vm1_baitSkillButton=%vm1_baitSkillButton%`n, %ConfigFileName%
FileAppend, vm1_bigFishingSkillButton=%vm1_bigFishingSkillButton%`n, %ConfigFileName%
FileAppend, vm1_fishingSkillButton=%vm1_fishingSkillButton%`n, %ConfigFileName%
FileAppend, vm1_hookSkillButton=%vm1_hookSkillButton%`n, %ConfigFileName%
FileAppend, `n, %ConfigFileName%
FileAppend, vm2_onoff=%vm2_onoff%`n, %ConfigFileName%
FileAppend, vm2_name=%vm2_name%`n, %ConfigFileName%
FileAppend, vm2_onoff_needExpSkill=%vm2_onoff_needExpSkill%`n, %ConfigFileName%
FileAppend, vm2_onoff_needCuttingSkill=%vm2_onoff_needCuttingSkill%`n, %ConfigFileName%
FileAppend, vm2_onoff_needBaitSkill=%vm2_onoff_needBaitSkill%`n, %ConfigFileName%
FileAppend, vm2_onoff_needBigFishingSkill=%vm2_onoff_needBigFishingSkill%`n, %ConfigFileName%
FileAppend, vm2_expSkillButton=%vm2_expSkillButton%`n, %ConfigFileName%
FileAppend, vm2_cuttingSkillButton=%vm2_cuttingSkillButton%`n, %ConfigFileName%
FileAppend, vm2_baitSkillButton=%vm2_baitSkillButton%`n, %ConfigFileName%
FileAppend, vm2_bigFishingSkillButton=%vm2_bigFishingSkillButton%`n, %ConfigFileName%
FileAppend, vm2_fishingSkillButton=%vm2_fishingSkillButton%`n, %ConfigFileName%
FileAppend, vm2_hookSkillButton=%vm2_hookSkillButton%`n, %ConfigFileName%
FileAppend, `n, %ConfigFileName%
FileAppend, vm3_onoff=%vm3_onoff%`n, %ConfigFileName%
FileAppend, vm3_name=%vm3_name%`n, %ConfigFileName%
FileAppend, vm3_onoff_needExpSkill=%vm3_onoff_needExpSkill%`n, %ConfigFileName%
FileAppend, vm3_onoff_needCuttingSkill=%vm3_onoff_needCuttingSkill%`n, %ConfigFileName%
FileAppend, vm3_onoff_needBaitSkill=%vm3_onoff_needBaitSkill%`n, %ConfigFileName%
FileAppend, vm3_onoff_needBigFishingSkill=%vm3_onoff_needBigFishingSkill%`n, %ConfigFileName%
FileAppend, vm3_expSkillButton=%vm3_expSkillButton%`n, %ConfigFileName%
FileAppend, vm3_cuttingSkillButton=%vm3_cuttingSkillButton%`n, %ConfigFileName%
FileAppend, vm3_baitSkillButton=%vm3_baitSkillButton%`n, %ConfigFileName%
FileAppend, vm3_bigFishingSkillButton=%vm3_bigFishingSkillButton%`n, %ConfigFileName%
FileAppend, vm3_fishingSkillButton=%vm3_fishingSkillButton%`n, %ConfigFileName%
FileAppend, vm3_hookSkillButton=%vm3_hookSkillButton%`n, %ConfigFileName%
FileAppend, `n, %ConfigFileName%
FileAppend, vm_atuo_trading_name=%vm_atuo_trading_name%`n, %ConfigFileName%
FileAppend, bid_price=%bid_price%`n, %ConfigFileName%
FileAppend, ask_price=%ask_price%`n, %ConfigFileName%
FileAppend, bid_quantity=%bid_quantity%`n, %ConfigFileName%
FileAppend, ask_quantity=%ask_quantity%`n, %ConfigFileName%

MsgBox 成功儲存設定
return


Button開始自動買賣防爆:
clipboard := % "[放]防爆" Floor(ask_price/10000) "M(" ask_quantity ") [收]防爆" Floor(bid_price/10000) "M(" bid_quantity ") 易,直接放錢/防爆"
stop_auto_trading := false

Loop{
	;active window
	WinActivate, %vm_atuo_trading_name%
	Sleep 1000
	
	;type text
	Send, {Enter}
	Sleep 500
	Send ^v
	Sleep 500
	Send, {Enter}
	
	;search
	search_qty := 8
	Loop, %search_qty%{
		Sleep 5000
		WinActivate, %vm_atuo_trading_name%
		
		ImageSearch, FoundX, FoundY, 0, 0, 1000, 1000, %A_ScriptDir%\\NosToolImage\\confirm_start_trade.bmp
		sleep 500
		if (ErrorLevel < 1){
			SoundBeep, 750, 1200
			Send, {Enter}
			return
		}
		
		if(stop_auto_trading){
			SoundBeep, 500, 700
			return
		}
	}
}
return

Button停止自動買賣防爆:
stop_auto_trading := true
return

Button複雜收1:
clipboard := % bid_price
WinActivate, %vm_atuo_trading_name%
copy_price_to_board()
return
Button複雜收2:
clipboard := % (bid_price * 2)
WinActivate, %vm_atuo_trading_name%
copy_price_to_board()
return
Button複雜收3:
clipboard := % (bid_price * 3)
WinActivate, %vm_atuo_trading_name%
copy_price_to_board()
return
Button複雜收4:
clipboard := % (bid_price * 4)
WinActivate, %vm_atuo_trading_name%
copy_price_to_board()
return
Button複雜收5:
clipboard := % (bid_price * 5)
WinActivate, %vm_atuo_trading_name%
copy_price_to_board()
return

Button已收1:
bid_quantity -= 1
update_trading_result()
goto, Save_setting
return
Button已收2:
bid_quantity -= 2
update_trading_result()
goto, Save_setting
return
Button已收3:
bid_quantity -= 3
update_trading_result()
goto, Save_setting
return
Button已收4:
bid_quantity -= 4
update_trading_result()
goto, Save_setting
return
Button已收5:
bid_quantity -= 5
update_trading_result()
goto, Save_setting
return

Button已放1:
ask_quantity -= 1
update_trading_result()
goto, Save_setting
return
Button已放2:
ask_quantity -= 2
update_trading_result()
goto, Save_setting
return
Button已放3:
ask_quantity -= 3
update_trading_result()
goto, Save_setting
return
Button已放4:
ask_quantity -= 4
update_trading_result()
goto, Save_setting
return
Button已放5:
ask_quantity -= 5
update_trading_result()
goto, Save_setting
return

;BEE
Button開始打BEE:
MapPoints := []
MapPoints[0,0] := 907
MapPoints[0,1] := 110
MapPoints[1,0] := 955
MapPoints[1,1] := 109
MapPoints[2,0] := 994
MapPoints[2,1] := 114
MapPoints[3,0] := 996
MapPoints[3,1] := 199
MapPoints[4,0] := 947
MapPoints[4,1] := 194
MapPoints[5,0] := 903
MapPoints[5,1] := 194
MainAttackLoopQty := 5
MapMoveDuration := 13
goto, AutoHitStart

;龍屍
Button開始打龍屍:
MapPoints := []
MapPoints[0,0] := 903
MapPoints[0,1] := 185
MapPoints[1,0] := 912
MapPoints[1,1] := 201
MainAttackLoopQty := 5
MapMoveDuration := 13
goto, AutoHitStart

;龍之巢穴
Button開始打龍之巢穴:
MapPoints := []
MapPoints[0,0] := 917
MapPoints[0,1] := 205
MapPoints[1,0] := 935
MapPoints[1,1] := 193
MainAttackLoopQty := 5
MapMoveDuration := 13
goto, AutoHitStart

;龍之巢穴龍人
Button開始打龍之巢穴龍人:
MapPoints := []
MapPoints[0,0] := 994
MapPoints[0,1] := 182
MapPoints[1,0] := 1004
MapPoints[1,1] := 156
MainAttackLoopQty := 5
MapMoveDuration := 13
goto, AutoHitStart

;龍之巢穴內部
Button開始打龍之巢穴內部:
MapPoints := []
MapPoints[0,0] := 903
MapPoints[0,1] := 131
MapPoints[1,0] := 903
MapPoints[1,1] := 164
MainAttackLoopQty := 5
MapMoveDuration := 13
goto, AutoHitStart

;開始打冰之地牢,新方法
Button開始打冰之地牢:
MapPoints := []
MapPoints[0,0] := 930
MapPoints[0,1] := 125
MapPoints[1,0] := 898
MapPoints[1,1] := 167
MainAttackLoopQty := 5
MapMoveDuration := 13
xStart := 200
yStart := 223
xEnd := 840
yEnd := 680
enemyColorCode := 0x2626ff
xDivision := 10
yDivision := 10
debug := false
goto, AutoHitV2Start



AutoHitStart:
AttackPoints := []
/*
AttackPoints[0,0] := 413
AttackPoints[0,1] := 389
AttackPoints[1,0] := 420
AttackPoints[1,1] := 477
AttackPoints[2,0] := 518
AttackPoints[2,1] := 574
AttackPoints[3,0] := 619
AttackPoints[3,1] := 504
AttackPoints[4,0] := 627
AttackPoints[4,1] := 382
AttackPoints[5,0] := 520
AttackPoints[5,1] := 336
*/
AttackPoints[0,0] := 413
AttackPoints[0,1] := 389
AttackPoints[1,0] := 619
AttackPoints[1,1] := 504
AttackPoints[2,0] := 420
AttackPoints[2,1] := 477
AttackPoints[3,0] := 627
AttackPoints[3,1] := 382


CheckMonsterSetectedX := 441
CheckMonsterSetectedY := 63
MapIndex := 0
EatButton := 4
MpWaterButton := 6
BuffSkillButton := 7
ExplodeSkillButton := 1
BladeSkillButton := "e"
UltimateSkillButton := "t"
;白色十字 442,63



WinActivate, win 10 [Running] - Oracle VM VirtualBox
Sleep 2000

;test
;MsgBox, % MapPoints.MaxIndex()
;ExitApp
/*Loop, 10{
	
	MouseMove, AttackPoints[MapIndex][0], AttackPoints[MapIndex][1]
	Sleep 700
	Click
	Sleep 700
	Send %BladeSkillButton%
	Sleep 700
	
	MapIndex++
	if(MapIndex>AttackPoints.MaxIndex()){
		MapIndex := 0
	}
}
ExitApp
;test
*/

/*
;MouseMove, 250, 350
;sleep 1000
;MouseMove, 750, 650
;sleep 1000
;PixelSearch, Px, Py, 250, 350, 750, 650, 0xc52e36, 19, Fast ;seach monstor
;PixelSearch, Px, Py, 270, 470, 750, 650, 0xc52e36, 25, Fast ;seach monstor
PixelSearch, Px, Py, 250, 350, 750, 750, 0xFF2626, 60, Fast ;seach monstor
if (!ErrorLevel){
	sleep 1000
	PixelGetColor, color, Px, Py
	MouseMove, Px, Py
	sleep 1000
	MsgBox, %Px% %Py% %color%
} else {
	MsgBox not found
}
ExitApp



PixelGetColor, color, 441, 63
if(color == "0xFFFFFF"){
	MsgBox %color%
} else {
	MsgBox NO
}
;PointerR := (color & 0x0000FF)         
;PointerG := (color & 0x00FF00) >> 8    
;PointerB := (color & 0xFF0000) >> 16

ExitApp
*/

loop{
	
	Send %BuffSkillButton%
	sleep 1000
	;Send 4
	;sleep 1000
	;ExitApp
	Send %EatButton%
	sleep 500
	MouseMove , MapPoints[MapIndex][0], MapPoints[MapIndex][1]
	sleep 500
	Click
	sleep 500
	
	Loop, %MapMoveDuration%{
		Send d
		sleep 1000
	}
	;ActionCount := 0
	
	send %EatButton%
	sleep 500
	send %UltimateSkillButton%
	sleep 3000
	Send d
	sleep 1000
	send %ExplodeSkillButton%
	sleep 1000
	
	AttackPointsIndex := 0
	
	Loop, %MainAttackLoopQty%{
		MouseMove, AttackPoints[AttackPointsIndex][0], AttackPoints[AttackPointsIndex][1]
		sleep 500
		Click
		sleep 2500
		PixelGetColor, color, 441, 63
		if(color == "0xFFFFFF"){
			Loop{
				send %BladeSkillButton%
				Sleep 1000
				Send x
				sleep 500
				PixelGetColor, color, 441, 63
				if(color != "0xFFFFFF"){
					Sleep 1000
					break
				}
			}
			send %EatButton%
			sleep 500
		} else {
			Send {Esc}
			Sleep 1000
		}
		send %ExplodeSkillButton%
		sleep 300
		Send d
		sleep 300
		Send x
		sleep 300
			
		AttackPointsIndex++
		if(AttackPointsIndex>AttackPoints.MaxIndex()){
			AttackPointsIndex := 0
		}	
	}
	
	Send {Esc}
	sleep 500
	Send %MpWaterButton% ;MP水
	sleep 500
	;send %EatButton%
	;sleep 500
	send %ExplodeSkillButton%
	sleep 500
	Send d
	sleep 500
	
	loop, 7{
		Send x
		sleep 500
	}
	
	
	MapIndex++
	if(MapIndex>MapPoints.MaxIndex()){
		MapIndex := 0
	}
	
}

return

AutoHitV2Start:

CheckMonsterSetectedX := 441
CheckMonsterSetectedY := 63
MapIndex := 0
EatButton := 4
MpWaterButton := 6
BuffSkillButton := 7
ExplodeSkillButton := 1
BladeSkillButton := "e"
UltimateSkillButton := "t"
;白色十字 442,63

currentXPoints := xStart
currentYPoints := yStart
xSpacing := Round((xEnd-xStart)/xDivision)
ySpacing := Round((yEnd-yStart)/yDivision)
enemyGrid := []
enemyDensityGrid := []
xIndex := 0
yIndex := 0

Sleep 1000
WinActivate, win 8.1 1 [Running] - Oracle VM VirtualBox
;WinActivate, Screenshot_2.png - IrfanView
Sleep 2000



loop{
	
	Send %BuffSkillButton%
	sleep 1000
	Send %EatButton%
	sleep 500
	MouseMove , MapPoints[MapIndex][0], MapPoints[MapIndex][1]
	sleep 500
	Click
	sleep 500
	
	Loop, %MapMoveDuration%{
		Send d
		sleep 1000
	}
	
	send %EatButton%
	sleep 500
	send %UltimateSkillButton%
	sleep 3000
	Send d
	sleep 1000
	send %ExplodeSkillButton%
	sleep 1000
	
	
	AttackPointsIndex := 0
	
	Loop, %MainAttackLoopQty%{
		enemyDensityGrid := []
		xIndex := 0
		Loop, %xDivision%{
			currentXPoints := xStart
			yIndex := 0
			Loop, %yDivision%{
				PixelSearch, Px, Py, currentXPoints, currentYPoints, (currentXPoints+xSpacing), (currentYPoints+ySpacing), enemyColorCode, 0, fast ;2
				if ErrorLevel{
					enemyGrid[xIndex, yIndex] := 0
				}else{
					enemyGrid[xIndex, yIndex] := 1
				}
				currentXPoints := currentXPoints + xSpacing
				enemyDensityGrid[xIndex, yIndex] := 0 ;initialize
				yIndex++
				;MouseMove, currentXPoints , currentYPoints
				;sleep 500
			}
			xIndex++
			currentYPoints := currentYPoints + ySpacing
		}
		output := "`n"
		for k1, row in enemyGrid{
			for k2, value in row{
				output .= value
				if(value == 1){
					enemyDensityGrid[(k1-1),(k2-1)] := enemyDensityGrid[(k1-1),(k2-1)] +1
					enemyDensityGrid[(k1-1),(k2+0)] := enemyDensityGrid[(k1-1),(k2+0)] +1
					enemyDensityGrid[(k1-1),(k2+1)] := enemyDensityGrid[(k1-1),(k2+1)] +1
					enemyDensityGrid[(k1+0),(k2-1)] := enemyDensityGrid[(k1+0),(k2-1)] +1
					enemyDensityGrid[(k1+0),(k2+0)] := enemyDensityGrid[(k1+0),(k2+0)] +2
					enemyDensityGrid[(k1+0),(k2+1)] := enemyDensityGrid[(k1+0),(k2+1)] +1
					enemyDensityGrid[(k1+1),(k2-1)] := enemyDensityGrid[(k1+1),(k2-1)] +1
					enemyDensityGrid[(k1+1),(k2+0)] := enemyDensityGrid[(k1+1),(k2+0)] +1
					enemyDensityGrid[(k1+1),(k2+1)] := enemyDensityGrid[(k1+1),(k2+1)] +1
				}
			}
			output .= "`n"
		}
		output .= "`n`n"
		maxXIndex := 0
		maxYIndex := 0
		maxDensityValue := 0
		for k1, row in enemyDensityGrid{
			for k2, value in row{
				if(value>maxDensityValue){
					maxDensityValue := value
					maxXIndex := k2
					maxYIndex := k1
				}
				output .= value
			}
			output .= "`n"
		}
		output .= "`n"
		output .= maxXIndex
		output .= "`n"
		output .= maxYIndex
		
		if(debug){
			MsgBox, % output
			ExitApp
		}
		
		currentXPoints := xStart + maxXIndex * xSpacing
		currentYPoints := yStart + maxYIndex * ySpacing
		MouseMove, currentXPoints , currentYPoints
		sleep 500
		PixelSearch, Px, Py, currentXPoints, currentYPoints, (currentXPoints+xSpacing), (currentYPoints+ySpacing), enemyColorCode, 0, fast ;2
		if ErrorLevel{
			continue
			;584 407 | 6 4
			;MsgBox, That color was not found in the specified region.
			;MsgBox % currentXPoints " | " currentYPoints
			;MouseMove, currentXPoints , currentYPoints
			;sleep 1000
			;ExitApp
		}else{
			;Px+=5
			;Py-=80
			Px+=20
			Py-=10
		}
		MouseMove, Px, Py
		
		sleep 500
		Click
		sleep 2500
		PixelGetColor, color, 441, 63
		if(color == "0xFFFFFF"){
			Loop{
				send %BladeSkillButton%
				Sleep 1000
				Send x
				sleep 500
				PixelGetColor, color, 441, 63
				if(color != "0xFFFFFF"){
					Sleep 1000
					break
				}
			}
			send %EatButton%
			sleep 500
		} else {
			Send {Esc}
			Sleep 1000
		}
		send %ExplodeSkillButton%
		sleep 300
		Send d
		sleep 300
		Send x
		sleep 300
	}
	
	Send {Esc}
	sleep 500
	Send %MpWaterButton% ;MP水
	sleep 500
	;send %EatButton%
	;sleep 500
	send %ExplodeSkillButton%
	sleep 500
	Send d
	sleep 500
	
	loop, 7{
		Send x
		sleep 500
	}
	
	
	MapIndex++
	if(MapIndex>MapPoints.MaxIndex()){
		MapIndex := 0
	}
	
}

return

Button開始釣魚:
Gui, Submit, Nohide  ; Save the input from the user to each control's associated variable.
VMSettings := []
index = 0;

index++
VMSettings[index] := {}
VMSettings[index].enable := ONOFF2Bool(vm1_onoff)
VMSettings[index].title := vm1_name
VMSettings[index].needExpSkill := ONOFF2Bool(vm1_onoff_needExpSkill)
VMSettings[index].needCuttingSkill := ONOFF2Bool(vm1_onoff_needCuttingSkill)
VMSettings[index].needBaitSkill := ONOFF2Bool(vm1_onoff_needBaitSkill)
VMSettings[index].needBigFishingSkill := ONOFF2Bool(vm1_onoff_needBigFishingSkill)
VMSettings[index].expSkillButton := vm1_expSkillButton
VMSettings[index].cuttingSkillButton := vm1_cuttingSkillButton
VMSettings[index].baitSkillButton := vm1_baitSkillButton
VMSettings[index].bigFishingSkillButton := vm1_bigFishingSkillButton
VMSettings[index].fishingSkillButton := vm1_fishingSkillButton
VMSettings[index].hookSkillButton := vm1_hookSkillButton

index++
VMSettings[index] := {}
VMSettings[index].enable := ONOFF2Bool(vm2_onoff)
VMSettings[index].title := vm2_name
VMSettings[index].needExpSkill := ONOFF2Bool(vm2_onoff_needExpSkill)
VMSettings[index].needCuttingSkill := ONOFF2Bool(vm2_onoff_needCuttingSkill)
VMSettings[index].needBaitSkill := ONOFF2Bool(vm2_onoff_needBaitSkill)
VMSettings[index].needBigFishingSkill := ONOFF2Bool(vm2_onoff_needBigFishingSkill)
VMSettings[index].expSkillButton := vm2_expSkillButton
VMSettings[index].cuttingSkillButton := vm2_cuttingSkillButton
VMSettings[index].baitSkillButton := vm2_baitSkillButton
VMSettings[index].bigFishingSkillButton := vm2_bigFishingSkillButton
VMSettings[index].fishingSkillButton := vm2_fishingSkillButton
VMSettings[index].hookSkillButton := vm2_hookSkillButton

index++
VMSettings[index] := {}
VMSettings[index].enable := ONOFF2Bool(vm3_onoff)
VMSettings[index].title := vm3_name
VMSettings[index].needExpSkill := ONOFF2Bool(vm3_onoff_needExpSkill)
VMSettings[index].needCuttingSkill := ONOFF2Bool(vm3_onoff_needCuttingSkill)
VMSettings[index].needBaitSkill := ONOFF2Bool(vm3_onoff_needBaitSkill)
VMSettings[index].needBigFishingSkill := ONOFF2Bool(vm3_onoff_needBigFishingSkill)
VMSettings[index].expSkillButton := vm3_expSkillButton
VMSettings[index].cuttingSkillButton := vm3_cuttingSkillButton
VMSettings[index].baitSkillButton := vm3_baitSkillButton
VMSettings[index].bigFishingSkillButton := vm3_bigFishingSkillButton
VMSettings[index].fishingSkillButton := vm3_fishingSkillButton
VMSettings[index].hookSkillButton := vm3_hookSkillButton

;MsgBox You entered "%vm1_onoff% %vm1_expSkillButton%".
;MsgBox "%vm1_expSkillButton%"
;MsgBox "%vm1_onoff%"
;MsgBox % VMSettings[index].enable

;return


leave := false
;MsgBox %CuttingSkillCooldownTime%

;search all VM from all window
WinGet, id, List,,, Program Manager
Loop, %id%
{
    VMID := id%A_Index%
    WinGetTitle, this_title, ahk_id %VMID%
	for key, VMSetting in VMSettings{
		if(this_title == VMSetting.title and VMSetting.enable == true){
			WinActivate, %this_title%
			CurrentActiveWindowID := VMID
			WinGetPos, WindowX, WindowY, WindowWidth, WindowHeight, A
			ResizedVMPointerX := pointerX - (FullVMWidth - WindowWidth) - SizedVMWidthAdjustment
			ResizedVMPointerY := pointerY - (FullVMHeight - WindowHeight) - SizedVMHeightAdjustment
			ResizedVMPointerDesctingAntiPluginX := PointerDesctingAntiPluginX - (FullVMWidth - WindowWidth) - SizedVMWidthAdjustment
			ResizedVMPointerDesctingAntiPluginY := PointerDesctingAntiPluginY - (FullVMHeight - WindowHeight) - SizedVMHeightAdjustment
			ResizedVMPointerAntiPluginConfirmX := PointerAntiPluginConfirmX - (FullVMWidth - WindowWidth) - SizedVMWidthAdjustment
			ResizedVMPointerAntiPluginConfirmY := PointerAntiPluginConfirmY - (FullVMHeight - WindowHeight) - SizedVMHeightAdjustment
			
			FishingArray[VMID] := {}
			FishingArray[VMID].id := VMID
			FishingArray[VMID].title := this_title
			FishingArray[VMID].needExpSkill := VMSetting.needExpSkill
			FishingArray[VMID].needCuttingSkill := VMSetting.needCuttingSkill
			FishingArray[VMID].needBaitSkill := VMSetting.needBaitSkill
			FishingArray[VMID].needBigFishingSkill := VMSetting.needBigFishingSkill
			FishingArray[VMID].expSkillButton := VMSetting.expSkillButton
			FishingArray[VMID].cuttingSkillButton := VMSetting.cuttingSkillButton
			FishingArray[VMID].baitSkillButton := VMSetting.baitSkillButton
			FishingArray[VMID].bigFishingSkillButton := VMSetting.bigFishingSkillButton
			FishingArray[VMID].fishingSkillButton := VMSetting.fishingSkillButton
			FishingArray[VMID].hookSkillButton := VMSetting.hookSkillButton
			FishingArray[VMID].WindowX := WindowX
			FishingArray[VMID].WindowY := WindowY
			FishingArray[VMID].WindowWidth := WindowWidth
			FishingArray[VMID].WindowHeight := WindowHeight
			FishingArray[VMID].PointerX := ResizedVMPointerX
			FishingArray[VMID].PointerY := ResizedVMPointerY
			FishingArray[VMID].ResizedVMPointerDesctingAntiPluginX := ResizedVMPointerDesctingAntiPluginX
			FishingArray[VMID].ResizedVMPointerDesctingAntiPluginY := ResizedVMPointerDesctingAntiPluginY
			FishingArray[VMID].ResizedVMPointerAntiPluginConfirmX := ResizedVMPointerAntiPluginConfirmX
			FishingArray[VMID].ResizedVMPointerAntiPluginConfirmY := ResizedVMPointerAntiPluginConfirmY
			FishingArray[VMID].status := "waiting"
			FishingArray[VMID].expSkillTriggerTime := 0 ;store the trigger timestamp
			FishingArray[VMID].cuttingSkillTriggerTime := 0 ;store the trigger timestamp
			FishingArray[VMID].baitSkillTriggerTime := 0 ;store the trigger timestamp
			FishingArray[VMID].lastActionTime := A_TickCount ;store the action timestamp
			FishingArray[VMID].checkPluginTime := A_TickCount ;store the check plugin timestamp
			FishingArray[VMID].clickPluinTriggerTime := A_TickCount ;store the check plugin timestamp
			FishingArray[VMID].haveToClickAntiPluginConfirm := false ;store the status to click
			FishingArray[VMID].pointerRChecking := 0
			FishingArray[VMID].pointerGChecking := 0
			FishingArray[VMID].pointerBChecking := 0
		}
	}
}
;return

loop{
	
	if(leave){
		MsgBox, 己停止釣魚
		return
	}
	
	;check nostales VM unfocus
	WinGet, CurrentCheckingActiveWindowID, ID, A
	IsUnfocus := false
	if(CurrentCheckingActiveWindowID != CurrentActiveWindowID){
		IsUnfocus := true
	}
	/*
	WinGet, CurrentCheckingActiveWindowID, ID, A
	if(CurrentCheckingActiveWindowID != CurrentActiveWindowID){
		sleep 1000
		ActivateWindowByTitle(CurrentActiveWindowID, CurrentActiveTitle)
	}
	*/
	
	for key, fishingObject in FishingArray{
		if(fishingObject.status == "waiting"){
			;if(fishingObject.id == CurrentActiveWindowID){ ;//check anti-plugin only when the window is focus
				if((fishingObject.checkPluginTime + AntiPluginCooldownTime) < A_TickCount){
					
					ActivateWindowByTitle(fishingObject.id, fishingObject.title)
					;MouseMove, PointerDesctingAntiPluginX, PointerDesctingAntiPluginY
					
					PixelGetColor, color, fishingObject.ResizedVMPointerDesctingAntiPluginX, fishingObject.ResizedVMPointerDesctingAntiPluginY
					PointerR := (color & 0x0000FF)         
					PointerG := (color & 0x00FF00) >> 8    
					PointerB := (color & 0xFF0000) >> 16	
							
					if (NumberNear(PointerR, AntiPluginRChecking, 5) and NumberNear(PointerG, AntiPluginGChecking, 5) and NumberNear(PointerB, AntiPluginBChecking, 5)){
						fishingObject.clickPluinTriggerTime := A_TickCount + 10000 ; plus 10 second
						fishingObject.haveToClickAntiPluginConfirm := true
						SoundPlay %AlertAudioPath%
						sleep 500
						Send {PrintScreen}
					}
					
					if(false){
						MsgBox, %   color "  R:" PointerR " G:" PointerG " B:" PointerB
						return
					}
					
					fishingObject.checkPluginTime := A_TickCount
					
					GoBackWorkingWindow()
				}
				
				if(fishingObject.haveToClickAntiPluginConfirm and fishingObject.clickPluinTriggerTime < A_TickCount){
					ActivateWindowByTitle(fishingObject.id, fishingObject.title)
					fishingObject.haveToClickAntiPluginConfirm := false
					MouseMove, fishingObject.ResizedVMPointerAntiPluginConfirmX, fishingObject.ResizedVMPointerAntiPluginConfirmY
					sleep 1000
					Click
					sleep 500
					
					GoBackWorkingWindow()
				}
			;}
		}
		
		if(fishingObject.status == "waiting"){
			if(A_TickCount > fishingObject.lastActionTime){
				if(fishingObject.needExpSkill){
					if(A_TickCount > (fishingObject.expSkillTriggerTime + ExpSkillCooldownTime)){
						ActivateWindowByTitle(fishingObject.id, fishingObject.title)
						sleep 500
						send % fishingObject.expSkillButton ;exp sill hotkey
						sleep 700
						fishingObject.expSkillTriggerTime := A_TickCount
						fishingObject.lastActionTime := A_TickCount + ExpSkillWaitingTime

						GoBackWorkingWindow()
					}
				}
				fishingObject.status := "exp_skill"
			}
			continue
		}
		
		if(fishingObject.status == "exp_skill"){
			if(A_TickCount > fishingObject.lastActionTime){
				if(fishingObject.needBaitSkill){
					if(A_TickCount > (fishingObject.baitSkillTriggerTime + BaitSkillCooldownTime)){
						ActivateWindowByTitle(fishingObject.id, fishingObject.title)
						sleep 500
						send % fishingObject.baitSkillButton ;bait skill hotkey
						sleep 700
						fishingObject.baitSkillTriggerTime := A_TickCount
						fishingObject.lastActionTime := A_TickCount + BaitSkillWaitingTime

						GoBackWorkingWindow()
					}
				}
				fishingObject.status := "bait_skill"
			}
			continue
		}
		
		if(fishingObject.status == "bait_skill"){
			if(A_TickCount > fishingObject.lastActionTime){
				if(fishingObject.needCuttingSkill){
					if(A_TickCount > (fishingObject.cuttingSkillTriggerTime + CuttingSkillCooldownTime)){
						ActivateWindowByTitle(fishingObject.id, fishingObject.title)
						sleep 500
						send % fishingObject.cuttingSkillButton ;cutting skill hotkey
						sleep 700
						fishingObject.cuttingSkillTriggerTime := A_TickCount
						fishingObject.lastActionTime := A_TickCount + CuttingSkillWaitingTime
						
						GoBackWorkingWindow()
					}
				}
				fishingObject.status := "cutting_skill"
			}
			continue
		}
		
		if(fishingObject.status == "cutting_skill"){
			if(A_TickCount > fishingObject.lastActionTime){
				ActivateWindowByTitle(fishingObject.id, fishingObject.title)
				sleep 500
				if(fishingObject.needBigFishingSkill){
					send % fishingObject.bigFishingSkillButton ;big fishing skill hotkey
					sleep 1000 ;fishing skill will overwrite big fishing skill
				}
				send % fishingObject.fishingSkillButton ;fishfishing skill hotkey
				fishingObject.status := "fishing_skill"
				fishingObject.lastActionTime := A_TickCount + FishingSkillWaitingTime
				
				GoBackWorkingWindow()
			}
			continue
		}
		
		if(fishingObject.status == "fishing_skill"){
			
			if(A_TickCount > fishingObject.lastActionTime){
				;calculate the target checking X,Y
				;checkingPointX := fishingObject.WindowX - FishingArray[CurrentActiveWindowID].WindowX + pointerX
				;checkingPointY := fishingObject.WindowY - FishingArray[CurrentActiveWindowID].WindowY + pointerY
				
				WinGetPos, WindowX, WindowY,,, A
				checkingPointX := fishingObject.WindowX - WindowX + fishingObject.PointerX
				checkingPointY := fishingObject.WindowY - WindowY + fishingObject.PointerY
				
				;MouseMove, checkingPointX+20, checkingPointY+20
				
				PixelGetColor, color, checkingPointX, checkingPointY
				PointerR := (color & 0x0000FF)         
				PointerG := (color & 0x00FF00) >> 8    
				PointerB := (color & 0xFF0000) >> 16
				
				if(fishingObject.pointerRChecking == 0){
					fishingObject.pointerRChecking := PointerR
					fishingObject.pointerGChecking := PointerG
					fishingObject.pointerBChecking := PointerB
				}
				
				if (!(NumberNear(PointerR, fishingObject.pointerRChecking, 15) and NumberNear(PointerG, fishingObject.pointerGChecking, 15) and NumberNear(PointerB, fishingObject.pointerBChecking, 15))){
					
					ActivateWindowByTitle(fishingObject.id, fishingObject.title)
                    sleep 100
					send % fishingObject.hookSkillButton ;hook skill hotkey
					fishingObject.status := "waiting"
					fishingObject.lastActionTime := A_TickCount + WaitingWaitingTime
					
					if(debug){
						MsgBox, % " R:" fishingObject.pointerRChecking " G:" fishingObject.pointerGChecking " B:" fishingObject.pointerBChecking " |  R:" PointerR " G:" PointerG " B:" PointerB
						return
					}
					
					GoBackWorkingWindow()
				}
			}
			
			continue
		}
	} ;for
} ;loop



return