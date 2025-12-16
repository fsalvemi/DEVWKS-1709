# What's Deployed in the Simple Example Scenario

In the simple example scenario, each approach deploys **35 total resources** to Cisco Catalyst Center:

## Site Hierarchy (15 resources)

- **5 Areas**: United States, Golden Hills Campus, Lakefront Tower, Oceanfront Mansion, Desert Oasis Branch
- **4 Buildings**: Sunset Tower, Windy City Plaza, Art Deco Mansion, Desert Oasis Tower
- **6 Floors**: Multiple floors across different buildings

## IP Resources (20 resources)

- **4 Global IP Pools**: US_CORP, US_TECH, US_GUEST, US_BYOD
- **16 IP Pool Reservations**: 4 reservations per site (CORP, TECH, GUEST, BYOD)

## Deployment Notes

All three approaches in the Simple Example scenario deploy this identical infrastructure:
- [NAC Module Approach](nac-catalystcenter-simple-example/README.md)
- [Native Terraform Approach](native-terraform-simple-example/README.md)
- [Native API Approach](native-api-simple-example/README.md)

This allows for direct comparison of code complexity, maintainability, and ease of use between the different approaches.
