﻿function Clear-GoogSheet {
    [cmdletbinding()]
    Param
    (      
      [parameter(Mandatory=$true,Position=0)]
      [String]
      $SpreadsheetId,
      [parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()]
      [string]
      $SpecifyRange,
      [parameter(Mandatory=$false)]
      [String]
      $SheetName,
      [parameter(Mandatory=$false)]
      [ValidateNotNullOrEmpty()]
      [String]
      $Owner = $Script:PSGoogle.AdminEmail,
      [parameter(Mandatory=$false)]
      [switch]
      $Raw,
      [parameter(Mandatory=$false)]
      [String]
      $AccessToken,
      [parameter(Mandatory=$false)]
      [ValidateNotNullOrEmpty()]
      [String]
      $P12KeyPath = $Script:PSGoogle.P12KeyPath,
      [parameter(Mandatory=$false)]
      [ValidateNotNullOrEmpty()]
      [String]
      $AppEmail = $Script:PSGoogle.AppEmail,
      [parameter(Mandatory=$false)]
      [ValidateNotNullOrEmpty()]
      [String]
      $AdminEmail = $Script:PSGoogle.AdminEmail
    )
if (!$AccessToken)
    {
    $AccessToken = Get-GoogToken -P12KeyPath $P12KeyPath -Scopes "https://www.googleapis.com/auth/drive" -AppEmail $AppEmail -AdminEmail $Owner
    }
$header = @{
    Authorization="Bearer $AccessToken"
    }
if ($SheetName)
    {
    if ($SpecifyRange -like "'*'!*")
        {
        Write-Error "SpecifyRange formatting error! When using the SheetName parameter, please exclude the SheetName when formatting the SpecifyRange value (i.e. 'A1:Z1000')"
        return
        }
    else
        {
        $SpecifyRange = "'$($SheetName)'!$SpecifyRange"
        }
    }
$URI = "https://sheets.googleapis.com/v4/spreadsheets/$SpreadsheetId/values/$SpecifyRange`:clear"
try
    {
    $response = Invoke-RestMethod -Method Post -Uri $URI -Headers $header -ContentType "application/json"
    if (!$Raw)
        {
        $full = @()
        $response.responses.updatedData.values | 
            % {
                $full += $($_ -replace "`t","  ") -join "`t"
                }
        $response | Add-Member -MemberType NoteProperty -Name "updatedData" -Value $($full | ConvertFrom-Csv -Delimiter "`t")
        }
    }
catch
    {
    try
        {
        $result = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($result)
        $reader.BaseStream.Position = 0
        $reader.DiscardBufferedData()
        $resp = $reader.ReadToEnd()
        $response = $resp | ConvertFrom-Json | 
            Select-Object @{N="Error";E={$Error[0]}},@{N="Code";E={$_.error.Code}},@{N="Message";E={$_.error.Message}},@{N="Domain";E={$_.error.errors.domain}},@{N="Reason";E={$_.error.errors.reason}}
        }
    catch
        {
        $response = $resp
        }
    }
return $response
}