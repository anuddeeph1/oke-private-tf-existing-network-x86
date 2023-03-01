## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-oke" {
  #source                              = "github.com/oracle-devrel/terraform-oci-arch-oke"
  source                        = "../../"
  tenancy_ocid                  = var.tenancy_ocid
  compartment_ocid              = var.compartment_ocid
  oke_cluster_name              = var.oke_cluster_name
  k8s_version                   = var.k8s_version
  pool_name                     = var.pool_name
  node_shape                    = var.node_shape
  node_ocpus                    = var.node_ocpus
  node_memory                   = var.node_memory
  node_count                    = var.node_count
  pods_cidr                     = var.pods_cidr
  services_cidr                 = var.services_cidr
  node_linux_version            = var.node_linux_version
  use_existing_vcn              = true
  vcn_id                        = var.vcn_ocid
  is_api_endpoint_subnet_public = false
  api_endpoint_subnet_id        = var.my_api_endpoint_subnet_ocid
  is_lb_subnet_public           = false
  lb_subnet_id                  = var.my_lb_subnet_ocid
  is_nodepool_subnet_public     = false
  nodepool_subnet_id            = var.my_pods_nodepool_subnet_ocid
  oci_vcn_ip_native             = true
  max_pods_per_node             = 10
  pods_subnet_id                = var.pods_subnet_ocid
  #service_subnet_id                    = var.service_subnet_ocid
  node_eviction_node_pool_settings     = true
  eviction_grace_duration              = "PT0M"
  is_force_delete_after_grace_duration = true
}

