

#Starting Archive Server



Write-host -Foreground green "Starting Server1"

Write-output "Starting Services" > 'logfile.txt'

$WindowsServices = @("Service1","Service2")

for ($i = 0; $i -lt $WindowsServices.length;$i++)
{
	if ((get-service  $WindowsServices[$i]).status -eq 'Running')
	{

		Get-Service -Name $WindowsServices[$i]  | Stop-service -Force
		
		Write-host $WindowsServices[$i] + "is stopped"
		
		Start-Sleep -Milliseconds 5000 
	}
	if ((get-service  $WindowsServices[$i]).status -eq 'Stopped')
	{	
		Get-Service -Name $WindowsServices[$i]  | Start-service
		do{ Start-Sleep -Milliseconds 1000 }
		until ((get-service  $WindowsServices[$i]).status -eq 'Running')
		$var_output = $WindowsServices[$i] + " is started"
		Write-host $WindowsServices[$i] + "is started"
		Write-output $var_output >> 'logfile.txt'
	}

	

	if ((get-service  $WindowsServices[$i]).status -eq 'StopPending')
	{
		$ServicePID = (get-wmiobject win32_service  | where { $_.name -eq $WindowsServices[$i] }).processID
		Stop-Process $ServicePID -Force
	}
	Set-service  $WindowsServices[$i] -StartupType Automatic
	Start-Sleep -Milliseconds 5000
	
}


Write-output " Server is started" >> 'logfile.txt'


Start-Sleep -Milliseconds 200

#Starting 2nd server

Write-output "Starting 2nd Server" >> 'logfile.txt'

$WindowsServices2 = @("Service1","Service2")

for ($i = 0;$i -lt $WindowsServices2.length;$i++)
{	
	if ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'Running')
	{

		Get-Service  -Name $WindowsServices2[$i] -ComputerName hostname | Stop-service -Force
		Write-host $WindowsServices2[$i] + "is stopped"
		Start-Sleep -Milliseconds 5000
	}
	
	if ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'Stopped')
	{
		Get-Service  -Name $WindowsServices2[$i] -ComputerName hostname | Start-service
		do{ Start-Sleep -Milliseconds 1000 }
		until ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'Running')
		$var_output =  $WindowsServices2[$i] + " is started"
		Write-host $WindowsServices2[$i] + "is started"
		Write-output $var_output >> 'logfile.txt'
	}
	
	if ((get-service -ComputerName hostname $WindowsServices2[$i]).status -eq 'StopPending')
	{
		$ServicePID = (get-wmiobject win32_service  -ComputerName hostname | where { $_.name -eq $WindowsServices2[$i] }).processID
		Stop-Process $ServicePID -Force
	}
	Set-service  -ComputerName hostname $WindowsServices2[$i] -StartupType Automatic
	Start-Sleep -Milliseconds 5000


}


Write-output   "Server is started" >> 'logfile.txt'


Start-Sleep -Milliseconds 2000