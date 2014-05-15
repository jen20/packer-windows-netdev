#.NET Development Packer Templates

## What even is this?

This is a set of packer scripts to build an OKish .NET development environment that can be used with Vagrant or other provisioners. It is full of my opinions on how to set up a machine, but is a reasonable starting point for customization if you don't like my choices. It will do (broadly speaking):

- Install Windows
- Install Visual Studio 2013
- Install Resharper
- Install the Hide Main Menu plugin for Visual Studio
- Install Source Code Pro fonts
- Import some sensible defaults into Visual Studio (based on the IntelliJ keybindings)
- Install ConEmu
- Install Git for Windows
- Install a sensible theme for ConEmu (based on a chocolatey package whose name I forget)
- Install all the Windows updates
- Package this all up for Vagrant, with a template Vagrant file that enables the GUI, and registers Resharper when you do `vagrant up` based on a `.reg` export of the relevant part of the tree stored in the the `RESHARPER_LICENSE_REGKEY` environment variable, and configures git with your username and email address.

It builds from ISOs and downloaded images rather than using package managers - this is because I keep them on an external hard disk for when I travel and only have crappy hotel or conference internet. See below for the required source files and where you can get them from.

*You likely want to be using Vagrant 1.6 or higher - since this now supports Windows natively.*

## Acknowledgements

Most of the Windows installation process and the packer template were borrowed from here: `https://github.com/joefitzgerald/packer-windows` - without the availability of this project I likely wouldn't have even embarked on this.

## Required ISOs and Sources

- `en_windows_8_1_pro_vl_x64_dvd_2971948.iso` - MSDN
- `en_visual_studio_premium_2013_x86_dvd_3175275.iso` - MSDN
- `VS2013.1.iso` - `http://go.microsoft.com/fwlink/?LinkId=386593` (for once an MSFT link without a login wall)
- `HideMenu.vsix` - Included in repository (it's tiny)
- `ReSharperSetup.8.2.0.2160.msi` - `http://download.jetbrains.com/resharper/ReSharperSetup.8.2.0.2160.msi`
- `SourceCodePro_FontsOnly-1.017.zip` - Included in repository (again, tiny)
- `ConEmuSetup.140422.exe` - `http://www.fosshub.com/download/ConEmuSetup.140422.exe`
- `Git-1.9.2-preview20140411.exe` - `https://github.com/msysgit/msysgit/releases/download/Git-1.9.2-preview20140411/Git-1.9.2-preview20140411.exe`

## Additional bits that work if they're configured

- If `user.name` and `user.email` are set locally, they'll be provisioned on Windows as part of the Vagrant provisioning (not the packing, so they'll be per user).

- If there is a `RESHARPER_LICENSE_REGKEY` environment variable set pointing to a registry export of the Resharper license key, it will be imported as part of Vagrant provisioning.
