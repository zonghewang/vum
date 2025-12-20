
# Install Tailscale MSI
$tsUrl = "https://pkgs.tailscale.com/stable/tailscale-setup-1.92.3-amd64.msi"
$installerPath = "$env:TEMP\tailscale.msi"
$logPath = "$env:TEMP\tailscale-install.log"
Invoke-WebRequest -Uri $tsUrl -OutFile $installerPath
Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /quiet /norestart /log `"$logPath`" TARGETDIR=`"$env:WORK_SPACE\Tailscale`"" -Wait -NoNewWindow

# 等待安装完成后检查结果
$exitCode = $LASTEXITCODE

# 根据退出代码判断安装是否成功
if ($exitCode -eq 0) {
    Write-Output "安装成功"
} else {
    Write-Output "安装失败，退出代码: $exitCode"
}

# 可选: 检查和显示安装日志的最后几行内容
if (Test-Path $logPath) {
    $logContent = Get-Content $logPath -Tail 50
    Write-Output "日志内容:"
    Write-Output $logContent
} else {
    Write-Output "日志文件不存在"
}

Remove-Item $installerPath -Force
Get-ChildItem -Path "$env:WORK_SPACE\Tailscale" -File -Recurse
