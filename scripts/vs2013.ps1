$isoPath = "C:\users\vagrant\en_visual_studio_premium_2013_x86_dvd_3175275.iso"
$rc = Mount-DiskImage -PassThru -ImagePath $isoPath
$driveLetter = ($rc | Get-Volume).DriveLetter

Write-Host "Installing Visual Studio"
$installPath = Join-Path "${driveLetter}:" "vs_premium.exe"
Start-Process -FilePath $installPath -ArgumentList "/adminfile A:\AdminDeployment.xml /quiet /norestart" -NoNewWindow -Wait

Dismount-DiskImage -ImagePath $isoPath
Remove-Item -Force -Path $isoPath 


Write-Host "Installing Resharper"
$resharperInstallerPath = "C:\Users\vagrant\ReSharperSetup.8.2.0.2160.msi"
Start-Process -FilePath $resharperInstallerPath -ArgumentList "/qn" -Wait
Remove-Item -Force -Path $resharperInstallerPath


Write-Host "Installing the Hide Main Menu VSIX"
$vsixInstallerPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\VSIXInstaller.exe"
$extensionPath = "c:\users\vagrant\HideMenu.vsix"
Start-Process -FilePath $vsixInstallerPath -ArgumentList "/q $extensionPath" -NoNewWindow -Wait
Remove-Item -Force -Path $extensionPath


Write-Host "Importing some sensible defaults to Visual Studio and killing the first run wizard"
$settingsPath = "C:\Users\vagrant\Sane.vssettings"
$devenvPath = "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
$process = Start-Process -FilePath $devenvPath -ArgumentList "/ResetSettings $settingsPath /Command File.Exit" -NoNewWindow -PassThru
#If this doesn't complete in 1 minute, then seriously, WTF?
if ( ! $process.WaitForExit(60000) ) {
    $process.Kill()
}
Remove-Item -Force -Path $settingsPath


Write-Host "FIXING THE ALL CAPS MENU IN VISUAL STUDIO"
Set-ItemProperty -Path HKCU:\Software\Microsoft\VisualStudio\12.0\General -Name SuppressUppercaseConversion -Type DWord -Value 1


Write-Host "Configuring Resharper to use the IntelliJ Keyboard Scheme"
$dotSettingsSource = "C:\Users\vagrant\vsActionManager.DotSettings"
$dotSettingsDestination = "C:\Users\vagrant\AppData\Local\JetBrains\ReSharper\vAny\vs12.0"
New-Item $dotSettingsDestination -Type directory
Move-Item -Force -Path $dotSettingsSource -Destination $dotSettingsDestination


Write-Host "Pinning Visual Studio to the TaskBar"
$shell = new-object -com "Shell.Application"
$dir = $shell.Namespace("C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE")
$item = $dir.ParseName("devenv.exe")
$item.InvokeVerb('taskbarpin')


#We register ReSharper in the box VagrantFile instead of here as it's
# a per user setting which comes from an environment variable.
