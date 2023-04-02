

function Write-HelloWorld {

<#
    .SYNOPSIS
        Writes a message to the console

    .DESCRIPTION
        The Add-S1APIKey cmdlet writes a message to the console

        This message will appear either green or red

    .PARAMETER Message
        Writes a message to the console

    .EXAMPLE
        Write-HelloWorld -Message "This is my message"

        Writes the defined value to the console

    .NOTES
        N\A

    .LINK
        https://celerium.github.io/urban-fortnight/

#>

    [CmdletBinding()]
    param (
        [String]$Message
    )

    process {

        if($Message){
            Write-Host $Message -ForegroundColor Green
        }
        else{
            Write-Host "The message parameter was not defined" -ForegroundColor Red
        }

    }

    end {

    Write-Host 'This is an end block' -ForegroundColor Cyan

    }


}