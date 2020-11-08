# ARM Templates



##  Test and deploy an ARM template with PowerShell



```powershell
# Loging
Add-AzureRmAccount

# Next you can create the resource group
New-AzureRmResourceGroup -Name ExampleResourceGroup -Location "West US"

# Test deployment
Test-AzureRmResourceGroupDeployment -ResourceGroupName ExampleResourceGroup -TemplateFile <PathToTemplate>

# Then you can actually deploy the resource group
New-AzureRmResourceGroupDeployment -Name ExampleDeployment -ResourceGroupName ExampleResourceGroup -TemplateFile <PathToTemplate> -TemplateParameterFile <PathToTemplateParams>
```



## Sources

- https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates

- https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/

  