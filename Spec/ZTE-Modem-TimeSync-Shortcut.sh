# 1.确保环境路径
export PATH="/opt/homebrew/bin:$PATH"

# 2.配置信息（请确认你的密码是否为 Zte521）
IP="192.168.1.1"
USER="root"
PASS="Zte521"

# 3.执行自动化登陆
/opt/homebrew/bin/expect <<EOF
set timeout 15
spawn telnet $IP

expect "Login:"
send "$USER\r"
expect "Password:"
send "$PASS\r"

# 4.在登录成功瞬间获取时间，并预加 1 秒补偿
expect "/ # "
set current_date [exec date -v+1S "+%Y-%m-%d %H:%M:%S"]
send "date -s \"\$current_date\"\r"

expect "/ # "
send "exit\r"
expect eof
EOF

# 5.获取通知显示的变量
TIME_TEXT=$(date -v+1S "+%Y-%m-%d %H:%M:%S")

# 6.弹出系统通知
osascript -e "display notification \"$TIME_TEXT\" with title \"光猫时间同步成功\""