# go-terratest-gce-example

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| disk\_size | Disk size for root instance in GB | string | `"25"` | no |
| disk\_type | Disk type for root instance | string | `"pd-standard"` | no |
| environment | Identifier for environment, use for label and tag | string | `"dev"` | no |
| host\_target | Identifier for host target (currently we use value of squad name), use for label and tag | string | `"devops"` | no |
| image\_name | Name of base image to be reolled out for instance | string | n/a | yes |
| instance\_name | Instance name identifier, so everyone can recognise it easily | string | n/a | yes |
| ip\_forward | Enable or disable ip_forward | string | `"false"` | no |
| machine\_type | Machine type of instance | string | n/a | yes |
| node\_count | Count of node to create | string | `"1"` | no |
| project | Project id to create the node on | string | n/a | yes |
| service\_group | Identifier for service group, use for label and tag | string | `"terratest"` | no |
| service\_type | Identifier for service type, use for label and tag | string | `"test"` | no |
| shared\_project | Location of shared project | string | n/a | yes |
| subnetwork | Subnetwork where VPC and networking related project run | string | n/a | yes |
| subnetwork\_project | ProjectID where the networking related resource running | string | n/a | yes |
| zones | GCP zone to rollout the image | list | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| environment |  |
| host\_target |  |
| rrdatas |  |
| service\_group |  |
| service\_type |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --
