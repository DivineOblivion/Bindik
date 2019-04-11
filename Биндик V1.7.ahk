
#NoEnv
#SingleInstance Force
#NoTrayIcon

#include %A_ScriptDir%/Hotkey.ahk

SaveFile = %A_ScriptDir%/info.ini
Kov := SubStr("", 1,1)
GoSub Restore
Hotkey_IniPath(%Kov%SaveFile%Kov%)
Hotkey_IniSection("Section")
Hotkey_Arr("KillFocus", true)

IniRead, MyHotkey1, %SaveFile%, Section, MyHotkey1
b1 := WhatKey(Myhotkey1)
IniRead, MyHotkey2, %SaveFile%, Section, MyHotkey2
b2 := WhatKey(Myhotkey2)
IniRead, Ind, %SaveFile%, Settings, Ind
IniRead, Num1, %SaveFile%, Time, Num1
IniRead, Num2, %SaveFile%, Time, Num2
IniRead, NameWin, %SaveFile%, Settings, NameWin
IniRead, size, %SaveFile%, Settings, IndSize
If NameWin is space
	NameWin := "Во всех окнах"
IfNotExist, %A_Temp%\Биндик
	FileCreateDir, %A_Temp%\Биндик
FileInstall, D:\unlock.png, %A_Temp%\Биндик\unlock.png
FileInstall, D:\lock.png, %A_Temp%\Биндик\lock.png

Gui, +hwndhGui
Menu, HelpMenu, Add, Настройки, Settings
Menu, HelpMenu, Add, Связь с разработчиком, Link
Menu, HelpMenu, Add, О программе, MenuHandler
Menu, MyMenuBar, Add, Помощь, :HelpMenu
Gui, Menu, MyMenuBar
Gui, font, cRed s8
Gui, Add, Text, Center x0 y-2 h15 w220 hwndWindowCheck,
Gui, font, cRed s15
if NameWin != Во всех окнах
	GuiControl, Text, %WindowCheck%, Установленно определённое окно
Gui, Add, Text, Center x5 y10 w210 h25 vSt, Скрипт остановлен
Gui, font
T:=3
Gui, Add, GroupBox, xp y35 w240 h60, #1
Gui, Add, Text, x15 y48, Зацикливаю клавишу:
Hotkey_Add("Center x135 y45 w100 h15 -ReadOnly", "MyHotkey1", "KMLDRJNG1", Hotkey_Read("MyHotkey1"), "Save")
Gui, Add, Text, x15 y72, С задержкой (в сек.):
Gui, Add, Edit, Center number x135 y70 w100 h20 vNum1 hwndhEdit1 gEdit1, Num1
GuiControl, , Num1, %Num1%
Gui, Add, GroupBox, x5 y95 w240 h60, #2
Gui, Add, Text, x15 y108, Зацикливаю клавишу:
Hotkey_Add("Center x135 y105 w100 h15 -ReadOnly", "MyHotkey2", "KMLDRJNG1", Hotkey_Read("MyHotkey2"), "Save")
Gui, Add, Text, x15 y132, С задержкой (в сек.):
Gui, Add, Edit, Center number x135 y130 w100 h20 vNum2 hwndhEdit2 gEdit2, Num2
GuiControl, , Num2, %Num2%
Gui, font, cBlack
ControlFocus, , % "ahk_id" Hotkey_Arr("Focus")[hGui] 
l := 0
Gui, Add, Picture, x220 y0 w22 h39 vState1 gLock, %A_Temp%\Биндик\unlock.png
Gui, Add, Picture, x220 y0 w22 h39 vState0 gLock, %A_Temp%\Биндик\lock.png
Gui, Show, Restore  w250 h160, Биндик 
GoSub lock
GoSub Ind
WinActivate, Биндик
return



