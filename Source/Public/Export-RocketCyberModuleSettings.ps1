function Export-RocketCyberModuleSettings {
<#
    .SYNOPSIS
        Exports the RocketCyber BaseURI, API, & JSON configuration information to file.

    .DESCRIPTION
        The Export-RocketCyberModuleSettings cmdlet exports the RocketCyber BaseURI, API, & JSON configuration information to file.

        Making use of PowerShell's System.Security.SecureString type, exporting module settings encrypts your API key in a format
        that can only be unencrypted with the your Windows account as this encryption is tied to your user principal.
        This means that you cannot copy your configuration file to another computer or user account and expect it to work.

    .PARAMETER RocketCyberConfPath
        Define the location to store the RocketCyber configuration file.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\RocketCyberAPI

    .PARAMETER RocketCyberConfFile
        Define the name of the RocketCyber configuration file.

        By default the configuration file is named:
            config.psd1

    .EXAMPLE
        Export-RocketCyberModuleSettings

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's RocketCyber configuration file located at:
            $env:USERPROFILE\RocketCyberAPI\config.psd1

    .EXAMPLE
        Export-RocketCyberModuleSettings -RocketCyberConfPath C:\RocketCyberAPI -RocketCyberConfFile MyConfig.psd1

        Validates that the BaseURI, API, and JSON depth are set then exports their values
        to the current user's RocketCyber configuration file located at:
            C:\RocketCyberAPI\MyConfig.psd1

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/RocketCyber-PowerShellWrapper/site/Internal/Export-RocketCyberModuleSettings.html
#>

    [CmdletBinding(DefaultParameterSetName = 'set')]
    Param (
        [Parameter(Mandatory = $false, ParameterSetName = 'set')]
        [string]$RocketCyberConfPath = "$($env:USERPROFILE)\RocketCyberAPI",

        [Parameter(Mandatory = $false, ParameterSetName = 'set')]
        [string]$RocketCyberConfFile = 'config.psd1'
    )

    # Confirm variables exist and are not null before exporting
    if ($RocketCyber_Base_URI -and $RocketCyber_API_Key -and $RocketCyber_JSON_Conversion_Depth) {
        $secureString = $RocketCyber_API_KEY | ConvertFrom-SecureString
        New-Item -Path $RocketCyberConfPath -ItemType Directory -Force | ForEach-Object {$_.Attributes = 'hidden'}
@"
    @{
        RocketCyber_Base_URI = '$RocketCyber_Base_URI'
        RocketCyber_API_Key = '$secureString'
        RocketCyber_JSON_Conversion_Depth = '$RocketCyber_JSON_Conversion_Depth'
    }
"@ | Out-File -FilePath ($RocketCyberConfPath+"\"+$RocketCyberConfFile) -Force

    }
    else {
        Write-Error "Failed to export RocketCyber Module settings to [ $RocketCyberConfPath\$RocketCyberConfFile ]"
    }
}