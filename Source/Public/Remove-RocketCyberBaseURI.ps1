function Remove-RocketCyberBaseURI {
<#
    .SYNOPSIS
        Removes the RocketCyber base URI global variable.

    .DESCRIPTION
        The Remove-RocketCyberBaseURI cmdlet removes the RocketCyber base URI global variable.

    .EXAMPLE
        Remove-RocketCyberBaseURI

        Removes the RocketCyber base URI global variable.

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/RocketCyber-PowerShellWrapper/site/Internal/Remove-RocketCyberBaseURI.html
#>

    [cmdletbinding(SupportsShouldProcess)]
    Param ()

    if ($RocketCyber_Base_URI) {
        Remove-Variable -Name "RocketCyber_Base_URI" -Scope global -Force -WhatIf:$WhatIfPreference
    }
    Else{
        Write-Warning "The RocketCyber base URI variable is not set. Nothing to remove"
    }
}