#TWA (Prod):
Start-Process "\\twa.fdc.ibm\shares\Packages\CrowdStrike\Windows\WindowsSensor.GovLaggar.exe" -ArgumentList "/install","/quiet","norestart","CID=9CA52C24495C4E7A99ABB9310BE7AAA2-96","APP_PROXYNAME=10.3.6.30","APP_PROXYPORT=8080","ProvNoWait=1"

#TWA-LLZ (Prod):
Start-Process "\\twa.fdc.ibm\shares\Packages\CrowdStrike\Windows\WindowsSensor.GovLaggar.exe" -ArgumentList "/install","/quiet","norestart","CID=9CA52C24495C4E7A99ABB9310BE7AAA2-96","APP_PROXYNAME=10.3.33.30","APP_PROXYPORT=8080","ProvNoWait=1"

#TRW (Prod)
Start-Process "\\triwest.com\shares\Packages\CrowdStrike\Windows\WindowsSensor.GovLaggar.exe" -ArgumentList "/install","/quiet","norestart","CID=9CA52C24495C4E7A99ABB9310BE7AAA2-96","APP_PROXYNAME=10.3.6.30","APP_PROXYPORT=8080","ProvNoWait=1"

#TWS (Prod)
Start-Process "\\triwest.com\shares\Packages\CrowdStrike\Windows\WindowsSensor.GovLaggar.exe" -ArgumentList "/install","/quiet","norestart","CID=9CA52C24495C4E7A99ABB9310BE7AAA2-96","APP_PROXYNAME=10.3.109.30","APP_PROXYPORT=8080","ProvNoWait=1"

#TWS (Non-Prod)
Start-Process "\\triwest.com\shares\Packages\CrowdStrike\Windows\WindowsSensor.GovLaggar.exe" -ArgumentList "/install","/quiet","norestart","CID=9CA52C24495C4E7A99ABB9310BE7AAA2-96","APP_PROXYNAME=10.4.2.30","APP_PROXYPORT=8080","ProvNoWait=1"


