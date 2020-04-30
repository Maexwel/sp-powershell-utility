# Function that set a Key-value PropertyBag to a site collection
# That property bag is indexed to appear in search
# cf https://blog.kloud.com.au/2018/04/26/how-to-make-property-bag-values-indexed-and-searchable-in-sharepoint-online/
function Set-PropertyBagValue {
    param($tenant, $siteCollection, $key, $value)
    try {
        Connect-SPOService $tenant # connect at tenant level
        Connect-PnPOnline $siteCollection -UseWebLogin # connect to site collection
        Write-Host "Attempt to set PropertyBag $key : $value ..."
        Set-SPOSite $siteCollection -DenyAddAndCustomizePages 0 # enable scripting
        Set-PnPPropertyBagValue -Key $key -Value $value -Indexed # set property bag and index for search
        Set-SPOSite $siteCollection -DenyAddAndCustomizePages 1 # disable scripting
        Write-Host -f green "Sucessfully set $key : $value !"
    }
    catch [System.Exception] { 
        write-host -f red $_.Exception.ToString() 
    } 
}

# variables def
$tenantAdmin = "https://<your_tenant>-admin.sharepoint.com"
$siteURL = "https://<your_tenant>.sharepoint.com/sites/<your_site_url>"
 
# script process
Set-PropertyBagValue -tenant $tenantAdmin -siteCollection $siteURL -key "<KEY>" -value "<VALUE>"