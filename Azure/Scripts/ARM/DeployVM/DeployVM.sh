resource_group=$(az group list --query '[0].name'  | tr -d '"')


az deployment group create --resource-group $resource_group --template-file template.json --parameters @template.parameters.json
