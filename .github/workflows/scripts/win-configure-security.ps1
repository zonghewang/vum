secedit /configure /db secedit.sdb /cfg $env:WORK_SPACE/.github/workflows/config/security.cfg /quiet
secedit /validate $env:WORK_SPACE/.github/workflows/config/security.cfg
secedit /configure /db secedit.sdb /cfg $env:WORK_SPACE/.github/workflows/config/security.cfg /log gp.log

echo y | secedit /configure /db secedit.sdb  /cfg $env:WORK_SPACE/.github/workflows/config/security.cfg  /overwrite
