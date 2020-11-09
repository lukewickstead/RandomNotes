# ARM Templates

[toc]

## Overview

- Automate deployments and use the practice of infrastructure as code
- The template is a JavaScript Object Notation (JSON) 
- Declarative syntax; declare the end result
- Repeatable results
- Orchestration is carried out by Azure Resource Manager; you simply declare the end results
- Modularise files into smaller reusable components with parameters
- Extend with deployment scripts; you can add PowerShell or Bash scripts
- You can make sure your template follows recommended guidelines by testing it with the ARM template tool kit
  - https://github.com/Azure/arm-ttk
- Preview changes with the what-of operation
  - https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/template-deploy-what-if
- Built in validatoin
- Tracked deployments via the Azure portal
- Policy as code via Azure Policy
- Use Azure Blueprints as templates
- CI/CD intergration
- When you deploy a template, Resource Manager converts the template into  REST API operations



## Template Sections

- [Parameters](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/template-parameters) - Provide values during deployment that allow the same template to be used with different environments.
- [Variables](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/template-variables) - Define values that are reused in your templates. They can be constructed from parameter values.
- [User-defined functions](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/template-user-defined-functions) - Create customized functions that simplify your template.
- [Resources](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/template-syntax#resources) - Specify the resources to deploy.
- [Outputs](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/template-outputs) - Return values from the deployed resources.



## Template Design

- How you use them is up to you



![three tier template](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/media/overview/3-tier-template.png)





![nested tier template](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/media/overview/nested-tiers-template.png)



![tier template](https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/media/overview/tier-templates.png)



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



## Template Limits

- Limit the size of your template to 4 MB, and each parameter file to  64 KB
- The 4-MB limit applies to the final state of the template after  it has been expanded with iterative resource definitions, and values for variables and parameters

- 256 parameters
- 256 variables
- 800 resources (including copy count)
- 64 output values
- 24,576 characters in a template expression
- You can exceed some template limits by using a nested template



## Template Structure

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "",
  "apiProfile": "",
  "parameters": {  },
  "variables": {  },
  "functions": [  ],
  "resources": [  ],
  "outputs": {  }
}
```



- https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/template-syntax



## Template Specs

- Stored templates inside of Azure instead of a source repository
- If in GitHub the url needs to be publicly available
- Allow sharing templates across teams



```powershell
# Create a template spec
New-AzTemplateSpec -Name storageSpec -Version 1.0 -ResourceGroupName templateSpecsRg -Location westus2 -TemplateFile ./mainTemplate.json

# View all tempaltes in a spec
Get-AzTemplateSpec

# View details of a spec
Get-AzTemplateSpec -ResourceGroupName templateSpecsRG -Name storageSpec

# Deploy a template spec
$id = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/templateSpecsRG/providers/Microsoft.Resources/templateSpecs/storageSpec/versions/1.0"

New-AzResourceGroupDeployment `
  -TemplateSpecId $id `
  -ResourceGroupName demoRG
  
# Typically you will run Get-AzTempalateSoec to get the ID of the temaplte spec you want to deploy
$id = (Get-AzTemplateSpec -Name storageSpec -ResourceGroupName templateSpecsRg -Version 1.0).Versions.Id

New-AzResourceGroupDeployment `
  -ResourceGroupName demoRG `
  -TemplateSpecId $id
```







## Azure Quickstart Templates

- Library of many starting templates for ARM templates
- https://azure.microsoft.com/en-gb/resources/templates



## Sources

- https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates

- https://docs.microsoft.com/en-gb/azure/azure-resource-manager/templates/template-syntax

- https://azure.microsoft.com/en-gb/resources/templates

  