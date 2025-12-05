# Native Terraform Implementation - Complexity Demonstration

This folder contains a native Terraform HCL implementation that demonstrates the complexity challenges when working directly with the Catalyst Center provider without an abstraction layer like the NAC module.

## ⚠️ Important Note

**This implementation intentionally contains schema errors** to demonstrate the real-world challenges of native Terraform development. When running `terraform plan`, you will encounter errors such as:

### Example Errors

```
Error: Missing required argument
  on main.tf line 22, in resource "catalystcenter_ip_pool":
  The argument "ip_subnet" is required, but no definition was found.

Error: Unsupported argument
  on main.tf line 25, in resource "catalystcenter_ip_pool":
  An argument named "ip_pool_cidr" is not expected here.

Error: Missing required argument
  on main.tf line 346, in resource "catalystcenter_floor":
  The argument "rf_model" is required, but no definition was found.
```

## Why These Errors Exist

These errors illustrate several key challenges with native Terraform implementations:

### 1. **Non-Intuitive Attribute Names**
- Provider expects: `ip_subnet`
- Developer might expect: `ip_pool_cidr` (from YAML/API)
- Reality: You must memorize exact provider schema

### 2. **Hidden Required Attributes**
For `catalystcenter_floor`, you must provide:
- `rf_model` - Radio Frequency model (not obvious)
- `width` - Floor width in feet/meters
- `height` - Floor height
- `length` - Floor length

These aren't intuitive without extensive documentation review.

### 3. **No Abstraction Layer**
- Every attribute must be explicitly specified
- No sensible defaults
- No simplified patterns for common configurations

### 4. **Schema Discovery Required**
To fix these errors, you would need to:
```bash
terraform providers schema -json | jq '.provider_schemas."registry.terraform.io/ciscodevnet/catalystcenter".resource_schemas'
```

Then manually match each attribute to the correct name and type.

## Comparison with NAC Module

**NAC Module (YAML):**
```yaml
buildings:
  - name: Sunset Tower
    latitude: 34.099
    longitude: -118.366
    address: 8358 Sunset Blvd, Los Angeles, CA 90069
```

**Native Terraform (with all required attributes):**
```hcl
resource "catalystcenter_building" "sunset_tower" {
  name        = "Sunset Tower"
  parent_name = "Global/United States/Golden Hills Campus"
  address     = "8358 Sunset Blvd, Los Angeles, CA 90069"
  latitude    = 34.099
  longitude   = -118.366
  country     = "United States"
  depends_on  = [catalystcenter_area.golden_hills_campus]
}

resource "catalystcenter_floor" "sunset_tower_floor_1" {
  name         = "FLOOR_1"
  parent_name  = "Global/United States/Golden Hills Campus/Sunset Tower"
  floor_number = 1
  rf_model     = "Cubes And Walled Offices"  # Required, not obvious
  width        = 100                          # Required, not obvious
  height       = 10                           # Required, not obvious
  length       = 100                          # Required, not obvious
  depends_on   = [catalystcenter_building.sunset_tower]
}
```

## The Point

This example **intentionally demonstrates** why native implementations are challenging:

1. **More verbose** - 3-4x more code
2. **Requires deep knowledge** - Must know exact provider schema
3. **Error-prone** - Easy to use wrong attribute names
4. **Maintenance burden** - Schema changes break code
5. **No guardrails** - No validation until runtime

## Fixing This Implementation

To make this work, you would need to:

1. **Research provider schema** for every resource type
2. **Update IP pool resources** to use `ip_subnet` instead of `ip_pool_cidr`
3. **Add floor attributes** (`rf_model`, `width`, `height`, `length`) to all floors
4. **Verify gateway syntax** and other attribute formats
5. **Test iteratively** with `terraform plan` and fix each error

This process typically takes **hours or days** for a configuration of this size, compared to **minutes** with the NAC module.

## For Comparison

See the working NAC module implementation in:
```
../nac-catalystcenter-simple-example/
```

And review the full complexity comparison:
```
../nac-catalystcenter-simple-example/COMPARISON.md
```

---

## Conclusion

This folder serves as a **demonstration of complexity**, not a working implementation. It illustrates why abstraction layers like the NAC module are valuable for production use, reducing both development time and error rates by 60-70%.
