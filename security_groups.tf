##############################################################################
# Change Default Security Group (Optional)
##############################################################################

locals {
      security_group_rules = flatten([
            # Add traffic from inside cidr blocks
            # [
            #       for i in var.cidr_blocks:
            #       {
            #             source    = i
            #             direction = "inbound"
            #       }
            # ],
            var.security_group_rules
      ])
}

resource ibm_is_security_group_rule sg_rules {
      count     = length(local.security_group_rules)
      group     = ibm_is_vpc.vpc.default_security_group
      direction = local.security_group_rules[count.index].direction
      remote    = local.security_group_rules[count.index].source

      ##############################################################################
      # Dynamicaly create ICMP Block
      ##############################################################################

      dynamic icmp {

            # Runs a for each loop, if the rule block contains icmp, it looks through the block
            # Otherwise the list will be empty        

            for_each = (
                  contains(keys(local.security_group_rules[count.index]), "icmp")
                  ? [local.security_group_rules[count.index]]
                  : []
            )
                  # Conditianally add content if sg has icmp
                  content {
                        type = lookup(
                              lookup(
                                    local.security_group_rules[count.index], 
                                    "icmp"
                              ), 
                              "type"
                        )
                        code = lookup(
                              lookup(
                                    local.security_group_rules[count.index], 
                                    "icmp"
                              ), 
                              "code"
                        )
                  }
      } 

      ##############################################################################

      ##############################################################################
      # Dynamically create TCP Block
      ##############################################################################

      dynamic tcp {

            # Runs a for each loop, if the rule block contains tcp, it looks through the block
            # Otherwise the list will be empty     

            for_each = (
                  contains(keys(local.security_group_rules[count.index]), "tcp")
                  ? [local.security_group_rules[count.index]]
                  : []
            )

                  # Conditionally adds content if sg has tcp
                  content {

                        port_min = lookup(
                              lookup(
                                    local.security_group_rules[count.index], 
                                    "tcp"
                              ), 
                              "port_min"
                        )

                        port_max = lookup(
                              lookup(
                                    local.security_group_rules[count.index], 
                                    "tcp"
                              ), 
                              "port_max"
                        )
                  }
      } 

      ##############################################################################

      ##############################################################################
      # Dynamically create UDP Block
      ##############################################################################

      dynamic udp {

            # Runs a for each loop, if the rule block contains udp, it looks through the block
            # Otherwise the list will be empty     

            for_each = (
                  contains(keys(local.security_group_rules[count.index]), "udp")
                  ? [local.security_group_rules[count.index]]
                  : []
            )

                  # Conditionally adds content if sg has tcp
                  content {
                        port_min = lookup(
                              lookup(
                                    local.security_group_rules[count.index], 
                                    "udp"
                              ), 
                              "port_min"
                        )
                        port_max = lookup(
                              lookup(
                                    local.security_group_rules[count.index], 
                                    "udp"
                              ), 
                              "port_max"
                        )
                  }
      } 

      ##############################################################################

}

##############################################################################