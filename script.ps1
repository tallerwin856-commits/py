$ws = New-Object -ComObject Wscript.Shell
$ws.Popup("Привет, это тест!", 0, "Тестовое уведомление", 64+4096)
