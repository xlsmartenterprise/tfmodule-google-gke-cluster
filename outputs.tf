# Cluster Outputs
output "cluster_name" {
  description = "Name of the GKE cluster"
  value       = google_container_cluster.default.name
}

output "cluster_id" {
  description = "ID of the GKE cluster"
  value       = google_container_cluster.default.id
}

output "cluster_endpoint" {
  description = "Endpoint for the GKE cluster"
  value       = google_container_cluster.default.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate (base64 encoded)"
  value       = google_container_cluster.default.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "cluster_location" {
  description = "Location of the GKE cluster"
  value       = google_container_cluster.default.location
}

output "cluster_master_version" {
  description = "Kubernetes master version"
  value       = google_container_cluster.default.master_version
}