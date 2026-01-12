# GKE Cluster Variables
variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region for the cluster"
  type        = string
}

variable "network" {
  description = "VPC network name"
  type        = string
}

variable "subnetwork" {
  description = "VPC subnetwork name"
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection for the cluster"
  type        = bool
}

variable "enable_l4_ilb_subsetting" {
  description = "Enable L4 ILB subsetting"
  type        = bool
}

variable "initial_node_count" {
  description = "Initial number of nodes per zone"
  type        = number
}

variable "release_channel" {
  description = "GKE release channel (RAPID, REGULAR, STABLE, UNSPECIFIED)"
  type        = string
}

variable "gateway_api_config" {
  description = "Gateway API channel (CHANNEL_DISABLED, CHANNEL_STANDARD)"
  type        = string
}

# Private Cluster Configuration
variable "enable_private_endpoint" {
  description = "Enable private endpoint for the cluster"
  type        = bool
}

variable "enable_private_nodes" {
  description = "Enable private nodes"
  type        = bool
}

# Addons Configuration
variable "disabled_http_load_balancing" {
  description = "Disable HTTP load balancing addon"
  type        = bool
}

variable "enabled_gke_backup_agent_config" {
  description = "Enable GKE Backup Agent addon"
  type        = bool
}

# Logging Configuration
variable "enable_logging_components" {
  description = "List of GKE components to enable logging for"
  type        = list(string)
}

# Monitoring Configuration
variable "enable_monitoring_components" {
  description = "List of GKE components to enable monitoring for"
  type        = list(string)
}

variable "enable_managed_prometheus" {
  description = "Enable managed Prometheus"
  type        = bool
}

# IP Allocation Policy
variable "cluster_secondary_range_name" {
  description = "Name of the secondary range for pods"
  type        = string
}

variable "services_secondary_range_name" {
  description = "Name of the secondary range for services"
  type        = string
}

variable "enable_master_authorized_networks" {
  description = "Enable master authorized networks (IPv4-based access). Set to false to use DNS-based access only"
  type        = bool
  default     = true
}

# Master Authorized Networks
variable "master_authorized_cidr" {
  description = "CIDR block for master authorized networks"
  type        = string
  default     = ""
}

variable "master_authorized_networks_display_name" {
  description = "Display name for master authorized networks"
  type        = string
  default     = ""
}

variable "enable_dns_endpoint" {
  description = "Enable DNS endpoint configuration for control plane access"
  type        = bool
  default     = false
}

variable "allow_external_dns_traffic" {
  description = "Allow external traffic through DNS endpoint"
  type        = bool
  default     = false
}

variable "enable_k8s_tokens_via_dns" {
  description = "Enable k8s tokens via DNS"
  type        = bool
  default     = false
}

variable "enable_k8s_certs_via_dns" {
  description = "Enable k8s certs via DNS"
  type        = bool
  default     = false
}

variable "enable_intranode_visibility" {
  description = "Enable intranode visibility"
  type        = bool
}

variable "resource_manager_tags" {
  description = "Resource manager tags to apply to the GKE cluster. Map of tag key to tag value ID"
  type        = map(string)
  default     = {}
}

# Maintenance Policy Configuration
variable "enable_maintenance_policy" {
  description = "Enable maintenance policy for the cluster"
  type        = bool
  default     = false
}

variable "maintenance_policy_type" {
  description = "Type of maintenance policy (daily or recurring)"
  type        = string
  default     = "daily"
  validation {
    condition     = contains(["daily", "recurring"], var.maintenance_policy_type)
    error_message = "Maintenance policy type must be either 'daily' or 'recurring'."
  }
}

variable "daily_maintenance_start_time" {
  description = "Start time for daily maintenance window in RFC3339 format (e.g., '2023-01-01T03:00:00Z' or '03:00' for time only)"
  type        = string
  default     = "03:00"
}

variable "recurring_window_start_time" {
  description = "Start time for recurring maintenance window in RFC3339 format (e.g., '2023-01-01T03:00:00Z')"
  type        = string
  default     = ""
}

variable "recurring_window_end_time" {
  description = "End time for recurring maintenance window in RFC3339 format (e.g., '2023-01-01T07:00:00Z')"
  type        = string
  default     = ""
}

variable "recurring_window_recurrence" {
  description = "Recurrence rule for maintenance window (e.g., 'FREQ=WEEKLY;BYDAY=SA,SU')"
  type        = string
  default     = ""
}

variable "maintenance_exclusions" {
  description = "List of maintenance exclusion windows. Each exclusion must have exclusion_name, start_time, end_time, and scope"
  type = list(object({
    exclusion_name = string
    start_time     = string
    end_time       = string
    scope          = string
  }))
  default = []
}
