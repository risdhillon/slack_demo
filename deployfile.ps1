$gitrepo           = 'https://github.com/risdhillon/slack_demo.git'
$gittoken          = 'dd5d5a8009913e31af40dbfb680a55f83ccc5ff6'
$webappname        = 'demositerd'
$location          = 'West Europe'
$resourcegroupName = 'demositerd'

# Create a resource group.
if(-not (Get-AzureRmResourceGroup -Name demositerd -Location $location)){
    New-AzureRmResourceGroup -Name demositerd -Location $location
}
else{
    Write-Verbose -Message 'Resource group "demositerd" already present' -Verbose
}

# Create an App Service plan in Free tier.
if(-not (Get-AzureRmAppServicePlan -Name $webappname -ResourceGroupName $resourcegroupName)){
    New-AzureRmAppServicePlan -Name $webappname -Location $location -ResourceGroupName $resourcegroupName -Tier Free
}
else{
    Write-Verbose -Message "App Service plan for $webappname already present" -Verbose
}

# Create a web app.
if(-not (Get-AzureRmWebApp -Name $webappname -ResourceGroupName $resourcegroupName)){
    New-AzureRmWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName demositerd
}
else{
    Write-Verbose -Message "Webapp $webappname already deployed" -Verbose
}

# SET GitHub
$PropertiesObject = @{token = $token;}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceId /providers/Microsoft.Web/sourcecontrols/GitHub -ApiVersion 2015-08-01 -Force

# Configure GitHub deployment from your GitHub repo and deploy once.
$PropertiesObject = @{repoUrl = "$gitrepo"; branch = "master";}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName demositerd -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force
