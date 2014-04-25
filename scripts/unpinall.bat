reg DELETE HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /f
del /f /s /q /a "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
taskkill /f /im explorer.exe
start explorer.exe
