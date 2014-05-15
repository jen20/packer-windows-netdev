#.NET Development Packer Templates

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
