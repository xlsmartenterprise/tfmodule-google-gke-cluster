# tfmodule-google-gke-cluster

Terraform module for deploying and managing Google Kubernetes Engine (GKE) clusters on Google Cloud Platform. This module provides a flexible and production-ready configuration for creating GKE clusters with support for private clusters, advanced networking, monitoring, logging, and security features.

## Features

- Regional GKE cluster deployment with configurable release channels
- Private cluster configuration with private endpoints and nodes
- Gateway API integration with configurable channels
- Flexible IP allocation with separate ranges for pods and services
- Master authorized networks with IPv4 CIDR-based access control
- DNS-based control plane endpoint configuration
- Comprehensive monitoring and logging with Managed Prometheus support
- GKE Backup Agent integration
- Intranode visibility for enhanced network observability
- Resource manager tags support for node pools
- L4 ILB subsetting for improved load balancing
- HTTP load balancing addon configuration
- Maintenance policy configuration with daily and recurring windows
- Maintenance exclusion windows support

## Usage

### Basic Example

```hcl
module "gke_cluster" {
  source = source = "github.com/xlsmartenterprise/tfmodule-google-gke-cluster"

  cluster_name = "production-gke-cluster"
  project_id   = "my-gcp-project"
  region       = "us-central1"
  
  network    = "projects/my-gcp-project/global/networks/vpc-network"
  subnetwork = "projects/my-gcp-project/regions/us-central1/subnetworks/gke-subnet"

  initial_node_count = 1
  release_channel    = "REGULAR"
  gateway_api_config = "CHANNEL_STANDARD"

  # Private cluster configuration
  enable_private_endpoint = false
  enable_private_nodes    = true

  # IP allocation
  cluster_secondary_range_name  = "gke-pods"
  services_secondary_range_name = "gke-services"

  # Master authorized networks
  enable_master_authorized_networks       = true
  master_authorized_cidr                  = "10.0.0.0/8"
  master_authorized_networks_display_name = "Internal Network"

  # Addons
  disabled_http_load_balancing       = false
  enabled_gke_backup_agent_config    = true

  # Monitoring and logging
  enable_logging_components    = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  enable_monitoring_components = ["SYSTEM_COMPONENTS"]
  enable_managed_prometheus    = true

  # Additional features
  deletion_protection         = false
  enable_l4_ilb_subsetting    = true
  enable_intranode_visibility = true

  resource_manager_tags = {}

  # Maintenance policy (optional)
  enable_maintenance_policy    = false
  maintenance_policy_type      = "daily"
  daily_maintenance_start_time = "03:00"
}
```

### Private Cluster with DNS Endpoint

```hcl
module "gke_private_cluster" {
  source = source = "github.com/xlsmartenterprise/tfmodule-google-gke-cluster"

  cluster_name = "private-gke-cluster"
  project_id   = "my-gcp-project"
  region       = "us-west1"
  
  network    = "projects/my-gcp-project/global/networks/vpc-network"
  subnetwork = "projects/my-gcp-project/regions/us-west1/subnetworks/private-subnet"

  initial_node_count = 1
  release_channel    = "STABLE"
  gateway_api_config = "CHANNEL_DISABLED"

  # Full private cluster
  enable_private_endpoint = true
  enable_private_nodes    = true

  # IP allocation
  cluster_secondary_range_name  = "pods-range"
  services_secondary_range_name = "services-range"

  # DNS-based control plane access
  enable_dns_endpoint           = true
  allow_external_dns_traffic    = false
  enable_k8s_tokens_via_dns     = true
  enable_k8s_certs_via_dns      = true
  
  # Disable traditional master authorized networks when using DNS
  enable_master_authorized_networks = false

  # Addons
  disabled_http_load_balancing    = false
  enabled_gke_backup_agent_config = true

  # Monitoring and logging
  enable_logging_components    = ["SYSTEM_COMPONENTS", "WORKLOADS", "API_SERVER"]
  enable_monitoring_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  enable_managed_prometheus    = true

  # Additional features
  deletion_protection         = true
  enable_l4_ilb_subsetting    = true
  enable_intranode_visibility = true

  resource_manager_tags = {
    "environment" = "tagValues/123456789"
    "team"        = "tagValues/987654321"
  }

  # Maintenance policy
  enable_maintenance_policy    = true
  maintenance_policy_type      = "daily"
  daily_maintenance_start_time = "02:00"
}
```

### Production Cluster with Enhanced Monitoring

