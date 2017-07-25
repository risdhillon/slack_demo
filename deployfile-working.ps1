$gitrepo="https://github.com/risdhillon/slack_demo.git"
$gittoken="dd5d5a8009913e31af40dbfb680a55f83ccc5ff6"
$webappname="demositerd"
$location="West Europe"

# Create a resource group.
New-AzureRmResourceGroup -Name demositerd -Location $location

# Create an App Service plan in Free tier.
New-AzureRmAppServicePlan -Name $webappname -Location $location -ResourceGroupName demositerd -Tier Free

# Create a web app.
New-AzureRmWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName demositerd

# SET GitHub
$PropertiesObject = @{token = $token;}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceId /providers/Microsoft.Web/sourcecontrols/GitHub -ApiVersion 2015-08-01 -Force

# Configure GitHub deployment from your GitHub repo and deploy once.
$PropertiesObject = @{repoUrl = "$gitrepo"; branch = "master";}
Set-AzureRmResource -PropertyObject $PropertiesObject -ResourceGroupName demositerd -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force
