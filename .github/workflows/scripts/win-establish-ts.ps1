# Bring up Tailscale and get IP

& tailscale up --authkey=$env:TAILSCALE_AUTH_KEY --hostname=gh-runner-win-vum --exit-node=100.64.113.11


$tsIP = $null
$retries = 0
while (-not $tsIP -and $retries -lt 10) {
  $tsIP = & tailscale ip -4
  Start-Sleep -Seconds 5
  $retries++
}
if (-not $tsIP) { throw "Tailscale IP not assigned." }
echo "TAILSCALE_IP=$tsIP" >> $env:GITHUB_ENV
