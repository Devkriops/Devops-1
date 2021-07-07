#Function Install_Tanium{
[CmdletBinding()] 
<#   
.SYNOPSIS   
Script that runs to Install Tanium Client on a system

.DESCRIPTION 
 
.PARAMETER 

.NOTES   
Name: Install_Tanium.ps1
Author: Miguel Mora
DateCreated: 2020-06-02
DateUpdated: 2020-06-02
Version: 1.0

.LINK

.EXAMPLE
	.\Install_Tanium.ps1 
#>
param(
)
Begin{

}
Process{
IF ( Get-Process| where {$_.processname -contains "TaniumClient"}){write-host "Tanium Running"

 $CIMOpt = New-CimSessionOption -Protocol Default
 $CIMSession = New-CimSession -SessionOption $CIMOpt
 $OSInfo     = (Get-CimInstance -CimSession $CIMSession -Class Win32_OperatingSystem)
 $ProductInfo     = (Get-CimInstance -CimSession $CIMSession -Class Win32_Product)
 $CurrentTaniumApplication = $ProductInfo | where {$_.name -like "Tanium*"} 

 stop-process -name "TaniumClient"
 $CurrentTaniumApplication.Uninstall()

 $InstallLocation = "\\xxxxxxxxxx\packages\Apps\Tanium\Client\New Client"
 robocopy "$InstallLocation" "$env:SystemDrive\Temp\Tanium" /XO /R:1 /W:1 "SetupClient.exe" "tanium.pub"

 cd "$env:SystemDrive\Temp\Tanium"
 .\SetupClient.exe /ServerAddress=xxxxxxxxx.xxx.fdc.ibm /ServerPort=17472 /LogVerbosityLevel=1 /KeyPath="$env:SystemDrive\Temp\Tanium\tanium.pub" /ReportingTLSMode=Optional /S
 pause 10
 cd c:\windows
 remove-item "$env:SystemDrive\Temp\Tanium" -Force -Recurse
}ELSE{

 $InstallLocation = "\\btwsxwvfsh005\packages\Apps\Tanium\Client\New Client"
 robocopy "$InstallLocation" "$env:SystemDrive\Temp\Tanium" /XO /R:1 /W:1 "SetupClient.exe" "tanium.pub"

 cd "$env:SystemDrive\Temp\Tanium"
 .\SetupClient.exe /ServerAddress=xxxxxxxxx.xxx.fdc.ibm /ServerPort=17472 /LogVerbosityLevel=1 /KeyPath="$env:SystemDrive\Temp\Tanium\tanium.pub" /ReportingTLSMode=Optional /S
 pause 10
 cd c:\windows
 remove-item "$env:SystemDrive\Temp\Tanium" -Force -Recurse
}
}

}
END{
}
#}
