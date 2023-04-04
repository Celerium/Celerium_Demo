function Import-RocketCyberModuleSettings {
<#
    .SYNOPSIS
        Imports the RocketCyber BaseURI, API, & JSON configuration information to the current session.

    .DESCRIPTION
        The Import-RocketCyberModuleSettings cmdlet imports the RocketCyber BaseURI, API, & JSON configuration
        information stored in the RocketCyber configuration file to the users current session.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\RocketCyberAPI

    .PARAMETER RocketCyberConfPath
        Define the location to store the RocketCyber configuration file.

        By default the configuration file is stored in the following location:
            $env:USERPROFILE\RocketCyberAPI

    .PARAMETER RocketCyberConfFile
        Define the name of the RocketCyber configuration file.

        By default the configuration file is named:
            config.psd1

    .EXAMPLE
        Import-RocketCyberModuleSettings

        Validates that the configuration file created with the Export-RocketCyberModuleSettings cmdlet exists
        then imports the stored data into the current users session.

        The default location of the RocketCyber configuration file is:
            $env:USERPROFILE\RocketCyberAPI\config.psd1

    .EXAMPLE
        Import-RocketCyberModuleSettings -RocketCyberConfPath C:\RocketCyberAPI -RocketCyberConfFile MyConfig.psd1

        Validates that the configuration file created with the Export-RocketCyberModuleSettings cmdlet exists
        then imports the stored data into the current users session.

        The location of the RocketCyber configuration file in this example is:
            C:\RocketCyberAPI\MyConfig.psd1

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/RocketCyber-PowerShellWrapper/site/Internal/Import-RocketCyberModuleSettings.html
#>

    [CmdletBinding(DefaultParameterSetName = 'set')]
    Param (
        [Parameter(Mandatory = $false, ParameterSetName = 'set')]
        [string]$RocketCyberConfPath = "$($env:USERPROFILE)\RocketCyberAPI",

        [Parameter(Mandatory = $false, ParameterSetName = 'set')]
        [string]$RocketCyberConfFile = 'config.psd1'
    )

    if( test-path ($RocketCyberConfPath+"\"+$RocketCyberConfFile) ) {
        $tmp_config = Import-LocalizedData -BaseDirectory $RocketCyberConfPath -FileName $RocketCyberConfFile

            # Send to function to strip potentially superfluous slash (/)
            Add-RocketCyberBaseURI $tmp_config.RocketCyber_Base_URI

            $tmp_config.RocketCyber_API_key = ConvertTo-SecureString $tmp_config.RocketCyber_API_key

            Set-Variable -Name 'RocketCyber_Base_URI' -Value $tmp_config.RocketCyber_Base_URI -Option ReadOnly -Scope global -Force

            Set-Variable -Name 'RocketCyber_API_Key' -Value $tmp_config.RocketCyber_API_key -Option ReadOnly -Scope global -Force

            Set-Variable -Name 'RocketCyber_JSON_Conversion_Depth' -Value $tmp_config.RocketCyber_JSON_Conversion_Depth -Scope global -Force

        Write-Verbose "The RocketCyberAPI Module configuration loaded successfully from [ $RocketCyberConfPath\$RocketCyberConfFile ]"

        # Clean things up
        Remove-Variable "tmp_config"
    }
    else {
        Write-Verbose "No configuration file found at [ $RocketCyberConfPath\$RocketCyberConfFile ] run Add-RocketCyberAPIKey & Add-RocketCyberBaseURI to get started."

        Set-Variable -Name 'RocketCyber_JSON_Conversion_Depth' -Value 100 -Scope global -Force
    }
}