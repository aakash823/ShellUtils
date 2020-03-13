

$userid = domainname\username'

$passwd = Get-content -Path path\secure.txt
$Securekey = ConvertTo-SecureString $passwd
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Securekey)
$Password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)


Write-output  "Stopping Services" > 'logfile.txt'
Write-host "Stopping Services"
$WindowsServices = @("Service1","Service2")

for ($i = 0;$i -lt $WindowsServices.length;$i++)
{
	
	if ((get-service -ComputerName hostname $WindowsServices[$i]).status -eq 'Stopped')
	{
		$var_output = $WindowsServices[$i] + " is stopped"
		Write-host $var_output
		Write-output $var_output >> 'logfile.txt'
		Start-Sleep -Milliseconds 1000
		continue
	}
	if ((get-service -ComputerName hostname $WindowsServices[$i]).status -eq 'StopPending')
	{	
		$ServicePID = (get-wmiobject win32_service -ComputerName hostname | where { $_.name -eq $WindowsServices[$i] }).processID
		Taskkill /S hostname /u domain\username /p $Password /PID $ServicePID /F
		$var_output =  $WindowsServices[$i] + " is stopped forcefully "
		Write-host "Service stopped Forcefully"
		Write-output $var_output >> 'logfile.txt'
	}
	if ((get-service -ComputerName hostname $WindowsServices[$i]).status -eq 'Running')
	{

		$service = Get-Service -Name $WindowsServices[$i] -ComputerName hostname
		$service.Stop();
		$maxTimeout = "00:00:15"
		$service.WaitForStatus('Stopped', $maxTimeout);
		if ((get-service -ComputerName hostname $WindowsServices[$i]).status -eq 'StopPending')
		{
			$ServicePID = (get-wmiobject win32_service -ComputerName hostname | where { $_.name -eq $WindowsServices[$i] }).processID
			Write-host $ServicePID
			Taskkill /S hostname /u domain\username /p $Password /PID $ServicePID /F
			$var_output =  $WindowsServices[$i] + " is stopped forcefully "
			Write-output $var_output >> 'logfile.txt'
			Write-host "Service stopped Forcefully"
		}
		if ((get-service -ComputerName hostname $WindowsServices[$i]).status -eq 'Stopped')
		{ 
			$var_output =  $WindowsServices[$i] + " is stopped"
			Write-output $var_output >> 'logfile.txt'
			Write-host 	$WindowsServices[$i] "IS STOPPED"
		}
	}
	
	Set-service -ComputerName hostname $WindowsServices[$i] -StartupType Manual
	Start-Sleep -Milliseconds 1000


}

Write-host -Foreground green "Server 1 Stopped"

Write-output "Services is stopped " >> 'logfile.txt'


Start-Sleep -Milliseconds 3000


# Stopping 2nd Server Services

Write-host -Foreground green "Stopping Services"

Write-output "Stopping Services" >> 'logfile.txt'


$WindowsServices2 = @("Service1","Service2")

for ($i = 0;$i -lt $WindowsServices2.length;$i++)
{
	
	if ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'Stopped')
	{
		$var_output = $WindowsServices2[$i] + " is stopped"
		Write-host $var_output
		Write-output $var_output >> 'logfile.txt'
		Start-Sleep -Milliseconds 1000
		continue
	}
	if ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'StopPending')
	{	
		$ServicePID = (get-wmiobject win32_service -ComputerName hostname | where { $_.name -eq $WindowsServices2[$i] }).processID
		Taskkill /S hostname /u domain\username /p $Password /PID $ServicePID /F
		$var_output = $WindowsServices2[$i] + " is stopped forcefully "
		Write-host "Service stopped Forcefully"
		Write-output $var_output >> 'logfile.txt'
	}
	if ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'Running')
	{

		$service = Get-Service -Name $WindowsServices2[$i] -ComputerName hostname
		$service.Stop();
		$maxTimeout = "00:00:15"
		$service.WaitForStatus('Stopped', $maxTimeout);
		if ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'StopPending')
		{
			$ServicePID = (get-wmiobject win32_service -ComputerName hostname | where { $_.name -eq $WindowsServices2[$i] }).processID
			Write-host $ServicePID
			Taskkill /S hostname /u domain\username /p $Password /PID $ServicePID /F
			$var_output =  $WindowsServices2[$i] + " is stopped forcefully "
			Write-output $var_output >> 'logfile.txt'
			Write-host "Service stopped Forcefully"
		}
		if ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'Stopped')
		{ 
			$var_output = $WindowsServices2[$i] + " is stopped forcefully "
			Write-output $var_output >> 'logfile.txt'
			Write-host 	$WindowsServices2[$i] "IS STOPPED"
		}
	}
	
	Set-service -ComputerName hostname $WindowsServices2[$i] -StartupType Manual
	Start-Sleep -Milliseconds 1000


}



Write-host -Foreground black -Background yellow "2nd server is stopped"

Write-output "Services is  stopped " >> 'logfile.txt'
Start-Sleep -Milliseconds 3000