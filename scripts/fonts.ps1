$shell = New-Object -com "Shell.Application"
$zip = $shell.NameSpace("C:\Users\vagrant\SourceCodePro_FontsOnly-1.017.zip")
$destination = "C:\Users\vagrant\"
foreach($item in $zip.items())
{
    $shell.Namespace($destination).CopyHere($item)
}

$fontPath = Join-Path (Join-Path $destination "SourceCodePro_FontsOnly-1.017") "TTF"
$dir = $shell.NameSpace($fontPath)
Get-ChildItem -Path $fontPath -filter "*.ttf" | ForEach {
    $dir.ParseName($_.Name).InvokeVerb("Install")
}

Remove-Item -Force "C:\Users\vagrant\SourceCodePro_FontsOnly-1.017.zip"
Remove-Item -Recurse -Force "C:\Users\vagrant\SourceCodePro_FontsOnly-1.017"
