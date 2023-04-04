function Invoke-APIRequest {
<#
    .SYNOPSIS
        Makes an API request

    .DESCRIPTION
        The Invoke-ApiRequest cmdlet invokes an API request to RocketCyber API.

        This is an internal function that is used by all public functions

        As of 2023-03 the RocketCyber v3 API only supports GET requests

    .PARAMETER method
        Defines the type of API method to use

        Allowed values:
        'GET'

    .PARAMETER resource_Uri
        Defines the resource uri (url) to use when creating the API call

    .PARAMETER uri_Filter
        Used with the internal function [ ConvertTo-QueryString ] to combine
        a functions parameters with the resource_Uri parameter.

        This allows for the full uri query to occur

        The full resource path is made with the following data
        $RocketCyber_Base_URI + $resource_Uri + ConvertTo-QueryString

    .PARAMETER data
        Place holder parameter to use when other methods are supported
        by the RocketCyber v3 API

    .PARAMETER allPages
        Returns all items from an endpoint

    .EXAMPLE
        Invoke-ApiRequest -method GET -resource_Uri '/account' -uri_Filter $uri_Filter

        Invoke a rest method against the defined resource using any of the provided parameters

        Example:
            Name                           Value
            ----                           -----
            Method                         GET
            Uri                            https://api-us.rocketcyber.com/v3/account?accountId=12345&details=True
            Headers                        {Authorization = Bearer 123456789}
            Body


    .NOTES
        N\A

    .LINK
        https://celerium.github.io/RocketCyber-PowerShellWrapper/site/Internal/Invoke-APIRequest.html

#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateSet('GET')]
        [String]$method = 'GET',

        [Parameter(Mandatory = $true)]
        [String]$resource_Uri,

        [Parameter(Mandatory = $false)]
        [Hashtable]$uri_Filter = $null,

        [Parameter(Mandatory = $false)]
        [Hashtable]$data = $null,

        [Parameter(Mandatory = $false)]
        [Switch]$allPages

    )

    begin{}

    process{

        $query_string = ConvertTo-QueryString -uri_Filter $uri_Filter -resource_Uri $resource_Uri

        Set-Variable -Name 'RocketCyber_queryString' -Value $query_string -Scope Global -Force

        if ($null -eq $data) {
            $body = $null
        } else {
            $body = @{'data'= $data} | ConvertTo-Json -Depth $RocketCyber_JSON_Conversion_Depth
        }

        try {
            $Api_Token = Get-RocketCyberAPIKey -PlainText

            $parameters = [ordered] @{
                "Method"    = $method
                "Uri"       = $query_string.Uri
                "Headers"   = @{ 'Authorization' = 'Bearer {0}' -f $Api_Token }
                "Body"      = $body
            }
            Set-Variable -Name 'RocketCyber_invokeParameters' -Value $parameters -Scope Global -Force

            if ($allPages){

                Write-Verbose "Gathering all items from [  $( $RocketCyber_Base_URI + $resource_Uri ) ] "

                $page_number = 1
                $all_responseData = [System.Collections.Generic.List[object]]::new()

                do {

                    Write-Verbose "[ $page_number ] of [ $($current_page.totalPages) ] pages"

                    $parameters['Uri'] = $query_string.Uri -replace 'page=\d+',"page=$page_number"

                    $current_page = Invoke-RestMethod @parameters -ErrorAction Stop

                        foreach ($item in $current_page.data){
                            $all_responseData.add($item)
                        }

                    $page_number++

                } while ($current_page.totalPages -ne $page_number - 1 -and $current_page.totalPages -ne 0)

            }
            else{
                $api_response = Invoke-RestMethod @parameters -ErrorAction Stop
            }

        }
        catch {

            $exceptionError = $_.Exception.Message
            Write-Warning 'The [ RocketCyber_invokeParameters, RocketCyber_queryString, & RocketCyber_CmdletNameParameters ] variables can provide extra details'

            switch -Wildcard ($exceptionError) {
                '*404*' { Write-Error "Invoke-ApiRequest : [ $resource_Uri ] not found!" }
                '*429*' { Write-Error 'Invoke-ApiRequest : API rate limited' }
                '*504*' { Write-Error "Invoke-ApiRequest : Gateway Timeout" }
                default { Write-Error $_ }
            }

        }
        finally {
            [void] ( $RocketCyber_Headers.Remove('Authorization') )
        }


        if($allPages){

            #Making output consistent
            if( [string]::IsNullOrEmpty($all_responseData.data) ){
                $api_response = $null
            }
            else{
                $api_response = [PSCustomObject]@{
                    data = $all_responseData
                }
            }

            return $api_response

        }
        else{ return $api_response }

    }

    end{}

}