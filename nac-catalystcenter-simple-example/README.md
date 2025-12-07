# NAC Module Approach - Simple Example

This folder demonstrates the **Network-as-Code (NAC) Module** approach to configuring Cisco Catalyst Center using YAML-based declarative configuration.

## Lab Access

If not already done, follow the [instructions for lab access](../README.md#lab-access) 

## Clone Repository

- Close Ubuntu WSL and VS Code before starting this lab! This prevents creating nested repository folders within your existing lab directory.
- Launch a new session of Ubuntu WSL machine.
- In the terminal window, type the following command to clone the repository
  ```bash
  git clone https://github.com/netascode/nac-catalystcenter-simple-example.git
  ```


## 🎯 What This Example Does

Deploys a complete network infrastructure to Catalyst Center:
- **5 Areas**: United States, Golden Hills Campus, Lakefront Tower, Oceanfront Mansion, Desert Oasis Branch
- **4 Buildings**: Sunset Tower, Windy City Plaza, Art Deco Mansion, Desert Oasis Tower  
- **6 Floors**: Multiple floors across different buildings
- **4 Global IP Pools**: US_CORP (10.201.0.0/16), US_TECH (10.202.0.0/16), US_GUEST (10.203.0.0/16), US_BYOD (10.204.0.0/16)
- **16 IP Pool Reservations**: 4 reservations per building (CORP, TECH, GUEST, BYOD)

**Total Resources Created**: 35

## 📁 File Structure

```
nac-catalystcenter-simple-example/
├── main.tf                    # Terraform configuration using NAC module
└── data/
    ├── sites.nac.yaml        # Site hierarchy (areas, buildings, floors)
    └── ip_pools.nac.yaml     # IP pools and reservations
```

## 🚀 Quick Start

### 1. Update Configuration

The `main.tf` file is the entry point for your Terraform deployment. It defines:
- **Provider Configuration**: Which Terraform provider to use (Catalyst Center)
- **Authentication**: How to connect to your Catalyst Center instance (URL, credentials)
- **NAC Module**: References the Network-as-Code module for simplified configuration
- **YAML Location**: Specifies where your configuration files are located (`data/` directory)

Edit `main.tf` to point to your Catalyst Center:

```hcl
module "catalyst_center" {
  source  = "netascode/nac-catalystcenter/catalystcenter"
  version = ">= 0.2.0"

  catalystcenter_url      = "https://YOUR-CATALYST-CENTER-IP"
  catalystcenter_username = "admin"
  catalystcenter_password = "your-password"
  
  yaml_directories = ["data/"]
}
```

### 2. Inspect YAML Files

The NAC module uses two YAML files to define the network infrastructure in a hierarchical, human-readable format.

**About YAML:**
YAML (YAML Ain't Markup Language) is a human-readable data serialization format commonly used for configuration files. Key syntax rules:
- **Indentation Matters**: Use spaces (not tabs) - typically 2 spaces per level
- **Key-Value Pairs**: Format is `key: value` with a space after the colon
- **Lists**: Use a dash (`-`) followed by a space for list items
- **Nesting**: Child elements are indented under their parent
- **Comments**: Start with `#` and continue to end of line
- **Case Sensitive**: `name` and `Name` are different keys

#### **Site Hierarchy** (`data/sites.nac.yaml`)
Defines the organizational structure: areas, buildings, and floors.

```yaml
---
catalyst_center:
  sites:
    areas:
      - name: United States
        parent_name: Global
      - name: Golden Hills Campus
        parent_name: Global/United States
    
    buildings:
      - name: Sunset Tower
        latitude: 34.099
        longitude: -118.366
        address: 8358 Sunset Blvd, Los Angeles, CA 90069
        country: United States
        parent_name: Global/United States/Golden Hills Campus
        ip_pools_reservations:
          - ST_CORP
          - ST_TECH
          - ST_GUEST
          - ST_BYOD
    
    floors:
      - name: Floor 1
        parent_name: Global/United States/Golden Hills Campus/Sunset Tower
        floor_number: 1
```

**Key Points:**
- `parent_name` creates the hierarchy using slash-separated paths
- Buildings include geographic coordinates and addresses
- IP pool reservations are referenced by name

**Data Model Overview:**
The `sites` class supports areas, buildings, and floors with:
- **Credential Management**: CLI, SNMPv2/v3, HTTPS credentials at any hierarchy level
- **Network Settings**: AAA servers, network configuration, and telemetry settings
- **IP Pool Reservations**: Reference pools by name for automatic site-specific allocation
- **Hierarchical Structure**: Use slash-separated paths (e.g., `Global/Americas/USA`)

**Full Documentation:** [Catalyst Center Sites Data Model](https://netascode.cisco.com/docs/data_models/catalyst_center/sites/area/)

#### **IP Pools** (`data/ip_pools.nac.yaml`)
Defines global IP pools and site-specific reservations.

```yaml
---
catalyst_center:
  network_settings:
    ip_pools:
      - name: US_CORP
        ip_address_space: IPv4
        ip_pool_cidr: 10.201.0.0/16
        dhcp_servers:
          - 10.201.0.2
        dns_servers:
          - 10.201.0.2
        ip_pools_reservations:
          - name: ST_CORP
            prefix_length: 24
            subnet: 10.201.2.0
          - name: DOT_CORP
            prefix_length: 24
            subnet: 10.201.1.0
```

**Key Points:**
- Each global pool contains multiple site-specific reservations
- DHCP and DNS servers are defined at the pool level
- Reservations inherit settings from their parent pool

**Full Documentation:** [Network Settings](https://netascode.cisco.com/docs/data_models/catalyst_center/network_settings/network/) | [IP Pool Data Model](https://netascode.cisco.com/docs/data_models/catalyst_center/network_settings/ip_pool/)

### 3. Deploy

```bash
terraform init
terraform plan   # Review changes
terraform apply  # Deploy to Catalyst Center
```

**Expected Result**: ✅ Success on first apply - all 35 resources created

### 3. Clean Up

To remove all deployed resources from Catalyst Center:

```bash
terraform destroy  # Remove all 35 resources
```

**Note**: Terraform will show you a plan of what will be destroyed and ask for confirmation before proceeding.

## 📝 YAML Configuration Examples

### Site Hierarchy (`data/sites.nac.yaml`)

```yaml
---
catalyst_center:
  sites:
    areas:
      - name: United States
        parent_name: Global
    
    buildings:
      - name: Sunset Tower
        latitude: 34.099
        longitude: -118.366
        address: 8358 Sunset Blvd, Los Angeles, CA 90069
        country: United States
        parent_name: Global/United States/Golden Hills Campus
        ip_pools_reservations:
          - ST_CORP
          - ST_TECH
          - ST_GUEST
          - ST_BYOD
    
    floors:
      - name: Floor 1
        parent_name: Global/United States/Golden Hills Campus/Sunset Tower
        floor_number: 1
```

### IP Pools (`data/ip_pools.nac.yaml`)

```yaml
---
catalyst_center:
  ip_pools:
    - name: US_CORP
      ip_address_space: IPv4
      ip_pool_cidr: 10.201.0.0/16
      dhcp_servers:
        - 10.201.0.2
      dns_servers:
        - 10.201.0.2
      ip_pools_reservations:
        - name: ST_CORP
          site: Global/United States/Golden Hills Campus/Sunset Tower
          prefix_length: 24
          subnet: 10.201.2.0
```

## ✅ Key Benefits

1. **Simple & Intuitive**: YAML configuration mirrors network hierarchy naturally
2. **Automatic Dependencies**: Module handles resource ordering automatically
3. **No Schema Knowledge Required**: Intuitive field names (no `ip_subnet` vs `ip_pool_cidr` confusion)
4. **Built-in Validation**: Module catches configuration errors before deployment
5. **Maintainable**: Easy to update - change YAML, run `terraform apply`
6. **Production Ready**: Includes error handling, retries, and state management

## 📊 Complexity Comparison

| Metric | This Approach (NAC) | Native Terraform | Native API |
|--------|---------------------|------------------|------------|
| **Lines of Code** | ~164 | ~487 | ~650 |
| **Files** | 3 | 1 | 1 |
| **Deployment Time** | 5 min (1 try) | 30-45 min (5 tries) | 2-4 hours |
| **Schema Knowledge** | Not required | Critical | Critical |
| **Dependencies** | Auto-managed | 25+ manual | Manual sequencing |

## 🔗 Resources

- **Original Example**: [nac-catalystcenter-simple-example](https://github.com/netascode/nac-catalystcenter-simple-example/)
- **NAC Module**: [terraform-catalystcenter-nac-catalystcenter](https://registry.terraform.io/modules/netascode/nac-catalystcenter/catalystcenter/latest)
- **Module Documentation**: [GitHub Repository](https://github.com/netascode/terraform-catalystcenter-nac-catalystcenter)
- **Catalyst Center Provider**: [CiscoDevNet Provider](https://registry.terraform.io/providers/CiscoDevNet/catalystcenter/latest)

## 📚 Learning Path

1. **Start Here** - Understand YAML structure and NAC module basics
2. **Compare** - Review `../native-terraform-simple-example/` to see complexity difference
3. **Explore** - Check `../native-api-simple-example/` for API implementation
4. **Decide** - Use insights from comparison for your own projects

---

**Part of DEVWKS-1709 Lab** | For complete comparison, see repository root [README.md](../README.md)
