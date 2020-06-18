# Script to define regional settings on Azure Virtual Machines deployed from the market place
# Author: Alexandre Verkinderen
# Blogpost: https://mscloud.be/configure-regional-settings-and-windows-locales-on-azure-virtual-machines/
#
######################################33

#variables
$regionalsettingsURL = "https://github.com/leerodrigues/Azure/blob/master/101-ServerBuild/vmutc.xml"
$RegionalSettings = "D:\vmutc.xml"


#downdload regional settings file
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)


# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

# Set languages/culture. Not needed perse.
Set-WinSystemLocale pt-BR
Set-WinUserLanguageList -LanguageList pt-BR -Force
Set-Culture -CultureInfo pt-BR
Set-WinHomeLocation -GeoId 32
Set-TimeZone -Name "Brazil Standart Time"

# restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
Start-sleep -Seconds 40
Restart-Computer