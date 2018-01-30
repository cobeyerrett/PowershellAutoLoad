
function set-profile{
    

Param(
    [Parameter(Mandatory=$true,HelpMessage="The directory of your Autoload files")] 
    [Alias("d")]  
    [string]$location,
    [Parameter(HelpMessage="Append your profile file")]
    [Alias("a")]  
    [string]$append = $true
    
)




try {
    Test-Path $location    
}
catch {
    Write-Host -ForegroundColor Red "Not a valid directroy location"
    exit
}


#Creating new $profile 
if ($append -eq $false) {
    try {
        Remove-Item $profile
    }
    catch {
        Write-Verbose -ForegroundColor Yellow "$profile file does not exist to append"    
    }
    
}


#test if profile file exists, if not create it
if (!(test-path $profile)) {
    
    New-Item $profile -ItemType file -InformationAction SilentlyContinue
    Write-host -ForegroundColor Yellow "New Profile file was created"
}

    'Directory where the Autoload scripts are stored' | Out-File $profile -Append
    '$psdir='+$location | Out-File $profile -Append
    '# load all Autoload scripts' | Out-File $profile -Append
    'Get-ChildItem "${psdir}\*.ps1" | %{.$_}' | Out-File $profile -Append


}




