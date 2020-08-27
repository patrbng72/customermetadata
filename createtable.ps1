Connect-AzAccount

$subscriptionName = "Puebla Cloud Team Lab"

Select-AzSubscription -Subscription $subscriptionName

$resourcegroup = "stxcustmetadata"
$storageaccount = "stxcustmetadata"

$storageaccountkey = (Get-AzStorageAccountKey -ResourceGroupName $resourcegroup -Name $storageaccount)[0].Value
$ctx = New-AzStorageContext -StorageAccountName $storageaccount -StorageAccountKey $storageaccountkey

$tablename = "maintable"
New-AzStorageTable -Name $tableName -Context $ctx

# $SAS = New-AzStorageAccountSASToken -Service Table -ResourceType Container,Service,Object -StartTime (Get-Date) -ExpiryTime (Get-Date).AddHours(6) -Context $ctx -Permission 'rwdlau'

$cloudtable = (Get-AzStorageTable -Name $tablename -Context $ctx).CloudTable
Add-AzTableRow -Table $cloudtable -PartitionKey 'main' -RowKey ((New-Guid).Guid) -property @{ Result = 'Success'; Source = 'PipeHow' }
Add-AzTableRow -Table $cloudtable -PartitionKey 'subscription' -RowKey ((New-Guid).Guid) -property @{ Result = 'Failure'; Source = 'PipeHow' }