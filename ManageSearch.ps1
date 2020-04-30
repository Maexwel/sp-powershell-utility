# Return the craw log
function Get-CrawLog {
    param($tenant, $siteCollection, $date)
    try {
        Connect-PnPOnline $tenant -UseWebLogin
        if ($null -ne $siteCollection) {
            Get-PnPSearchCrawlLog -StartDate $date -Filter $siteCollection # get crawl log by site collection
        }
        else {
            Get-PnPSearchCrawlLog # get last 100 items
        }
    }
    catch [System.Exception] { 
        write-host -f red $_.Exception.ToString() 
    } 
}

# Reindex a site collection
# cf : https://www.sharepointdiary.com/2018/03/reindex-sharepoint-site-using-powershell.html
function Request-ReindexSiteCollection {
    param($tenant, $siteUrl)
    try { 
        Connect-PnPOnline $tenant -UseWebLogin
        $web = Get-PnPWeb -Identity $siteUrl 
        Request-PnPReIndexWeb -Web $web
    }
    catch [System.Exception] { 
        write-host -f red $_.Exception.ToString() 
    } 
}

# variable def
$siteUrl = "<site-collection>"
$tenant = "<tenant>"

# script process
Request-ReindexSiteCollection -siteUrl $siteUrl -tenant $tenant