function Get-RocketCyberAPIKey {
<#
    .SYNOPSIS
        Gets the RocketCyber API bearer token global variable.

    .DESCRIPTION
        The Get-RocketCyberAPIKey cmdlet gets the RocketCyber API bearer token
        global variable and returns it as a SecureString.

    .PARAMETER PlainText
        Decrypt and return the API key in plain text.

    .EXAMPLE
        Get-RocketCyberAPIKey

        Gets the RocketCyber API bearer token global variable and
        returns it as a SecureString.

    .EXAMPLE
        Get-RocketCyberAPIKey -PlainText

        Gets and decrypts the API key from the global variable and
        returns the API key in plain text

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/RocketCyber-PowerShellWrapper/site/Internal/Get-RocketCyberAPIKey.html
#>

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false)]
        [Switch]$PlainText
    )

    try {
        if ($RocketCyber_API_Key){
            if ($PlainText){
                $Api_Key = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($RocketCyber_API_Key)
                ( [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Api_Key) ).ToString()
                #Write-Output [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Api_Key) -NoEnumerate
            }
            else{$RocketCyber_API_Key}
        }
        else{
            Write-Warning 'The RocketCyber bearer token is not set. Run Add-RocketCyberAPIKey to set the bearer token.'
        }
    }
    catch {
        Write-Error $_
    }
    finally {
        if ($Api_Key) {
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($Api_Key)
        }
    }

}