;-------------------------------------Block:Restore-------------------------------------------------
Restore: ; Проверяет есть ли ini файл в дериктории скрипта, чтобы брать от туда инфу. Если его нет, оно его создаёт.
{
	IfNotExist, %SaveFile%
	{
		IniWrite, %A_Space%, %SaveFile%, Section, MyHotkey1
		IniWrite, %A_Space%, %SaveFile%, Section, MyHotkey2
		IniWrite, 0, %SaveFile%, Time, Num1
		IniWrite, 0, %SaveFile%, Time, Num2
		IniWrite, 1, %SaveFile%, Settings, Ind
		IniWrite, %A_Space%, %SaveFile%, Settings, NameWin
		IniWrite, 10, %SaveFile%, Settings, IndSize
	}
}
return
;--------------------------------------Block:Едиты---------------------------------------------------
Edit1:
	GuiControlGet, Num1, , Num1
	if Num1 is space
	{
		SendMessage, EM_SETCUEBANNER := 0x1501, 0, "0", , ahk_id %hEdit1%
		Rezz1 := 20
	}
	else
		if (Num1 ~= "^00"){
			Num1 = 0
			Rezz1 := 20
			GuiControl, , Num1, %Num1%
			sendinput, {end}
		}
		else if (Num1 ~= "^0*[1-9]"){
			Num1 := RegExReplace(%Kov%Num1%Kov%, "^0")
			GuiControl, , Num1, %Num1%
			sendinput, {end}
			Rezz1 := Num1 * 1000
		}
	IniWrite, %Num1%, %SaveFile%, Time, Num1
    Return

Edit2:
	GuiControlGet, Num2, , Num2
	if Num2 is space
	{
		SendMessage, EM_SETCUEBANNER := 0x1501, 0, "0", , ahk_id %hEdit2%
		Rezz2 := 20
	}
	else
		if (Num2 ~= "^00"){
			Num2 = 0
			Rezz2 := 20
			GuiControl, , Num2, %Num2%
			sendinput, {end}
		}
		else if (Num2 ~= "^0*[1-9]"){
			Num2 := RegExReplace(%Kov%Num2%Kov%, "^0")
			GuiControl, , Num2, %Num2%
			sendinput, {end}
			Rezz2 := Num2 * 1000
		}
	IniWrite, %Num2%, %SaveFile%, Time, Num2
    Return
	
Save(Name) {
	HotKey := Hotkey_Write(Name)
}

Ind:
	Gui, Settings: Submit, NoHide
	IniWrite, %Ind%, %SaveFile%, Settings, Ind
	IniWrite, %size%, %SaveFile%, Settings, IndSize
	If Ind = 1
	{
		Gui, Indicator: New, -Caption +ToolWindow +AlwaysOnTop +Border
		If T=3
		Gui,Indicator: Color, Red
		If T=2
		Gui, Indicator: Color, bc943e8000
		If T=1
		Gui, Indicator: Color, Blue
		Gui, Indicator: Show, Restore x0 y0 w%size% h%size%, Индикатор
		GuiControl, Settings: Enable, size
		GuiControl, Settings: Enable, InfoIndSize
		GuiControl, Settings: Enable, Размер индикатора:
		Guicontrol, Settings:, InfoIndSize, %size%
		WinActivate, Настройки
	}
	else
	{
		Gui, Indicator: Destroy
		GuiControl, Settings: Disabled, size
		GuiControl, Settings: Disabled, InfoIndSize
		GuiControl, Settings: Disabled, Размер индикатора:
	}

return

;-----------------------------------------Block:Lock-----------------------------------------------------
Lock:
	if l = 1 ; Если заблокировано
	{
		If T = 1
			SendInput, {vk71}
		GuiControl, Hide, State0
		for name in Hotkey_Arr("AllHotkeys") 
		Hotkey_Disable(Name, 0) 
		GuiControl, -Disabled, Num1, % Num1
		If Num1 = 0
			GuiControl, , Num1,
		GuiControl,-Disabled, Num2, % Num2
		If Num2 = 0
			GuiControl, , Num2,
		l := 0
	}
	else if l = 0 ; Если разблокировано
	{
	   GuiControl, Show, State0
		for name in Hotkey_Arr("AllHotkeys") 
		Hotkey_Disable(Name) 
		If Num1 is space
			GuiControl, , Num1, 0
		GuiControl,+Disabled , Num1, % Num1
		If Num2 is space
			GuiControl, , Num2, 0
		GuiControl, +Disabled, Num2, % Num2
	   l := 1
	}
	If T = 1 and l = 1
		SendInput, {vk71}
