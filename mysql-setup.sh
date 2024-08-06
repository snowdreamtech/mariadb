#!/usr/bin/expect

set timeout -1
spawn mysql_secure_installation
expect "Enter current password for root (enter for none):"
send "\r"
expect "Switch to unix_socket authentication"
send "Y\r"
expect "Change the root password?"
send "Y\r"
expect "New password:"
send "$env(MYSQL_ROOT_PASSWORD)\r"
expect "Re-enter new password:"
send "$env(MYSQL_ROOT_PASSWORD)\r"
expect "Remove anonymous users?"
if { $env(REMOVE_ANONYMOUS_USERS) == 1 } {
    send "Y\r"
} else {
    send "n\r"
}
expect "Disallow root login remotely?"
if { $env(DISALLOW_ROOT_LOGIN_REMOTELY) == 1 } {
    send "Y\r"
} else {
    send "n\r"
}
expect "Remove test database and access to it?"
if { $env(REMOVE_TEST_DATABASE) == 1 } {
    send "Y\r"
} else {
    send "n\r"
}
expect "Reload privilege tables now?"
send "Y\r"
expect eof
