
Write-Output "Drive Space Status " > drivespace.txt

Write-Output " Server 1 FreeSpace" >> drivespace.txt

Get-WmiObject Win32_LogicalDisk   -Filter "DeviceID='C:' OR  DeviceID='F:' OR DeviceID='G:'"| Format-Table Name,@{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}},@{n="Threshold";e={[math]::Round(($_.FreeSpace/$_.Size)*100,2)}},"%" >> drivespace.txt

Start-Sleep -Milliseconds 2000

Write-Output "Server 2 FreeSpace" >> drivespace.txt

Get-WmiObject Win32_LogicalDisk   -ComputerName hostname -Filter "DeviceID='C:' OR  DeviceID='F:'" | Format-Table Name,@{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}},@{n="Threshold";e={[math]::Round(($_.FreeSpace/$_.Size)*100,2)}},"%" >> drivespace.txt

Start-Sleep -Milliseconds 2000

Write-Output "Server 3 FreeSpace" >> drivespace.txt

Get-WmiObject Win32_LogicalDisk   -ComputerName hostname -Filter "DeviceID='C:' OR  DeviceID='H:'" | Format-Table Name,@{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}},@{n="Threshold";e={[math]::Round(($_.FreeSpace/$_.Size)*100,2)}},"%" >> drivespace.txt

$smtp = "smtp_service"
$to = "recipient_mail"
$from = "senders_mail"
$subject = "Disk space Status"
$body = "Disk drive status in  odex.   <br> Regards <br>" 
$attachment="path\drivespace.txt"
send-MailMessage -SmtpServer $smtp -To $to -From $from -Subject $subject -Body $body -BodyAsHtml -Attachment $attachment -Priority normal
