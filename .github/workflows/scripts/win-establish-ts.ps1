# Bring up Tailscale and get IP
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
# Choose one of these next two lines, depending on the WiX priority
$NewPath = "C:\Program Files\Tailscale\;$currentPath"
#$NewPath = "$currentPath;$($Env:WIX)\bin"
$env:PATH = $NewPath

& tailscale up --authkey=$env:TAILSCALE_AUTH_KEY --hostname=gh-runner-vum


$tsIP = $null
$retries = 0
while (-not $tsIP -and $retries -lt 10) {
  $tsIP = & tailscale ip -4
  Start-Sleep -Seconds 5
  $retries++
}
if (-not $tsIP) { throw "Tailscale IP not assigned." }
echo "TAILSCALE_IP=$tsIP" >> $env:GITHUB_ENV
