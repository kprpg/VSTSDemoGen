## Demo for DSC, sinpi used for DSC in Azure Automation
## This configuration file can be imported into an Azure Automation - DSC config 
## and then executed against appropriate nodes (VMs discovered in the DSC Node in Az Automation)
## It has hard coded a Node name "TEST-PC1" but can be removed to make it work against an input
## of nodes that specifies multiple VMs
Configuration MyDscConfiguration {

    Node "TEST-PC1" {
        WindowsFeature MyFeatureInstance {
            Ensure = "Present"
            Name =  "RSAT"
        }
        WindowsFeature My2ndFeatureInstance {
            Ensure = "Present"
            Name = "Bitlocker"
        }
       
    }
} 

MyDscConfiguration 