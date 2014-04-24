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

#Run the ReSharper installer
$resharperInstallerPath = "C:\Users\vagrant\ReSharperSetup.8.2.0.2160.msi"
Start-Process -FilePath $resharperInstallerPath -ArgumentList "/qn" -Wait
Remove-Item -Force -Path $resharperInstallerPath

#Install the "Hide Main Menu" extension
$vsixInstallerPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\VSIXInstaller.exe"
$extensionPath = "c:\users\vagrant\HideMenu.vsix"
Start-Process -FilePath $vsixInstallerPath -ArgumentList "/q $extensionPath" -NoNewWindow -Wait
Remove-Item -Force -Path $extensionPath

#Set sane defaults for Visual Studio and skip the first run wizard.
#If it's not done in 60 seconds, then seriously WTF.
$settingsPath = "C:\Users\vagrant\Sane.vssettings"
$devenvPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
$process = Start-Process -FilePath $devenvPath -ArgumentList "/ResetSettings $settingsPath /Command File.Exit" -NoNewWindow -PassThru
if ( ! $process.WaitForExit(60000) ) {
    $process.Kill()
}

#Make the menu less disgusting even though we hid it
Set-ItemProperty -Path HKCU:\Software\Microsoft\VisualStudio\12.0\General -Name SuppressUppercaseConversion -Type DWord -Value 1

#Clean up remaining files
Remove-Item -Force -Path $settingsPath
