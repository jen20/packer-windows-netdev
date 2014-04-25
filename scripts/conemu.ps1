$conemuSetup = "C:\Users\vagrant\ConEmuSetup.140422.exe"
$conemuArgs = '/p:x64 /quiet ADDLOCAL="FConEmuGui,FConEmuGui64,ProductFeature,FConEmuBase32,FConEmuBase,FConEmuBase64,FConEmuCmdExt,FConEmuDocs,FCEShortcutStart"'

Write-Host "Installing ConEmu"
Start-Process -FilePath $conemuSetup -ArgumentList $conemuArgs -NoNewWindow -Wait

Write-Host "Pinning ComEmu to the TaskBar"
$shell = new-object -com "Shell.Application"
$dir = $shell.Namespace("C:\Program Files\ConEmu")
$item = $dir.ParseName("ConEmu64.exe")
$item.InvokeVerb('taskbarpin')
