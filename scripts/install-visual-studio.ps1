#Mount ISO and figure out where it is
$isoPath = "C:\users\vagrant\en_visual_studio_premium_2013_x86_dvd_3175275.iso"
$rc = Mount-DiskImage -PassThru -ImagePath $isoPath
$driveLetter = ($rc | Get-Volume).DriveLetter

#Run the Visual Studio installer
$installPath = Join-Path "${driveLetter}:" "vs_premium.exe"
Start-Process -FilePath $installPath -ArgumentList "/adminfile A:\AdminDeployment.xml /quiet /norestart" -NoNewWindow -Wait

#Unmount the ISO and delete it
Dismount-DiskImage -ImagePath $isoPath
Remove-Item -Force -Path $isoPath 

$devenvPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
Start-Process -FilePath $devenvPath -ArgumentList "/ResetSettings A:\VSSaneDefaults.vssettings /Command File.Exit" -NoNewWindow -Wait

$vsixInstallerPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\VSIXInstaller.exe"
$extensionPath = "A:\HideMenu.vsix"
Start-Process -FilePath $vsixInstallerPath -ArgumentList "/q $extensionPath" -NoNewWindow -Wait

