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

### Step 4: Review Approach Comparison

Review the [Approach Comparison](APPROACH_COMPARISON.md) to understand the complexity differences between the three approaches used in the Simple Example scenario.

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

## What's Deployed in the Simple Example Scenario

For details on what infrastructure is deployed in the Simple Example scenario, see [Simple Example Deployment](SIMPLE_EXAMPLE_DEPLOYMENT.md).

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
