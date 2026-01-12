# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-12

### Added

#### Core Cluster Features
- Initial release of GKE cluster Terraform module
- Support for regional GKE cluster deployment
- Configurable release channel (RAPID, REGULAR, STABLE, UNSPECIFIED)
- Gateway API configuration support with channel options
- L4 ILB subsetting enablement
- Initial node count configuration
- Default node pool removal support

#### Private Cluster Configuration
- Private endpoint configuration for enhanced security
- Private nodes support for internal-only communication
- Flexible private cluster setup options

#### Network Configuration
- VPC network and subnetwork integration
- IP allocation policy with separate ranges for pods and services
- Master authorized networks configuration with IPv4 CIDR-based access
- DNS-based control plane endpoint configuration
- Support for external DNS traffic control
- Kubernetes tokens and certificates via DNS

#### Monitoring and Logging
- Configurable logging components for GKE services
- Monitoring components configuration
- Managed Prometheus integration
- Comprehensive observability setup
- Configurable maintenance policy types: daily and recurring windows

#### Addons and Features
- HTTP load balancing addon configuration
- GKE Backup Agent addon support
- Intranode visibility enablement
- Resource manager tags support for node pools

#### Security Features
- Deletion protection configuration
- Master authorized networks with display names
- Private cluster capabilities
- L4 load balancer firewall reconciliation control