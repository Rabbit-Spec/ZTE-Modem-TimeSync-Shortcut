# --- 配置区 ---
$ModemIP = "192.168.1.1"
$User    = "root"
$Pass    = "Zte521"

# “光猫系统固有的处理延迟”，建议设为 2-5 秒
$FixOffset = 5 
# --------------

function Send-Command {
    param($Stream, $Command)
    $Writer = New-Object System.IO.StreamWriter($Stream)
    $Writer.AutoFlush = $true
    $Writer.WriteLine($Command)
}

try {
    Write-Host "正在连接光猫并同步时间..." -ForegroundColor Cyan
    $Socket = New-Object System.Net.Sockets.TcpClient($ModemIP, 23)
    $Stream = $Socket.GetStream()
    $Reader = New-Object System.IO.StreamReader($Stream)

    # 1. 发送用户名
    Send-Command $Stream $User
    Start-Sleep -Milliseconds 800
    
    # 2. 发送密码
    Send-Command $Stream $Pass
    Start-Sleep -Milliseconds 1200 # 给登录留足时间

    # 3. 在发送 date 之前的这一刻，才抓取当前时间
    $TargetTime = (Get-Date).AddSeconds($FixOffset)
    $DateStr = $TargetTime.ToString("MMddHHmmyyyy")
    $DisplayTime = $TargetTime.ToString("yyyy-MM-dd HH:mm:ss")

    # 4. 立即发送对时指令
    Send-Command $Stream "date $DateStr"
    Start-Sleep -Milliseconds 500
    Send-Command $Stream "exit"

    $Socket.Close()
    
    # 弹出中文通知
    $ws = New-Object -ComObject WScript.Shell
    $ws.Popup("光猫时间已同步至: $DisplayTime", 5, "校时成功", 64)
}
catch {
    Write-Host "连接失败，请检查网络。" -ForegroundColor Red
}