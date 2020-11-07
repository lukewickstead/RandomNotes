#  List all of the Azure CLI Cosmos DB commands available:
az cosmosdb -h

# List the Cosmos DB account names and resource groups in table output format:
az cosmosdb list --output table --query '[].{Name: name, ResourceGroup: resourceGroup}'

# Read the account name and resource group into shell variables:
read account resource_group <<< $(!! | tail -1)

# List the databases in the account:

az cosmosdb database list --name $account --resource-group-name $resource_group \
                          -o table --query [].id

# List the arguments available for creating a collection:
az cosmosdb mongodb collection create -h

# Create a ticker collection to store stock ticker data:
az cosmosdb mongodb collection create --database-name stocks --name ticker --account-name $account --resource-group $resource_group

# List the available arguments to the collection update command:
az cosmosdb mongodb collection update -h

# List cosmos dbs
az cosmosdb list

# Enter the following to trigger a manual failover to the East US region:
az cosmosdb failover-priority-change --failover-policies eastus=0 westus=1 \
                                     --resource-group $resource_group --name $account