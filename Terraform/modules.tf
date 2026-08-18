module "vcn" {
    source = "oracle-terraform-modules/vcn/oci"
    tenancy_id = var.tenancy_ocid
    compartment_id = var.compartment_id
}