# What's Deployed in the Comprehensive Example Scenario

The comprehensive example demonstrates a complete **SD-Access Fabric deployment** in Catalyst Center. This scenario showcases a production-ready network fabric with multiple virtual networks, border devices, edge nodes, and full Layer 3 connectivity.

## Overview

The comprehensive example deploys a full SD-Access fabric environment in Poland (Krakow) with:
- Complete site hierarchy (areas, building, floors)
- Multiple Layer 3 virtual networks (VNs)
- Fabric infrastructure (border and edge devices)
- IP addressing and DHCP services
- Network authentication (ISE integration)
- Transit connectivity
- Network profiles and device templates

## Site Hierarchy

### Areas
- **Global** - Top-level area
- **Poland** - Country-level area (parent: Global)
- **Krakow** - City-level area (parent: Global/Poland)

### Buildings
- **Bld A** - Building in Krakow
  - Location: 50.0623225°N, 19.937975°E
  - Country: Poland

### Floors
- **FLOOR_1** - Floor number 1 (Building A)
- **FLOOR_2** - Floor number 2 (Building A)

## Fabric Configuration

### Layer 3 Virtual Networks (4 VNs)
1. **Campus** - Corporate network traffic
2. **Guest** - Guest network traffic
3. **Printers** - Printer/IoT devices
4. **BYOD** - Bring Your Own Device network

### Transit Configuration
- **BGP65002** - IP-based transit
  - Type: IP_BASED_TRANSIT
  - Routing Protocol: BGP
  - Autonomous System Number: 65002

### Fabric Site
- **Global/Poland/Krakow** - SD-Access fabric site
  - Authentication: No Authentication template
  - Pub/Sub: Enabled
  - All 4 virtual networks enabled

## Network Devices

### Border Router
- **BR10** (198.18.130.10)
  - Device Type: C9KV-UADP-8P
  - Role: BORDER ROUTER
  - Fabric Roles: BORDER_NODE, CONTROL_PLANE_NODE
  - Border Type: LAYER_3
  - Default Exit: Enabled
  - Local ASN: 65001
  - L3 Handoff: BGP65002 (GigabitEthernet1/0/3)

### Edge Switches
- **EDGE01** (198.18.130.1)
  - Device Type: C9KV-UADP-8P
  - Role: ACCESS
  - Fabric Role: EDGE_NODE
  - Port Assignment: GigabitEthernet1/0/2 (Campus VLAN, No Authentication)

- **EDGE02** (198.18.130.2)
  - Device Type: C9KV-UADP-8P
  - Role: ACCESS
  - Fabric Role: EDGE_NODE
  - Port Assignment: GigabitEthernet1/0/3 (Campus VLAN, No Authentication)

## IP Addressing

### Global IP Pool
- **Overlay** - 192.168.0.0/16

### IP Pool Reservations (4 pools)
1. **CampusVN-IPPool**
   - Subnet: 192.168.100.0/24
   - Gateway: 192.168.100.1
   - Associated VN: Campus

2. **GuestVN-IPPool**
   - Subnet: 192.168.101.0/24
   - Gateway: 192.168.101.1
   - Associated VN: Guest

3. **PrintersVN-IPPool**
   - Subnet: 192.168.102.0/24
   - Gateway: 192.168.102.1
   - Associated VN: Printers

4. **BYOD-IPPool**
   - Subnet: 192.168.103.0/24
   - Gateway: 192.168.103.1
   - Associated VN: BYOD

### Network Services
- DNS Server: 198.18.130.11
- DHCP Server: 198.18.130.11

## Network Settings

### AAA Configuration
- **AAA_Settings**
  - Server Type: ISE (Identity Services Engine)
  - Protocol: RADIUS
  - Primary IP: 198.18.133.27

## Anycast Gateways

Each virtual network has an anycast gateway configured:
- **Campus**: CampusVN-IPPool, auto-generated VLAN, DATA traffic
- **Guest**: GuestVN-IPPool, auto-generated VLAN, DATA traffic
- **BYOD**: BYOD-IPPool, auto-generated VLAN, DATA traffic
- **Printers**: PrintersVN-IPPool, auto-generated VLAN, DATA traffic

## Network Profiles

- **VirtualCat9k** - Switching profile
  - Day-N Template: ACL_Block
  - Applied to: Global/Poland/Krakow

## Key Differences from Simple Example

The comprehensive example differs from the simple example in several important ways:

1. **Fabric Deployment**: Full SD-Access fabric with border and edge nodes (simple example has no fabric)
2. **Virtual Networks**: 4 Layer 3 VNs with segmentation (simple example uses flat network)
3. **Device Management**: Includes device inventory, roles, and port assignments (simple example is infrastructure-only)
4. **Border Configuration**: L3 handoff with BGP transit connectivity (simple example has no border devices)
5. **Network Segmentation**: Traffic separation across VNs with anycast gateways (simple example uses basic IP pools)
6. **ISE Integration**: AAA server configuration for network access control (simple example has no authentication)
7. **Complexity**: Production-ready fabric vs. basic site/IP pool demonstration

## Deployment Approach

This comprehensive example uses the same **NAC (Network as Code) module approach** as the simple example, but demonstrates its capability to handle complex SD-Access fabric deployments through YAML configuration files:

- `sites.nac.yaml` - Site hierarchy
- `network_settings.nac.yaml` - IP pools and AAA settings
- `fabric.nac.yaml` - Fabric sites, VNs, and anycast gateways
- `devices.nac.yaml` - Device inventory and fabric roles
- `network_profiles.nac.yaml` - Network profiles and templates
- `templates.nac.yaml` - Device configuration templates

For detailed implementation instructions, see the [nac-catalystcenter-comprehensive-example README](nac-catalystcenter-comprehensive-example/README.md).
