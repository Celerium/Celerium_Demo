function Test-RocketCyberAPIKey {
<#
    .SYNOPSIS
        Test the RocketCyber API bearer token.

    .DESCRIPTION
        The Test-RocketCyberAPIKey cmdlet tests the base URI & API
        bearer token that was defined in the
        Add-RocketCyberBaseURI & Add-RocketCyberAPIKey cmdlets.

    .PARAMETER base_uri
        Define the base URI for the RocketCyber API connection using RocketCyber's URI or a custom URI.

        The default base URI is https://api-us.rocketcyber.com/v3

    .PARAMETER id
        Data will be retrieved from this account id.

    .EXAMPLE
        Test-RocketCyberBaseURI -id 12345

        Tests the base URI & API bearer token that was defined in the
        Add-RocketCyberBaseURI & Add-RocketCyberAPIKey cmdlets.

        The default full base uri test path is:
            https://api-us.rocketcyber.com/v2/account/id

    .EXAMPLE
        Test-RocketCyberBaseURI -base_uri http://myapi.gateway.example.com -id 12345

        Tests the base URI & API bearer token that was defined in the
        Add-RocketCyberBaseURI & Add-RocketCyberAPIKey cmdlets.

        The full base uri test path in this example is:
            http://myapi.gateway.example.com/id

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/RocketCyber-PowerShellWrapper/site/Internal/Test-RocketCyberAPIKey.html
#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [string]$base_uri = $RocketCyber_Base_URI
    )

    $resource_uri = "/account"

    Write-Verbose "Testing API key against [ $($base_uri + $resource_uri) ]"

    try {

        $Api_Token = Get-RocketCyberAPIKey -PlainText
        $RocketCyber_Headers.Add('Authorization', "Bearer $Api_Token")

        $rest_output = Invoke-WebRequest -Method Get -Uri ($base_uri + $resource_uri) -Headers $RocketCyber_Headers -ErrorAction Stop
    }
    catch {

        [PSCustomObject]@{
            Method = $_.Exception.Response.Method
            StatusCode = $_.Exception.Response.StatusCode.value__
            StatusDescription = $_.Exception.Response.StatusDescription
            Message = $_.Exception.Message
            URI = $($base_uri + $resource_uri)
        }

    } finally {
        [void] ($RocketCyber_Headers.Remove('Authorization'))
    }

    if ($rest_output){
        $data = @{}
        $data = $rest_output

        [PSCustomObject]@{
            StatusCode = $data.StatusCode
            StatusDescription = $data.StatusDescription
            URI = $($base_uri + $resource_uri)
        }
    }

}