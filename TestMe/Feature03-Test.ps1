function Add-TestMeAPIKey {

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [Alias('ApiKey')]
        [string]$Api_Key
    )

    if ($Api_Key) {
        Set-Variable -Name "TestMe_API_Key" -Value $x_api_key -Option ReadOnly -Scope global -Force
    }
    else {
        Write-Host "Please enter your API key:"
        $x_api_key = Read-Host -AsSecureString

        Set-Variable -Name "TestMe_API_Key" -Value $x_api_key -Option ReadOnly -Scope global -Force
    }
}

function Add-TestMeAPIKeys {

    [cmdletbinding()]
    Param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [Alias('ApiKey')]
        [string]$Api_Key
    )

    if ($Api_Key) {
        Set-Variable -Name "TestMe_API_Key" -Value $x_api_key -Option ReadOnly -Scope global -Force
    }
    else {
        Write-Host "Please enter your API key:"
        $x_api_key = Read-Host -AsSecureString

        Set-Variable -Name "TestMe_API_Key" -Value $x_api_key -Option ReadOnly -Scope global -Force
    }
}


function Get-TestMeAPIKey {

    [cmdletbinding()]
    Param ()

    if ($TestMe_API_Key){
        $TestMe_API_Key
    }
    Else{
        Write-Host "The TestMe API key is not set. Run Add-TestMeAPIKey to set the API key." -ForegroundColor Yellow
    }
}

function Remove-TestMeAPIKey {

    [cmdletbinding()]
    Param ()

    if ($TestMe_API_Key) {
        Remove-Variable -Name "TestMe_API_Key" -Scope global -Force
    }
    Else{
        Write-Host "The TestMe API key variable is not set. Nothing to remove" -ForegroundColor Yellow
    }
}

function Test-TestMeAPIKey {

    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipeline)]
        [string]$base_uri = $TestMe_Base_URI
    )

    try {
        $resource_uri = '/clients'

        $TestMe_Headers.Add('mitp-api-key', (New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'N/A', $TestMe_API_Key).GetNetworkCredential().Password)
        $rest_output = Invoke-WebRequest -method 'GET' -uri ($base_uri + $resource_uri) -headers $TestMe_Headers -ErrorAction Stop
    }
    catch {

        [PSCustomObject]@{
            Method = $_.Exception.Response.Method
            StatusCode = $_.Exception.Response.StatusCode.value__
            StatusDescription = $_.Exception.Response.StatusDescription
            Message = $_.Exception.Message
            URI = $($TestMe_Base_URI + $resource_uri)
        }

    } finally {
        [void] ($TestMe_Headers.Remove('mitp-api-key'))
    }

    if ($rest_output){
        $data = @{}
        $data = $rest_output

        [PSCustomObject]@{
            StatusCode = $data.StatusCode
            StatusDescription = $data.StatusDescription
            URI = $($TestMe_Base_URI + $resource_uri)
        }
    }
}


New-Alias -Name Set-TestMeAPIKey -Value Add-TestMeAPIKey -Force