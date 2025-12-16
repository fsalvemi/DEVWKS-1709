# DEVWKS-1709 Lab

This is a demonstration repository for **DEVWKS-1709 Lab** and includes four repositories that cover two scenarios and three learning objectives

| Scenario | Repository | Approach | Learning Objective | 
|----------|--------------|---------|---------|
| Simple Example| nac-catalystcenter-simple-example | Catalyst Center as Code | Familiarize with Catalyst Center as Code |
| Simple Example| native-terraform-simple-example | Native Terraform | Comparing approach complexity |
| Simple Example| native-api-simple-example | Native Catalyst Center API | Comparing approach complexity |
| Comprehensive Example | nac-catalystcenter-comprehensive-example | Catalyst Center as Code | Demonstrate full SDA Fabric Deployment |

The first three repositories demonstrates three approaches to achieve the **identical outcome**: deploying a complete site hierarchy with IP pools and reservations to Cisco Catalyst Center.
This will allows to familiarize with Catalyst Center as Code solution and compare its complexity, maintainability, and ease of use with the other approaches

The forth repository includes comprehensive example that deploys a full SD-Access fabric using the catalyst center as code approach.
This demonstrates how Catalyst Center as Code can be used to deploy a full SD-Access fabric

## Suggested Learning Path

### Step 1: Use the Simple Example deployment scenario to familiarize with Catalyst Center as Code

Follow the lab guide for the [nac-catalystcenter approach](nac-catalystcenter-simple-example/README.md)

### Step 2 (Optional): Try to achieve the same results using the Terraform Native API approach

Follow the lab guide for the [Terraform Native API approach](native-terraform-simple-example/README.md) and compare the complexity of the code required to achieve the same result

### Step 3 (Optional): Try to achieve the same results using the Catalyst Center Native API approach

Examine the complexity of the [native API example](native-api-simple-example/README.md) and compare the complexity of the code required to achieve the same result

### Step 4: Review Approach Comparison for for Simple Example deployment using different approaches


### Step 5 (Stretch): Deploy a complete SD-Access Fabric

Follow the lab guide for the [nac-catalystcenter-comprehensive-example](nac-catalystcenter-comprehensive-example/README.md)

## Lab Access

For instructions on how to access the lab environment, see [Lab Access Guide](LAB_ACCESS.md).

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

Note that the reference_configs folder is not required for the Catalyst Center as Code solution, it has been added to the repository to facilitate the learning and error check for the NAC Catalyst Center Lab.

## What's Deployed in the simple example scenario

In the simple example scenario, each approach deploys **35 total resources** to Catalyst Center:

### Site Hierarchy (15 resources)
- **5 Areas**: United States, Golden Hills Campus, Lakefront Tower, Oceanfront Mansion, Desert Oasis Branch
- **4 Buildings**: Sunset Tower, Windy City Plaza, Art Deco Mansion, Desert Oasis Tower
- **6 Floors**: Multiple floors across different buildings

### IP Resources (20 resources)
- **4 Global IP Pools**: US_CORP, US_TECH, US_GUEST, US_BYOD
- **16 IP Pool Reservations**: 4 reservations per site (CORP, TECH, GUEST, BYOD)

## 📊 Approach Comparison for for Simple Example deployment using different approaches

| Approach | Lines of Code | Files | Complexity |
|----------|--------------|-------|------------|
| **Catalyst Center as Code** | ~164 | 3 | ⭐ Simple |
| **Native Terraform** | ~487 | 1 | ⭐⭐⭐ Complex |
| **Native Catalyst Center API** | ~650 | 1 | ⭐⭐⭐⭐ Very Complex |

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
