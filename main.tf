data "ibm_resource_group" "resource_group" {
  name = "${var.resource_group}"
}

data "ibm_is_vpc" "vpc1" {
    name = "${var.vpc}"
}

data "ibm_is_subnet" "subnet_zone1" {
    name = "${var.subnet_zone1}"
}

data "ibm_is_subnet" "subnet_zone2" {
    name = "${var.subnet_zone2}"
}

data "ibm_is_subnet" "subnet_zone3" {
    name = "${var.subnet_zone3}"
}

resource "ibm_container_vpc_cluster" "cluster" {
  name              = "${var.cluster_name}"
  vpc_id            = "${data.ibm_is_vpc.vpc1.id}"
  flavor            = "${var.flavor}"
  worker_count      = "${var.worker_count}"
  resource_group_id = "${data.ibm_resource_group.resource_group.id}"
  tags              = ["${var.environment}", "terraform"]

  zones = [
    {
        subnet_id = "${data.ibm_is_subnet.subnet_zone1.id}"
        name      = "${var.region}-1"
    },
    {
        subnet_id = "${data.ibm_is_subnet.subnet_zone2.id}"
        name      = "${var.region}-2"
    },
    {
        subnet_id = "${data.ibm_is_subnet.subnet_zone3.id}"
        name      = "${var.region}-3"
    }

  ]

}