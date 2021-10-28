resource "ibm_is_ssh_key" "sshkey" {
  name       = "mykey"
  public_key = var.publickey
}


resource "ibm_is_instance" "instance1" {
  name    = "${var.unique_id}-instance1"
  image   = "${var.image}"
  profile = "${var.profile}"
  resource_group = data.ibm_resource_group.resource_group.id


  primary_network_interface {
    subnet = module.tier_1_subnets.subnet_ids[0] 
    name   = "eth0"
    allow_ip_spoofing = false
  }

  vpc  = ibm_is_vpc.vpc.id
  zone = "${var.zone}"
  keys = [ibm_is_ssh_key.sshkey.id]

  //User can configure timeouts
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "ibm_is_instance" "instance2" {
  name    = "${var.unique_id}-instance2"
  image   = "${var.image}"
  profile = "${var.profile}"
  resource_group = data.ibm_resource_group.resource_group.id

  primary_network_interface {
    subnet = module.tier_1_subnets.subnet_ids[0]
    name   = "eth0"
    allow_ip_spoofing = false
  }

  vpc  = ibm_is_vpc.vpc.id
  zone = "${var.zone}"
  keys = [ibm_is_ssh_key.sshkey.id]

  //User can configure timeouts
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "ibm_is_floating_ip" "instance1_floatingip" {
  name   = "instance1-fip"
  resource_group = data.ibm_resource_group.resource_group.id
  target = ibm_is_instance.instance1.primary_network_interface[0].id
}

resource "ibm_is_floating_ip" "instance2_floatingip" {
  name   = "instance2-fip"
  resource_group = data.ibm_resource_group.resource_group.id
  target = ibm_is_instance.instance2.primary_network_interface[0].id
}

