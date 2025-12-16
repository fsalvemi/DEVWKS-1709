# Approach Comparison for Simple Example Deployment

This document compares three different approaches to deploying the same infrastructure to Cisco Catalyst Center.

## 📊 Comparison Summary

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