```hcl
module "gke_production_cluster" {
  source = source = "github.com/xlsmartenterprise/tfmodule-google-gke-cluster"

  cluster_name = "prod-cluster"
  project_id   = "production-project"
  region       = "europe-west1"
  
  network    = "projects/production-project/global/networks/prod-vpc"
  subnetwork = "projects/production-project/regions/europe-west1/subnetworks/gke-prod-subnet"

  initial_node_count = 1
  release_channel    = "REGULAR"
  gateway_api_config = "CHANNEL_STANDARD"

  # Hybrid private cluster (private nodes, public endpoint)
  enable_private_endpoint = false
  enable_private_nodes    = true

  # IP allocation with large ranges for production
  cluster_secondary_range_name  = "prod-pods-range"
  services_secondary_range_name = "prod-services-range"

  # Restrict control plane access
  enable_master_authorized_networks       = true
  master_authorized_cidr                  = "10.100.0.0/16"
  master_authorized_networks_display_name = "Corporate Network"

  # Addons
  disabled_http_load_balancing    = false
  enabled_gke_backup_agent_config = true

  # Comprehensive monitoring and logging
  enable_logging_components = [
    "SYSTEM_COMPONENTS",
    "WORKLOADS",
    "API_SERVER",
    "SCHEDULER",
    "CONTROLLER_MANAGER"
  ]
  enable_monitoring_components = [
    "SYSTEM_COMPONENTS",
    "WORKLOADS",
    "APISERVER",
    "SCHEDULER",
    "CONTROLLER_MANAGER"
  ]
  enable_managed_prometheus = true

  # Production features
  deletion_protection         = true
  enable_l4_ilb_subsetting    = true
  enable_intranode_visibility = true

  resource_manager_tags = {
    "environment" = "tagValues/111111111"
    "cost-center" = "tagValues/222222222"
    "compliance"  = "tagValues/333333333"
  }

  # Maintenance policy with exclusions
  enable_maintenance_policy       = true
  maintenance_policy_type         = "recurring"
  recurring_window_start_time     = "2026-01-15T03:00:00Z"
  recurring_window_end_time       = "2026-01-15T07:00:00Z"
  recurring_window_recurrence     = "FREQ=WEEKLY;BYDAY=SA,SU"

  maintenance_exclusions = [
    {
      exclusion_name = "holiday-freeze"
      start_time     = "2026-12-20T00:00:00Z"
      end_time       = "2026-01-05T00:00:00Z"
      scope          = "NO_UPGRADES"
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | Name of the GKE cluster | `string` | n/a | yes |
| project_id | GCP Project ID | `string` | n/a | yes |
| region | GCP region for the cluster | `string` | n/a | yes |
| network | VPC network name | `string` | n/a | yes |
| subnetwork | VPC subnetwork name | `string` | n/a | yes |
| deletion_protection | Enable deletion protection for the cluster | `bool` | n/a | yes |
| enable_l4_ilb_subsetting | Enable L4 ILB subsetting | `bool` | n/a | yes |
| initial_node_count | Initial number of nodes per zone | `number` | n/a | yes |
| release_channel | GKE release channel (RAPID, REGULAR, STABLE, UNSPECIFIED) | `string` | n/a | yes |
| gateway_api_config | Gateway API channel (CHANNEL_DISABLED, CHANNEL_STANDARD) | `string` | n/a | yes |
| enable_private_endpoint | Enable private endpoint for the cluster | `bool` | n/a | yes |
| enable_private_nodes | Enable private nodes | `bool` | n/a | yes |
| disabled_http_load_balancing | Disable HTTP load balancing addon | `bool` | n/a | yes |
| enabled_gke_backup_agent_config | Enable GKE Backup Agent addon | `bool` | n/a | yes |
| enable_logging_components | List of GKE components to enable logging for | `list(string)` | n/a | yes |
| enable_monitoring_components | List of GKE components to enable monitoring for | `list(string)` | n/a | yes |
| enable_managed_prometheus | Enable managed Prometheus | `bool` | n/a | yes |
| cluster_secondary_range_name | Name of the secondary range for pods | `string` | n/a | yes |
| services_secondary_range_name | Name of the secondary range for services | `string` | n/a | yes |
| enable_master_authorized_networks | Enable master authorized networks (IPv4-based access). Set to false to use DNS-based access only | `bool` | `true` | no |
| master_authorized_cidr | CIDR block for master authorized networks | `string` | `""` | no |
| master_authorized_networks_display_name | Display name for master authorized networks | `string` | `""` | no |
| enable_dns_endpoint | Enable DNS endpoint configuration for control plane access | `bool` | `false` | no |
| allow_external_dns_traffic | Allow external traffic through DNS endpoint | `bool` | `false` | no |
| enable_k8s_tokens_via_dns | Enable k8s tokens via DNS | `bool` | `false` | no |
| enable_k8s_certs_via_dns | Enable k8s certs via DNS | `bool` | `false` | no |
| enable_intranode_visibility | Enable intranode visibility | `bool` | n/a | yes |
| resource_manager_tags | Resource manager tags to apply to the GKE cluster. Map of tag key to tag value ID | `map(string)` | `{}` | no |
| enable_maintenance_policy | Enable maintenance policy for the cluster | `bool` | `false` | no |
| maintenance_policy_type | Type of maintenance policy (daily or recurring) | `string` | `"daily"` | no |
| daily_maintenance_start_time | Start time for daily maintenance window (e.g., '03:00' or RFC3339 format) | `string` | `"03:00"` | no |
| recurring_window_start_time | Start time for recurring maintenance window in RFC3339 format | `string` | `""` | no |
| recurring_window_end_time | End time for recurring maintenance window in RFC3339 format | `string` | `""` | no |
| recurring_window_recurrence | Recurrence rule for maintenance window (e.g., 'FREQ=WEEKLY;BYDAY=SA,SU') | `string` | `""` | no |
| maintenance_exclusions | List of maintenance exclusion windows with exclusion_name, start_time, end_time, and scope | `list(object)` | `[]` | no |

## Outputs

| Name | Description | Sensitive |
|------|-------------|-----------|
| cluster_name | Name of the GKE cluster | no |
| cluster_id | ID of the GKE cluster | no |
| cluster_endpoint | Endpoint for the GKE cluster | yes |
| cluster_ca_certificate | Cluster CA certificate (base64 encoded) | yes |
| cluster_location | Location of the GKE cluster | no |
| cluster_master_version | Kubernetes master version | no |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| google | >= 7.0.0, < 8.0.0 |
| google-beta | >= 7.0.0, < 8.0.0 |

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for version history and changes.