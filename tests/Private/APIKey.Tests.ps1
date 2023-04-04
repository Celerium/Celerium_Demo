<#
    .SYNOPSIS
        Pester tests for functions in the "APIKey.ps1" file

    .DESCRIPTION
        Pester tests for functions in the APIKey.ps1 file which
        is apart of the RocketCyberAPI module.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\APIKey.Tests.ps1

        Runs a pester test against "APIKey.Tests.ps1" and outputs simple test results.

    .EXAMPLE
        Invoke-Pester -Path .\Tests\APIKey.Tests.ps1 -Output Detailed

        Runs a pester test against "APIKey.Tests.ps1" and outputs detailed test results.

    .NOTES
        Build out more robust, logical, & scalable pester tests.
        Look into BeforeAll as it is not working as expected with this test

    .LINK
        https://github.com/Celerium/RocketCyber-PowerShellWrapper
#>
#Requires -Version 5.0
#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.4.0' }

#Available in Discovery & Run
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$ModuleName = 'RocketCyberAPI',

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$ModulePath = "C:\Celerium\Projects\_API\RocketCyber-PowerShellWrapper",

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String[]]$FunctionPath,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [String]$Api_Key = 'FakeAPIKey12345x'
    )

#Available inside It but not Describe or Context
BeforeAll{

    Import-Module -Name "$ModulePath\$ModuleName" -Force

    Function Mock-ReadHost {
        return (Read-Host -Prompt 'Please enter your API key')
    }

    #$pester_TestName = (Get-Item -Path $PSCommandPath).Name

    #if ($Api_Key){  $Api_Key = Add-RocketCyberAPIKey -Api_Key $Api_Key}
    #else{           $Api_Key = 'FakeAPIKey12345x'}

}

#Available in Describe and Context but NOT It
#Cannot be used in It without [ -TestCases @{ VariableName = $VariableName } ]
BeforeDiscovery{

    $pester_TestName = (Get-Item -Path $PSCommandPath).Name

}

Describe "Testing [ Add-RocketCyberAPIKey ] function" -Tag Add {

    <#
    Context "[ Add-RocketCyberAPIKey ] TESTING VARIABLES" -Tag TESTONLY  {

        It "IT variable pass from BeforeDiscovery #1 NoTestCase [ $pester_TestName ]" {
            Write-Host "NoTestCase NAME [ $pester_TestName ]"
            Write-Host "NoTestCase API [ $Api_Key ]"
            $Api_Key | Should -Be 'FakeAPIKey12345x'
        }

        It "IT variable pass from BeforeDiscovery #2 TestCase [ $pester_TestName ]" -TestCases @{ Api_Key = $Api_Key } {
            Write-Host "TestCase [ $Api_Key ]"
            $Api_Key | Should -Be 'FakeAPIKey12345x'
        }

    }
    #>

    Context "[ Add-RocketCyberAPIKey ] mocking function"  {

        BeforeAll {
            Mock Read-Host {return 'Please enter your API key'} -Verifiable
            $results_ReadHost = Mock-ReadHost
        }

        It "[ Add-RocketCyberAPIKey ] mocked Read-Host should ask for API key" {
            $results_ReadHost | Should -Be 'Please enter your API key'
        }

        It "[ Add-RocketCyberAPIKey ] mocked Read-Host should not return a different value" {
            $results_ReadHost | Should -Not -Be 'Do not enter your Api Key'
        }

        It "[ Add-RocketCyberAPIKey ] mocked Read-Host should only be mocked 1 times" {
            Should -Invoke Read-Host -Times 1 -Scope Context
        }

    }

    Context "[ Add-RocketCyberAPIKey ] testing function parameters"  {

        It "[ Add-RocketCyberAPIKey ] should accept a value from the pipeline" {
            $Api_Key | Add-RocketCyberAPIKey
            Get-RocketCyberAPIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Add-RocketCyberAPIKey ] called with parameter -API_Key should not be empty" {
            Add-RocketCyberAPIKey -Api_Key $Api_Key
            Get-RocketCyberAPIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Add-RocketCyberAPIKey ] the RocketCyber_API_Key variable should exist" {
            $Api_Key | Add-RocketCyberAPIKey
            [bool](Get-Variable -Name 'RocketCyber_API_Key') | Should -BeTrue
        }

    }

}

Describe "Testing [ Get-RocketCyberAPIKey ] functions with [ $pester_TestName ]" -Tag Get {

    Context "[ Get-RocketCyberAPIKey ] testing functions" {

        It "[ Get-RocketCyberAPIKey ] should return a value" {
            $Api_Key | Add-RocketCyberAPIKey
            Get-RocketCyberAPIKey | Should -Not -BeNullOrEmpty
        }

        It "[ Get-RocketCyberAPIKey ] should be a SecureString (From PipeLine)" {
            $Api_Key | Add-RocketCyberAPIKey
            Get-RocketCyberAPIKey | Should -BeOfType SecureString
        }

        It "[ Get-RocketCyberAPIKey ] should be a SecureString (With Parameter)" {
            Add-RocketCyberAPIKey -Api_Key $Api_Key
            Get-RocketCyberAPIKey | Should -BeOfType SecureString
        }

        It "[ Get-RocketCyberAPIKey ] with [ -PlanText ]should be a string" {
            $Api_Key | Add-RocketCyberAPIKey
            Get-RocketCyberAPIKey -PlainText | Should -BeOfType String
        }

    }

}

Describe "Testing [ Remove-RocketCyberAPIKey ] functions with [ $pester_TestName ]" -Tag Remove {

    Context "[ Remove-RocketCyberAPIKey ] testing functions" {

        It "[ Remove-RocketCyberAPIKey ] should remove the RocketCyber_API_Key variable" {
            Add-RocketCyberAPIKey -Api_Key $Api_Key
            Remove-RocketCyberAPIKey
            $RocketCyber_API_Key | Should -BeNullOrEmpty
        }
    }

}

Describe "Testing [ Test-RocketCyberAPIKey ] functions with [ $pester_TestName ]" -Tag Test {

    Context "[ Test-RocketCyberAPIKey ] testing functions" {

        It "[ Test-RocketCyberAPIKey ] without an API key should fail to authenticate" {
            Remove-RocketCyberAPIKey -WarningAction SilentlyContinue
            $Value = Test-RocketCyberAPIKey -WarningAction SilentlyContinue
            $Value.Message | Should -BeLike '*(401) Unauthorized*'
        }

        It "[ Test-RocketCyberAPIKey ] without an API key should fail to authenticate" {
            Remove-RocketCyberAPIKey -WarningAction SilentlyContinue
            $Value = Test-RocketCyberAPIKey -WarningAction SilentlyContinue
            $Value.Message | Should -BeLike '*(401) Unauthorized*'
        }

    }

}


AfterAll{

    Remove-Module -Name $ModuleName -Force

}