return

;--------------------------------------Block:help-меню---------------------------------------------------
Settings:
	Gui, Settings: New
	If T = 1
		SendInput, {vk71}
	Gui, Settings: Add, Button, x30 w140 gHelpRestore, Перезаписать ini файл
	Gui, Settings: Add, Checkbox, x10 Checked%Ind% vInd gInd, Использовать индикатор?
	Gui, Settings: Add, Text, , Размер индикатора:
	Gui, Settings: Add, Slider, altsubmit yp+15 xp+30 w150 gInd vsize TickInterval3 ToolTip range5-20, %size%
	Gui, Settings: Add, Text, w20 xp-25 yp+7 vInfoIndSize, %size%
	If Ind = 0
	{
		GuiControl, Settings: Disabled, size
		GuiControl, Settings: Disabled, InfoIndSize
		GuiControl, Settings: Disabled, Размер индикатора:	
	}
	Gui, Settings: Add, GroupBox, w180 h70 yp+30 xp-5, Зацикливается в окне:
	Gui, Settings: Add, Edit, ReadOnly r1 w160 xp+10 yp+17 vNameWin, %NameWin%
	Gui, Settings: Add, button, gSettEd x118 yp+23, Изменить
	Gui, Settings: Add, button, gClear x20 yp, Очистить
	Gui, Settings: Show, Restore w200 h180, Настройки
	Gui, %hGui%: +Disabled 
return

Clear:
	IniWrite, %A_Space%, %SaveFile%, Settings, NameWin
	NameWin := "Во всех окнах"
	GuiControl, , NameWin, %NameWin%
	GuiControl, Text, %WindowCheck%,
return

SettEd:
	MsgBox, 1, Внимание!, После нажатия "OK" сделайте активным нужное окно и нажмите "Ctrl+c"
	IfMsgBox Ok
	{
		KeyWait, Control, D 
		KeyWait, c, D
		IfWinExist, Настройки
		{
			WinGetActiveTitle, NameWin
			MsgBox, 4, Внимание!, Сохранить активное окно : %NameWin%
			IfMsgBox Yes
			{
				IniWrite, %NameWin%, %SaveFile%, Settings, NameWin
				GuiControl, , NameWin, %NameWin%
				GuiControl, , %WindowCheck%, Установленно определённое окно
			}
			IfMsgBox No
			{
				IniRead, NameWin, %SaveFile%, Settings, NameWin
				If NameWin is space
					GuiControl, , NameWin, Во всех окнах
			}
		}
	}
	WinActivate, Настройки
return

Link:
	Run, http://forum.script-coding.com/viewtopic.php?pid=123303
return

MenuHandler:
	MsgBox, , О программе,
	(
Спасибо за помощь в разработке форуму forum.script-coding.com
Отдельное спасибо пользователям:
serzh82saratov
stealzy
teadrinker
---------------------------------------------------------------------------------
Скрипт способен зациклить клавишу(и) или сочетания клавиш в активном окне.
Чтобы начать работу:
1)Снимите блокировку ввода, нажав на замочек;
2)В поле "Зацикливаю клавишу" введите клавишу(и) для зацикливания;
(Левая кнопка мыши, для определения необходимо: зажать правую кнопку - зажать левую кнопку - отпустить правую кнопку или удерживать левую кнопку и щёлкнуть правой)
Двойной клик по строке ввода клавиш сбрасывает определённые в нём данные.)
3)В поле "С задержкой" введите количество секунд, через которое будет нажиматься клавиша.(Значение 0 равно 20 миллисекундам).
Запуск/Пауза: F2.
Стоп(Сброс):F3 (Таймер скрипта будет запускаться заново)
Закрыть программу: F10.
---------------------------------------------------------------------------------
Версия программы - v1.7
	)
return

HelpRestore: ; не удалось сохранить стиль кода всвязи функционала многострочного msgbox
{
MsgBox, 4, Внимание!, 
(
Это действие перезапишет файл Info.ini!
Все ваши настройки будут сброшены!
Вы хотите продолжить?
)
IfMsgBox Yes
{
	Filedelete, %SaveFile%
	GoSub Restore
	Reload
}
}
return

