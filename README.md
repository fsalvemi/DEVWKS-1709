# NAC Catalyst Center Simple Example - Complexity Comparison

This repository demonstrates three different approaches to configuring Cisco Catalyst Center infrastructure, comparing their complexity, maintainability, and ease of use.

## 🎯 Purpose

This is a teaching/demonstration repository for **DEVWKS-1709 Lab**, showcasing the difference in complexity between:
1. **NAC Module (YAML-based)** - Simplified, declarative configuration
2. **Native Terraform (HCL)** - Direct provider resource usage
3. **Native API (Python)** - Direct REST API implementation

All three approaches achieve the **identical outcome**: deploying a complete site hierarchy with IP pools and reservations to Cisco Catalyst Center.

## 📊 Quick Comparison

| Approach | Lines of Code | Files | Complexity |
|----------|--------------|-------|------------|
| **NAC Module** | ~164 | 3 | ⭐ Simple |
| **Native Terraform** | ~487 | 1 | ⭐⭐⭐ Complex |
| **Native API** | ~650 | 1 | ⭐⭐⭐⭐ Very Complex |

## 📁 Repository Structure

```
.
├── nac-catalystcenter-simple-example/     # NAC Module approach
│   ├── main.tf                            # Terraform configuration
│   ├── data/
│   │   ├── sites.nac.yaml                 # Site hierarchy in YAML
│   │   └── ip_pools.nac.yaml              # IP pools in YAML
│   ├── reference_configs/
│   │   ├── initial_config/                # Base US-only configuration
│   │   │   ├── sites.nac.yaml             # Initial site hierarchy
│   │   │   └── ip_pools.nac.yaml          # Initial IP pools
│   │   └── final_config/                  # Complete configuration with Rome
│   │       ├── sites.nac.yaml             # Final site hierarchy
│   │       └── ip_pools.nac.yaml          # Final IP pools
│   └── README.md                          # Step-by-step lab guide
│
├── native-terraform-simple-example/       # Native Terraform approach
│   ├── main.tf                            # All 35 resources in HCL
│   └── README.md                          # Complexity comparison
│
└── native-api-simple-example/             # Native API approach
    └── native_api_implementation.py       # Python REST API client
```

## Lab Access

- Use the dCloud eXpo session details to establish a VPN connection to your assigned session <link To Be Added>
- From your lab workstation, open a RDP (Remote Desktop Protocol) session to the Windows VM
  - IP: 198.18.133.20
  - Username: admin
  - Password: C1sco12345

## Suggested Learning Path

- Follow the lab guide for the [nac-catalystcenter approach](nac-catalystcenter-simple-example/README.md)
- Optionally try to achieve the same results using the [Terraform Native API approach](native-terraform-simple-example/README.md) and compare the complexity of the code required to achieve the same result
- Optionally Examine the complexity of the [native API example](native-api-simple-example/README.md) to achieve the same results

## 🚀 What's Deployed

Each approach deploys **35 total resources** to Catalyst Center:

### Site Hierarchy (15 resources)
- **5 Areas**: United States, Golden Hills Campus, Lakefront Tower, Oceanfront Mansion, Desert Oasis Branch
- **4 Buildings**: Sunset Tower, Windy City Plaza, Art Deco Mansion, Desert Oasis Tower
- **6 Floors**: Multiple floors across different buildings

### IP Resources (20 resources)
- **4 Global IP Pools**: US_CORP, US_TECH, US_GUEST, US_BYOD
- **16 IP Pool Reservations**: 4 reservations per site (CORP, TECH, GUEST, BYOD)

## 📖 Detailed Approach Descriptions

### 1️⃣ NAC Module Approach (`nac-catalystcenter-simple-example/`)

**What it is:** Uses the Network-as-Code (NAC) Terraform module with YAML configuration files.

**Key Features:**
- ✅ Declarative YAML configuration
- ✅ Automatic dependency management
- ✅ Built-in error handling and retries
- ✅ Pattern-based, intuitive structure

**When to use:**
- Production deployments at scale
- Team prefers configuration over code
- Rapid iteration and changes needed
- Minimizing human error is critical

**Example:**
```yaml
buildings:
  - name: Sunset Tower
    latitude: 34.099
    longitude: -118.366
    address: 8358 Sunset Blvd, Los Angeles, CA 90069
    parent_name: Global/United States/Golden Hills Campus
```

### 2️⃣ Native Terraform Approach (`native-terraform-simple-example/`)

**What it is:** Direct use of CiscoDevNet Catalyst Center provider resources.

**Key Features:**
- ⚠️ Full control over resources
- ⚠️ 3x more verbose than NAC
- ⚠️ Requires 25+ explicit `depends_on` declarations
- ⚠️ Requires analysis to properly map API objects to TF attribute names


**When to use:**
- Need features not yet in NAC module
- Small deployments (< 5 sites)
- Team has deep Terraform/provider expertise
- Direct provider access required

### 3️⃣ Native API Approach (`native-api-simple-example/`)

**What it is:** Pure Python implementation using REST API calls.

**Key Features:**
- ❌ 4x more code than NAC
- ❌ Manual state management
- ❌ Custom error handling required
- ❌ Asynchronous task polling
- ❌ No rollback capability
- ❌ Manual dependency sequencing

**When to use:**
- One-time migrations
- Integration with existing Python workflows
- Dynamic configuration from external systems
- Building custom tooling
- Need to bypass Terraform entirely

⚠️ Requires extensive coding, testing, and debugging


## 📋 Key Takeaways

1. **NAC Module reduces complexity by 66-75%** compared to native approaches
2. **Schema knowledge is critical** for native Terraform (non-obvious attributes, case sensitivity)
3. **Abstraction layers prevent common mistakes** (gateway conflicts, missing attributes)
4. **Production deployments benefit from declarative approaches** (state management, rollback)

## 🔗 Resources

- **NAC Module Documentation**: [netascode/terraform-catalystcenter-nac-catalystcenter](https://registry.terraform.io/modules/netascode/nac-catalystcenter/catalystcenter/latest)
- **Catalyst Center Provider**: [CiscoDevNet/catalystcenter](https://registry.terraform.io/providers/CiscoDevNet/catalystcenter/latest)
- **Detailed Comparison**: See `nac-catalystcenter-simple-example/COMPARISON.md`

## 🎓 Learning Objectives

After exploring this repository, you should understand:
- How NAC modules simplify infrastructure-as-code
- Real-world challenges of native provider usage
- Trade-offs between abstraction and control
- When to use each approach
- The importance of schema knowledge for native implementations

## 🏷️ Target Audience

- Network engineers learning infrastructure-as-code
- DevOps teams evaluating Catalyst Center automation
- Terraform practitioners comparing module vs native approaches
- Anyone interested in declarative network configuration

---

**Created for DEVWKS-1709 Lab** | Cisco DevNet
