# Networking with VMSS example

This folder contains a [Terraform](https://www.terraform.io/) configuration that shows an example of how to 
use the [networking vmss module](../../modules/cluster/networking/vmss) to deploy a load balancer with a virtual network and address pool (using [LB](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview?ranMID=46131&ranEAID=a1LgFw09t88&ranSiteID=a1LgFw09t88-GIoZR64RuMhQODEgYac0Ow&epi=a1LgFw09t88-GIoZR64RuMhQODEgYac0Ow&irgwc=1&OCID=AIDcmm549zy227_aff_7806_1243925&tduid=(ir__zxauau1uv0kfbnioa3lqijsqqv2xbevgg60ln1pv00)(7806)(1243925)(a1LgFw09t88-GIoZR64RuMhQODEgYac0Ow)()) and [Azure VNet](hhttps://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)) in an [Azure Account](https://portal.azure.com/). 


## Pre-requisites

* You must have [Terraform](https://www.terraform.io/) installed on your computer. 
* You must have an [Azure Account](https://portal.azure.com/).

Please note that this code was written for Terraform 1.x and up.

## Quick start

**Please note that this example will deploy real resources into your Azure account. We have made every effort to ensure 
all the resources qualify for the [Azure Free Tier](https://azure.microsoft.com/en-in/pricing/free-services/), but we are not responsible for any charges you may incur.** 

Configure your [Azure Service Principal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secrets) as recomended by Hashicorp and use the following environment variables to setup the environment:

```
export ARM_CLIENT_ID="<your-sp-app-id>"
export ARM_CLIENT_SECRET="<your-sp-secret>"
export ARM_TENANT_ID="<your-tenant-id>"
export ARM_SUBSCRIPTION_ID="<your-subscription-id>"
```

Deploy the code:

```
terraform init
terraform apply
```

Clean up when you're done:

```
terraform destroy
```