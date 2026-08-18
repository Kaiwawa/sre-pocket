resource "oci_core_instance" "ubuntu" {
  compartment_id      = var.compartment_id
  availability_domain = "DjIB:US-ASHBURN-AD-1"
  shape               = "VM.Standard.A1.Flex"
  display_name        = "Terraform Created Ubuntu"
  agent_config {
    is_monitoring_disabled = true
  }
  shape_config {
    ocpus         = 1
    memory_in_gbs = 12
  }
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaaaucq23l4nez6qyfay3wy5ahxup4sxuolbu54gl444x2v2dwuj5la"
  }

  create_vnic_details {
    subnet_id        = oci_core_vcn.public_vcn.id
    display_name     = "vnic-publica"
    assign_public_ip = true
  }

  preserve_boot_volume = false

}