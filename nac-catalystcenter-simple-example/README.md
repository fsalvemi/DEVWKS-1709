# NAC Module Approach - Simple Example

This folder demonstrates the **Network-as-Code (NAC) Module** approach to configuring Cisco Catalyst Center using YAML-based declarative configuration.

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

### 2. Deploy

```bash
terraform init
terraform plan   # Review changes
terraform apply  # Deploy to Catalyst Center
```

**Expected Result**: ✅ Success on first apply - all 35 resources created

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
