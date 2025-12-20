#config definder
# Check and remove the registry key before running Sysprep
$regPath = "HKLM:\Software\Microsoft\Windows Advanced Threat Protection"
$valueName = "senseGuid"

if (Test-Path $regPath) {
    Remove-ItemProperty -Path $regPath -Name $valueName -Force
}

# Install Tailscale MSI
$tsUrl = "https://pkgs.tailscale.com/stable/tailscale-setup-1.92.3-amd64.msi"
$installerPath = "$env:TEMP\tailscale.msi"
Invoke-WebRequest -Uri $tsUrl -OutFile $installerPath
Start-Process msiexec.exe -ArgumentList "/i","`"$installerPath`"","/quiet","/norestart" -Wait
Remove-Item $installerPath -Force
Get-ChildItem -Path "$env:ProgramFiles\Tailscale" -File -Recurse
