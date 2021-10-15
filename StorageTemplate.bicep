param storageAccounts_bicepstoragetemplate_name string  
@allowed([
  'Premium_LRS' 
  'Premium_ZRS' 
  'Standard_GRS' 
  'Standard_GZRS' 
  'Standard_LRS' 
  'Standard_RAGRS' 
  'Standard_RAGZRS' 
  'Standard_ZRS'
])
param skuname string  

resource storageAccounts_bicepstoragetemplate_name_resource 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccounts_bicepstoragetemplate_name
  location: 'eastus'
  sku: {
    name: skuname
  
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_bicepstoragetemplate_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  parent: storageAccounts_bicepstoragetemplate_name_resource
  name: 'default'

  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_bicepstoragetemplate_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-04-01' = {
  parent: storageAccounts_bicepstoragetemplate_name_resource
  name: 'default'
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_bicepstoragetemplate_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-04-01' = {
  parent: storageAccounts_bicepstoragetemplate_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_bicepstoragetemplate_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-04-01' = {
  parent: storageAccounts_bicepstoragetemplate_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}
