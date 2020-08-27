Connect-AzAccount

$subscriptionName = "Puebla Cloud Team Lab"

Select-AzSubscription -Subscription $subscriptionName

$resourcegroup = "stxcustmetadata"
$storageaccount = "stxcustmetadata"

$ctx = Get-AzStorageAccount -ResourceGroupName $resourcegroup -Name $storageaccount

$tableName = "main_table"
New-AzStorageTable -Name $tableName -Context $ctx