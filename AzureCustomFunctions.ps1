function Check-ResourceGroup
{        
        [CmdletBinding()]
        [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]
        $ResourceGroupName,
        [string]
        $Location,
        [bool]
        $add = $false
    )
    $ResourceGroups = Get-AzureRmResourceGroup 

    $MatchRgLocation = $ResourceGroups | where { $_.Location -like $Location} | 
                        where {$_.ResourceGroupName -like $ResourceGroupName} 
    if ($MatchRgLocation.Count -eq 0) { 

            $MatchRgLocation = $ResourceGroups | 
                        where {$_.ResourceGroupName -like $ResourceGroupName} 
        if ($MatchRgLocation.Count -eq 0)  {
            Write-Verbose "$ResourceGroupName does not exist" 
            return $false

        } else {
            Write-Verbose "$ResourceGroupName exists in alternative location" 
            return $false
        }
    } else {
    if ($add)  { 
            Write-Verbose "$ResourceGroupName exists in location -Add is set to $true" 
            return $true
        } else {
            Write-Verbose "$ResourceGroupName exists in location -Add is not set" 
            return $false 
        }
    } 
}
