# resource "oci_core_vcn" "private_vcn" {
#     compartment_id = var.compartment_id
#     cidr_block = "192.168.125.0/24"
#     display_name = "VCN do K8S de Brincadeirinha - Privada"
#     defined_tags = {
#         "type":"brincadeirinha"
#     }
# }

resource "oci_core_vcn" "public_vcn" {
  compartment_id = var.compartment_id
  cidr_block     = "192.168.225.0/24"
  display_name   = "VCN do K8S de Brincadeirinha - Publica"
  defined_tags = {
    "type" : "brincadeirinha"
  }
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.public_vcn.id
  enabled        = true
  display_name   = "Internet Gateway"
}

resource "oci_core_route_table" "public_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.public_vcn.id
  display_name   = "Default Route Table"
  route_rules {
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_security_list" "security_list" {
  vcn_id         = oci_core_vcn.public_vcn.id
  compartment_id = var.compartment_id
  dynamic "ingress_security_rules" {
    for_each = split(",", var.allowed_ip)
    content {
      protocol = 6
      source   = var.allowed_ip
      tcp_options {
        max = 9999
        min = 9997
      }
    }
  }
  ingress_security_rules {
    protocol = 6
    source   = "0.0.0.0/0"
    tcp_options {
      max = 443
      min = 443
    }
  }
}
