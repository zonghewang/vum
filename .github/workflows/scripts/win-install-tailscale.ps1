
# # Install Tailscale MSI
# $tsUrl = "https://pkgs.tailscale.com/stable/tailscale-setup-full-1.92.3.exe"
# $installerPath = "$env:TEMP\tailscale.msi"
# $logPath = "$env:TEMP\tailscale-install.log"
# Invoke-WebRequest -Uri $tsUrl -OutFile $installerPath
# Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /quiet /norestart /log `"$logPath`" TARGETDIR=`"$env:WORK_SPACE\Tailscale`"" -Wait -NoNewWindow

# # 等待安装完成后检查结果
# $exitCode = $LASTEXITCODE

# # 根据退出代码判断安装是否成功
# if ($exitCode -eq 0) {
#     Write-Output "安装成功"
# } else {
#     Write-Output "安装失败，退出代码: $exitCode"
# }

# # 可选: 检查和显示安装日志的最后几行内容
# if (Test-Path $logPath) {
#     $logContent = Get-Content $logPath -Tail 50
#     Write-Output "日志内容:"
#     Write-Output $logContent
# } else {
#     Write-Output "日志文件不存在"
# }

# Remove-Item $installerPath -Force
# Get-ChildItem -Path "$env:WORK_SPACE\Tailscale" -File -Recurse


choco install -f tailscale
# [Environment]::SetEnvironmentVariable("Path",$Env:PATH + ";C:\Program Files\Tailscale\",[EnvironmentVariableTarget]::Machine)

$currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
# Choose one of these next two lines, depending on the WiX priority
$NewPath = "C:\Program Files\Tailscale\;$currentPath"
#$NewPath = "$currentPath;$($Env:WIX)\bin"
$env:PATH = $NewPath

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -Name "Path" -Value $NewPath
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -Name "Path"

echo ok
# [Environment]::SetEnvironmentVariable("PATH", $NewPath, "Machine")

refreshenv
Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -Name "Path"

$env:PATH -split ';' | ForEach-Object { $_ }
