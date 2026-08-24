# ============================================================
# Скрипт для вывода уведомления Windows (Popup)
# ============================================================

# Вариант 1: Всплывающее окно через WScript.Shell (просто и работает везде)
$ws = New-Object -ComObject Wscript.Shell
$ws.Popup("Текст вашего сообщения", 0, "Заголовок окна", 64 + 4096)
# Параметры Popup:
#   текст, время_ожидания_сек (0 = бесконечно), заголовок, иконка+кнопки
#   64 = информационная иконка, 4096 = модальное окно (поверх всех)

# ============================================================
# Вариант 2: Использование MessageBox (более стандартный вид)
# ============================================================
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show("Текст сообщения", "Заголовок", "OK", "Information")

# ============================================================
# Вариант 3: Современный тост-уведомление (только Windows 10/11)
# ============================================================
# Требует загрузки сборок и использования Windows.UI.Notifications
# (это сложнее, но выглядит как системный тост в правом нижнем углу)

function Show-TileNotification {
    param($Title, $Message)
    Add-Type -AssemblyName System.Runtime.WindowsRuntime
    Add-Type -AssemblyName Windows.UI
    $appId = 'Microsoft.Windows.Explorer'
    $xml = @"
<toast>
    <visual>
        <binding template="ToastGeneric">
            <text>$Title</text>
            <text>$Message</text>
        </binding>
    </visual>
</toast>
"@
    $xmlDoc = New-Object Windows.Data.Xml.Dom.XmlDocument
    $xmlDoc.LoadXml($xml)
    $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($appId)
    $notifier.Show($xmlDoc)
}

# Show-TileNotification -Title "Мой заголовок" -Message "Привет, это уведомление!"

# ============================================================
# Вариант 4: Команда msg (показывает окно всем пользователям)
# ============================================================
# msg * "Текст сообщения"

# Выберите любой подходящий вариант. По умолчанию используется Вариант 1.
