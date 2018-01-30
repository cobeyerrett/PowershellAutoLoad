function create-resourceGroup
{
    Param(
    [Parameter(Mandatory=$true)]   
    [string]$subscription,
    [Parameter(Mandatory=$true)]   
    [string]$projectName,
    [Parameter(Mandatory=$true)]   
    [string]$projectOwner,
    [Parameter(Mandatory=$true)]   
    [string]$pe,
    [string]$location="canadaeast"
    )
    
    #Defines the Resource Group Name 
    $num = 1
    

    try {
        $sub = Get-AzureRmSubscription -SubscriptionName $subscription -ErrorAction Stop   
        Set-AzureRmContext -Subscription $sub -ErrorAction Stop
    }
    catch {
        Write-Host "No Such Subscription found" -ForegroundColor Yellow
        exit
    }
    
    $created = $false    

    while (!$created) {
        $rg_name = "$projectName$num-$subscription-rg"
        if (!(Check-ResourceGroup -ResourceGroupName $rg_name -Location $location)) {
            Write-Host -ForegroundColor Yellow "The RG does not exist.  Creating"
            New-AzureRmResourceGroup -Name $rg_name -Location $location -Tag @{Billto=$pe;ProjectName=$projectName;ProjectOwner=$projectOwner}
            $created = $true
        }
        else {
            Write-Host -ForegroundColor Yellow "The RG $rg_name exists"
            $num+=1
        }
    }
    
}
