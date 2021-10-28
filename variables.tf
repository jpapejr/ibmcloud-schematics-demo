##############################################################################
# Account Variables
##############################################################################

variable ibmcloud_api_key {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
}

variable unique_id {
    description = "A unique identifier need to provision resources. Must begin with a letter"
    type        = string
    default     = "asset-multizone"
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    type        = string
    default     = "us-east"
}

variable "zone" {
  description = "Availabililty zone to use for instances"
  default     = "us-east-1"
  type        = string
}


variable resource_group {
    description = "Name of resource group to create VPC"
    type        = string
    default     = "asset-development"
}

variable generation {
  description = "generation for VPC. Can be 1 or 2"
  type        = number
  default     = 2
}

##############################################################################


##############################################################################
# Network variables
##############################################################################

variable classic_access {
  description = "Enable VPC Classic Access. Note: only one VPC per region can have classic access"
  type        = bool
  default     = false
}

variable enable_public_gateway {
  description = "Enable public gateways for subnets, true or false"
  type        = bool
  default     = true
}

variable security_group_rules {
  description = "List of security group rules for default VPC security group"
  default     = [
    {
      source    = "0.0.0.0/0"
      direction = "inbound"
    }
  ]
}

##############################################################################


##############################################################################
# Tier 1 Subnet Variables
##############################################################################

variable tier_1_cidr_blocks {
  description = "A list of tier 1 subnet IPs"
  type        = list(string)
  default     = [
    "172.16.10.128/27", 
    "172.16.30.128/27", 
    "172.16.50.128/27"
  ] 
}

variable tier_1_acl_rules {
  description = "Access control list rule set for tier 1 subnets"
  default = [
    {
      name        = "allow-all-inbound"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "inbound"
    },
    {
      name        = "allow-all-outbound"
      action      = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "outbound"
    }
  ]
}

##############################################################################


##############################################################################
# Instance variables 
##############################################################################
variable "publickey" {
  description = "Public SSH Key to use on instances"
  type        = string
}

variable "image" {
  description = "Instance image ID to use - ibmcloud is images to list available choices"
  type        = string
}

variable "profile" {
  description = "Instance profile to use, e.g. bx2.2x8" 
  type        = string
  default     = "bx2.2x8"
}
##############################################################################
