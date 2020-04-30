# Get a site collection by site url
function Get-SiteCollection {    
    param($tenant, $siteUrl)
    try {
        Connect-PnPOnline $siteUrl -UseWebLogin
        Get-PnPSite
    }
    catch [System.Exception] { 
        write-host -f red $_.Exception.ToString()
        write-host "Attempt to get SPOSite insted"
        Connect-SPOService $tenant
        Get-SPOSite -Identity $siteUrl
    } 
}

# Remove definitively a site collection
function Remove-SiteCollection {
    param($tenant, $siteUrl)
    try {
        Connect-SPOService $tenant
        Remove-SPOSite -Identity $siteUrl
    }
    catch [System.Exception] { 
        write-host -f red $_.Exception.ToString()
    } 
}

# Remove definitively a deleted site collection
function Remove-DeletedSiteCollection {
    param($tenant, $siteUrl)
    try {
        Connect-SPOService $tenant
        Remove-SPODeletedSite -Identity $siteUrl
    }
    catch [System.Exception] { 
        write-host -f red $_.Exception.ToString()
    } 
}

# return all deleted sites
function Get-DeletedSiteCollections {
    param($tenant)
    try {
        Connect-SPOService $tenant
        Get-SPODeletedSite
    }
    catch [System.Exception] { 
        write-host -f red $_.Exception.ToString()
    } 
}

# variable def
$siteUrl = "<site-collection>"
$tenant = "<tenant>"

# script process
Get-SiteCollection -tenant $tenant -siteUrl $siteUrl