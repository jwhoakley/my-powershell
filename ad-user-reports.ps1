$options = @(
    "Pull all users who have logged on in the last 90 days",
    "Pull all users and sort by last logon"
    "Pull only enabled users who have logged on in the last 90 days",
    "Pull only enabled users and sort by last logon",
    "Pull only SSE enabled users who have logged on in the last 90 days",
    "Pull only SSE enabled users and sort by last logon"
    "Exit script"
)

function Show-Menu {
    write-host "Please chose an option:"
    for ($i = 0; $i -lt $options.length; $i++) {
        write-host "$($i + 1) - $($options[$i])"
    }
    $choice = Read-host "Enter the number of your choice"
    return $choice
}

do {
    $choice = Show-Menu
    switch ($choice) {
        1 {
            # Pull all users who have logged on in the last 90 days
            get-ADUser -filter '*' -Properties LastLogonDate,EmailAddress | Where-object {$_.LastLogonDate -lt (get-date).AddDays(-90)} | Format-Table -Property EmailAddress, Name, LastLogonDate, UserPrincipalName, Enabled
        }
        2{
            # Pull all users and sort by last logon
            get-ADUser -filter '*' -Properties LastLogonDate,EmailAddress | Sort-Object -Property LastLogonDate -Descending | Format-Table -Property EmailAddress, Name, LastLogonDate, UserPrincipalName, Enabled
        }
        3 {
            # Pull only enabled users who have logged on in the last 90 days
            get-ADUser -filter 'Enabled -eq $true' -Properties LastLogonDate,EmailAddress | Where-object {$_.LastLogonDate -lt (get-date).AddDays(-90)} | Sort-Object -Property LastLogonDate -Descending | Format-Table -Property EmailAddress, Name, LastLogonDate, UserPrincipalName, Enabled

        }
        4{
            # Pull only enabled users and sort by last logon
            get-ADUser -filter 'Enabled -eq $true' -Properties LastLogonDate,EmailAddress | Sort-Object -Property LastLogonDate -Descending | Format-Table -Property EmailAddress, Name, LastLogonDate, UserPrincipalName, Enabled

        }
        5{
            # Pull only SSE enabled users who have logged on in the last 90 days
            get-ADUser -filter 'EmailAddress -like "*sse.*"' -Properties LastLogonDate,EmailAddress | Where-object {$_.LastLogonDate -lt (get-date).AddDays(-90)} | Format-Table -Property EmailAddress, Name, LastLogonDate, UserPrincipalName, Enabled
        }
        6{
            # Pull only SSE enabled users and sort by last logon 
            get-ADUser -filter 'EmailAddress -like "*sse.*"' -Properties LastLogonDate,EmailAddress | Sort-Object -Property LastLogonDate -Descending | Format-Table -Property EmailAddress, Name, LastLogonDate, UserPrincipalName, Enabled
        }
        7{
            exit
        }
        default{ write-host "Invalid choice. Please try again."}
    }
} while ($choice -ne 7)
