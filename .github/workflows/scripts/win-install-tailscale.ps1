
# Install Tailscale MSI
$tsUrl = "https://pkgs.tailscale.com/stable/tailscale-setup-1.92.3-amd64.msi"
$installerPath = "$env:TEMP\tailscale.msi"
Invoke-WebRequest -Uri $tsUrl -OutFile $installerPath
Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /quiet /norestart TARGETDIR=`"$env:WORK_SPACE/Tailscale`"" -Wait
Remove-Item $installerPath -Force
Get-ChildItem -Path "$env:WORK_SPACE/Tailscale" -File -Recurse