;T = 1 работает
;T = 2 пауза
;T = 3 остановлен

vk72:: ; f3
	pause, off
	T := 3
	GuiControl, -Disabled, Static11
	GuiControl, -Disabled, Static12
	SetTimer, Knopka1, off
	SetTimer, Knopka2, off
	Gui, font, cRed s15
	GuiControl, Font, St
	Guicontrol, , St, Скрипт остановлен
	Gui, Indicator: Color, Red
	return
	
vk71:: ; f2
	pause, off
	IniRead, MyHotkey1, %SaveFile%, Section, MyHotkey1
	b1 := WhatKey(Myhotkey1)
	IniRead, MyHotkey2, %SaveFile%, Section, MyHotkey2
	b2 := WhatKey(Myhotkey2)
	If (T = 2 or T = 3)
		IfWinNotExist, Настройки
		{
			T := 1
			GuiControl, Show, State0
			for name in Hotkey_Arr("AllHotkeys") 
			Hotkey_Disable(Name) 
			if Num1 is space
				GuiControl, , Num1, 0
			GuiControl, +Disabled, Num1, % Num1
			If Num2 is space
				GuiControl, , Num2, 0
			GuiControl, +Disabled, Num2, % Num2
			l := 1
			GuiControl, +Disabled, Static11
			GuiControl, +Disabled, Static12
			SetTimer, Loop, -1
			Gui, font, cBlue s15
			Guicontrol, , St, Скрипт работает
			GuiControl, Font, St
			Gui, Indicator: Color, Blue
			Loop:
			{
				SetTimer, Knopka1, %Rezz1%
				SetTimer, Knopka2, %Rezz2%
				return
			}
		}
		else
			MsgBox, Закройте окно "Настройки"!
	else if (T = 1)
	{
		T := 2
		GuiControl, -Disabled, Static11
		GuiControl, -Disabled, Static12
		Gui, font, cbc943e s15
		Guicontrol, , St, Скрипт на паузе 
		GuiControl, Font, St
		Gui, Indicator: Color, bc943e
		pause, On
	}
	return

Knopka1:
	If NameWin = Во всех окнах
		SendInput, %b1%
	else
		IfWinActive, %NameWin%
			SendInput, %b1%
	return

Knopka2:
	If NameWin = Во всех окнах
		SendInput, %b2%
	else
		IfWinActive, %NameWin%
			SendInput, %b2%
	return

WhatKey(Name){
	a := "{1 DownTemp}{2 DownTemp}{3 DownTemp}{4 DownTemp}{5 DownTemp}{6 DownTemp}{7 DownTemp}{8 DownTemp}{0}{8 Up}{7 Up}{6 Up}{5 Up}{4 Up}{3 Up}{2 Up}{1 Up}"
	If Instr(Name, "<^")
		StringReplace, a, a, 1, LCtrl, all
	If Instr(Name, ">^")
		StringReplace, a, a, 2, RCtrl, all
	If Instr(Name, "<+")
		StringReplace, a, a, 3, LShift, all
	If Instr(Name, ">+")
		StringReplace, a, a, 4, RShift, all
	If Instr(Name, "<!")
		StringReplace, a, a, 5, LAlt, all
	If Instr(Name, ">!")
		StringReplace, a, a, 6, RAlt, all
	If Instr(Name, "<#")
		StringReplace, a, a, 7, LWin, all
	If Instr(Name, ">#")
		StringReplace, a, a, 8, RWin, all
	loop, 16
	{
		a := RegExReplace(a, "U)[1-8].*p", "", , 1)
	}
	RegExMatch(%Kov%Name%Kov%, "[a-zA-Z0-9_].*", K)
	StringReplace, a, a, 0, %K%, 1
	return a
}

F10::ExitApp

SettingsGuiClose:
	Gui, Settings: Destroy
	Gui, %hGui%: -Disabled 
	WinActivate, Биндик
	return
Guiclose:
	ExitApp