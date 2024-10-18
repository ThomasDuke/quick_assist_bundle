if (Test-Path -Path "$env:TEMP\QuickAssist") { Remove-Item -Path "$env:TEMP\QuickAssist" -Recurse -Force }
New-Item -Path "$env:TEMP\QuickAssist" -ItemType Directory -Force

$splat = @{
    Uri     = 'https://github.com/ThomasDuke/quiqk_assist_bundle/raw/refs/heads/main/MicrosoftCorporationII.QuickAssist_2024.824.348.0_neutral_~_8wekyb3d8bbwe.AppxBundle'
    OutFile = "$env:TEMP\QuickAssist\QuickAssist.AppxBundle"
}
Invoke-WebRequest @splat

$splat = @{
    Uri     = 'https://github.com/ThomasDuke/quiqk_assist_bundle/raw/refs/heads/main/Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64__8wekyb3d8bbwe.Appx'
    OutFile = "$env:TEMP\QuickAssist\VCLibs.Appx"
}
Invoke-WebRequest @splat

Add-AppPackage -Path "$env:TEMP\QuickAssist\VCLibs.Appx"
Add-AppxPackage -Path "$env:TEMP\QuickAssist\QuickAssist.AppxBundle"
$Package = Get-AppxPackage -Name 'MicrosoftCorporationII.QuickAssist'
Start-Process 'explorer.exe' -ArgumentList "shell:AppsFolder\$($Package.PackageFamilyName)!App"
