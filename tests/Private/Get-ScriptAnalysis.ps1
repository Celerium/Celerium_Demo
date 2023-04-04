#Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force

BeforeAll{

    Import-Module -Name PSScriptAnalyzer

}


BeforeDiscovery{

    $analysis = Invoke-ScriptAnalyzer -Path  (Resolve-Path "C:\Celerium\Projects\_API\RocketCyber-PowerShellWrapper\RocketCyberAPI\Private")

}

Describe 'Testing against PSSA rules' {

    Context 'PSSA Standard Rules' {

        #$analysis = Invoke-ScriptAnalyzer -Path  (Resolve-Path "C:\Celerium\Projects\_API\RocketCyber-PowerShellWrapper\RocketCyberAPI\Private")

        $scriptAnalyzerRules = Get-ScriptAnalyzerRule

        forEach ($rule in $scriptAnalyzerRules) {

            It "Should pass $rule" {

                If ($analysis.RuleName -contains $rule.RuleName) {

                    $analysis | Where-Object {$_.RuleName -eq $Rule.RuleName} -OutVariable failures | Out-Default

                    $failures.Count | Should -Be 0

                }

            }

        }

    }

}