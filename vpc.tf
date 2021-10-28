##############################################################################
# This file creates the VPC, Zones, subnets and public gateway for the VPC
# a separate file sets up the load balancers, listeners, pools and members
##############################################################################


##############################################################################
# Create a VPC
##############################################################################

resource ibm_is_vpc vpc {
  name           = "${var.unique_id}-vpc"
  resource_group = data.ibm_resource_group.resource_group.id
  classic_access = var.classic_access
}

##############################################################################


##############################################################################
# Public Gateways (Optional)
##############################################################################

resource ibm_is_public_gateway gateway {
  name           = "${var.unique_id}-gateway-1"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = data.ibm_resource_group.resource_group.id
  zone           = "${var.zone}"
}

##############################################################################


##############################################################################
# Tier 1 Subnets
##############################################################################

module tier_1_subnets {
  source            = "./module_vpc_tier" 
  ibm_region        = var.ibm_region 
  unique_id         = "${var.unique_id}-sn-1"                      
  acl_rules         = var.tier_1_acl_rules
  cidr_blocks       = var.tier_1_cidr_blocks
  vpc_id            = ibm_is_vpc.vpc.id
  resource_group_id = data.ibm_resource_group.resource_group.id
  public_gateways   = ibm_is_public_gateway.gateway.*.id
}

##############################################################################
