# variables def
$tenantAdmin = "https://eoneprayon-admin.sharepoint.com"
$siteURL = "https://eoneprayon.sharepoint.com/sites/"
 
Set-PropertyBagValue -tenant $tenantAdmin -siteCollection $siteURL -key "site" -value ""
Set-PropertyBagValue -tenant $tenantAdmin -siteCollection $siteURL -key "direction" -value ""
Set-PropertyBagValue -tenant $tenantAdmin -siteCollection $siteURL -key "dpt" -value ""

# Function that set a Key-value PropertyBag to a site collection
# That property bag is indexed to appear in search
# cf https://blog.kloud.com.au/2018/04/26/how-to-make-property-bag-values-indexed-and-searchable-in-sharepoint-online/
function Set-PropertyBagValue {
    param($tenant, $siteCollection, $key, $value)
    try {
        Connect-SPOService $tenant
        Connect-PnPOnline $siteCollection
        Set-SPOSite $siteCollection -DenyAddAndCustomizePages 0 # enable scripting
        Set-PnPPropertyBagValue -Key $key -Value $value -Indexed # set property bag and index for search
        Set-SPOSite $siteCollection -DenyAddAndCustomizePages 1 # disable scripting
    }
    catch [System.Exception] { 
        write-host -f red $_.Exception.ToString() 
    } 
}