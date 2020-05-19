Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

Get-SPTimerJob | Where Id -eq "JOB ID" | Start-SPTimerJob

# Variables
$StartTime = "05/01/2019 08:25:00 AM"  # mm/dd/yyyy hh:mm:ss
$EndTime = "05/19/2020 08:40:00 PM"
$TimerJobName = "JobName"
#public const string JOB_NAME = "Daily RAD Changes";
 #       public const string JOB_TITLE = "Nethys daily recovering of RAD Validations";
 
#To Get Yesterday's use:
#$StartDateTime = (Get-Date).AddDays(-1).ToString('MM-dd-yyyy') + " 00:00:00" 
#$EndDateTime   = (Get-Date).AddDays(-1).ToString('MM-dd-yyyy') + " 23:59:59"
 
#Get the specific Timer job
$Timerjob = Get-SPTimerJob | where { $_.DisplayName -eq $TimerJobName } 
 
#Get all timer job history from the web application
$Results = $Timerjob.HistoryEntries  | 
      where { ($_.StartTime -ge  $StartTime) -and ($_.EndTime -le $EndTime) } | 
          Select WebApplicationName,ServerName,Status,StartTime,EndTime
 
#Send results to Grid view    
$Results | Out-GridView

#Read more: https://www.sharepointdiary.com/2015/09/get-timer-job-history-using-powershell.html#ixzz6MsIFMXBK
