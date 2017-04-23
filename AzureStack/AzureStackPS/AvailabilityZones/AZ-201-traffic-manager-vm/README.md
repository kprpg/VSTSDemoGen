# Azure Traffic Manager with VM loop distributed across AZs

This template shows how to create an Azure Traffic Manager profile to load-balance across virtual machines.  Each endpoint has an equal weight but different weights can be specified to distribute load non-uniformly.

The accompanying PowerShell script shows how to create a resource group from the template and read back the Traffic Manager profile details.

See also:

- <a href="https://azure.microsoft.com/en-us/documentation/articles/traffic-manager-routing-methods/">Traffic Manager routing methods</a> for details of the different routing methods available.
- <a href="https://msdn.microsoft.com/en-us/library/azure/mt163581.aspx">Create or update a Traffic Manager profile</a> for details of the JSON elements relating to a Traffic Manager profile.