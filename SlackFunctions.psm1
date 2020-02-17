###
# Author: shskwmt
###

Function Get-SlackMentions {
  <#
  .SYNOPSIS
    Get slack mentions for me.
  #>
  Param (
    [Parameter(Mandatory)][String]$WorkSpace,
    [Parameter(Mandatory)][String]$Token,
    [Parameter(Mandatory)][String]$AuthToken,
    [ValidateRange(1,1000)][Int]$Count = 100
  )

  $mentionsUri = 'https://' + $WorkSpace + '.slack.com/api/activity.mentions'
  $mentionsParameters = @{
    token = $Token
    count = $Count
  }

  $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
  $cookie = New-Object System.Net.Cookie
  $cookie.Name = 'd'
  $cookie.Value = $AuthToken
  $cookie.Domain = '.slack.com'
  $session.Cookies.Add($cookie);

  $mentionsResponse = Invoke-WebRequest -Uri $mentionsUri -WebSession $session -Body $mentionsParameters
  return ConvertFrom-Json $mentionsResponse.Content
}

Function Get-SlackStarredMessages {
  <#
  .SYNOPSIS
    Get slack mentions for me.
  #>
  Param (
    [Parameter(Mandatory)][String]$WorkSpace,
    [Parameter(Mandatory)][String]$Token,
    [Parameter(Mandatory)][String]$AuthToken,
    [ValidateRange(1,1000)][Int]$Count = 100
  )

  $starsUri = 'https://' + $WorkSpace + '.slack.com/api/stars.list'
  $starsParameters = @{
    token = $Token
    count = $Count
    exclide = @('Ch', 'Gh', 'Dh')
  }

  $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
  $cookie = New-Object System.Net.Cookie
  $cookie.Name = 'd'
  $cookie.Value = $AuthToken
  $cookie.Domain = '.slack.com'
  $session.Cookies.Add($cookie);

  $starsResponse = Invoke-WebRequest -Uri $starsUri -WebSession $session -Body $starsParameters
  return ConvertFrom-Json $starsResponse.Content
}

Function Get-SlackUsers {
  <#
  .SYNOPSIS
    Get slack users.
  #>
  Param (
    [Parameter(Mandatory)][String]$WorkSpace,
    [Parameter(Mandatory)][String]$Token,
    [Parameter(Mandatory)][String]$AuthToken
  )

  $usersUri = 'https://' + $WorkSpace + '.slack.com/api/users.list'
  $usersParameters = @{
    token = $Token
  }

  $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
  $cookie = New-Object System.Net.Cookie
  $cookie.Name = 'd'
  $cookie.Value = $AuthToken
  $cookie.Domain = '.slack.com'
  $session.Cookies.Add($cookie);

  $usersResponse = Invoke-WebRequest -Uri $usersUri -WebSession $session -Body $usersParameters
  return ConvertFrom-Json $usersResponse.Content
}
