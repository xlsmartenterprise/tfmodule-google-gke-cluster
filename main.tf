
# Create the Kubernetes Cluster
resource "google_container_cluster" "default" {
  name                                  = var.cluster_name
  location                              = var.region
  project                               = var.project_id
  network                               = var.network
  subnetwork                            = var.subnetwork
  remove_default_node_pool              = true
  deletion_protection                   = false
  enable_l4_ilb_subsetting              = true
  initial_node_count                    = var.initial_node_count
  disable_l4_lb_firewall_reconciliation = true

  release_channel {
    channel = var.release_channel
  }

  # Enable Gateway API
  gateway_api_config {
    channel = var.gateway_api_config
  }

  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
  }

  # Enabled features
  addons_config {
    http_load_balancing {
      disabled = var.disabled_http_load_balancing
    }

    gke_backup_agent_config {
      enabled = var.enabled_gke_backup_agent_config
    }
  }

  logging_config {
    enable_components = var.enable_logging_components
  }

  monitoring_config {
    enable_components = var.enable_monitoring_components

    managed_prometheus {
      enabled = var.enable_managed_prometheus
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  # Master Authorized Networks (IPv4-based access)
  # Optional: can be disabled when using DNS-based access only
  dynamic "master_authorized_networks_config" {
    for_each = var.enable_master_authorized_networks ? [1] : []
    content {
      cidr_blocks {
        cidr_block   = var.master_authorized_cidr
        display_name = var.master_authorized_networks_display_name
      }
    }
  }

  # DNS-based Control Plane Endpoint Configuration
  dynamic "control_plane_endpoints_config" {
    for_each = var.enable_dns_endpoint ? [1] : []
    content {
      dns_endpoint_config {
        allow_external_traffic    = var.allow_external_dns_traffic
        enable_k8s_tokens_via_dns = var.enable_k8s_tokens_via_dns
        enable_k8s_certs_via_dns  = var.enable_k8s_certs_via_dns
      }
    }
  }

  enable_intranode_visibility = var.enable_intranode_visibility
  node_pool_auto_config {
    resource_manager_tags = var.resource_manager_tags
  }

  # Maintenance Policy Configuration
  dynamic "maintenance_policy" {
    for_each = var.enable_maintenance_policy ? [1] : []
    content {
      dynamic "daily_maintenance_window" {
        for_each = var.maintenance_policy_type == "daily" ? [1] : []
        content {
          start_time = var.daily_maintenance_start_time
        }
      }

      dynamic "recurring_window" {
        for_each = var.maintenance_policy_type == "recurring" ? [1] : []
        content {
          start_time = var.recurring_window_start_time
          end_time   = var.recurring_window_end_time
          recurrence = var.recurring_window_recurrence
        }
      }

      dynamic "maintenance_exclusion" {
        for_each = var.maintenance_exclusions
        content {
          exclusion_name = maintenance_exclusion.value.exclusion_name
          start_time     = maintenance_exclusion.value.start_time
          end_time       = maintenance_exclusion.value.end_time
          exclusion_options {
            scope = maintenance_exclusion.value.scope
          }
        }
      }
    }
  }
}
