<p align="center">
    <a href="https://github.com/tomarv2/terraform-google-network/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-google-network/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-aws-lb" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-lb/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-lb" /></a>
    <a href="https://github.com/tomarv2/terraform-aws-lb/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-aws-lb" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://discord.gg/XH975bzN" alt="chat on Discord">
        <img src="https://img.shields.io/discord/813961944443912223?logo=discord"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

# Terraform module to create AWS Load Balancer

## Versions

- Module tested for Terraform 1.0.1.
- AWS provider version [3.47.0](https://registry.terraform.io/providers/hashicorp/aws/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases.
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-aws-lb/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-aws-lb" /></a>).

## Usage

### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

### Option 2:

#### Recommended method (stores remote state in S3 using `prjid` and `teamid` to create directory structure):

- Create python 3.6+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote --upgrade
```

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export TF_AWS_PROFILE=<profile from ~/.ws/credentials>
```

or

- Set below environment variables:
```
export TF_AWS_BUCKET=<remote state bucket name>
export TF_AWS_BUCKET_REGION=us-west-2
export AWS_ACCESS_KEY_ID=<aws_access_key_id>
export AWS_SECRET_ACCESS_KEY=<aws_secret_access_key>
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -c=aws plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=aws apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=aws destroy -var='teamid=foo' -var='prjid=bar'
```

**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)
---

##### Network Load Balancer

```
module "load_balancer" {
  source                      = "../"

  account_id                  = "123456789012"
  aws_region                  = "us-west-2"
  lb_port                     = ["22", "80", "443"]
  target_group_arn            = "target_group_arn"
  # ----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid                      = var.teamid
  prjid                       = var.prjid
}
```

Please refer to examples directory [link](examples) for references.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.47 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.47.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_global"></a> [global](#module\_global) | git::git@github.com:tomarv2/terraform-global.git//aws | v0.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | aws account id | `string` | n/a | yes |
| <a name="input_alb_cert_arn"></a> [alb\_cert\_arn](#input\_alb\_cert\_arn) | application load balancer certificate arn | `string` | `""` | no |
| <a name="input_alb_ssl_policy"></a> [alb\_ssl\_policy](#input\_alb\_ssl\_policy) | application load balancer ssl policy | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to create resources | `string` | `"us-west-2"` | no |
| <a name="input_is_public"></a> [is\_public](#input\_is\_public) | load balancer public or private | `string` | `"false"` | no |
| <a name="input_lb_action_type"></a> [lb\_action\_type](#input\_lb\_action\_type) | load balancer action type | `string` | `"forward"` | no |
| <a name="input_lb_port"></a> [lb\_port](#input\_lb\_port) | load balancer port | `list(any)` | <pre>[<br>  80<br>]</pre> | no |
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | load balancer protocol | `string` | `"HTTP"` | no |
| <a name="input_lb_type"></a> [lb\_type](#input\_lb\_type) | load balancer type | `string` | `"application"` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_profile_to_use"></a> [profile\_to\_use](#input\_profile\_to\_use) | Getting values from ~/.aws/credentials | `string` | `"default"` | no |
| <a name="input_security_groups_to_use"></a> [security\_groups\_to\_use](#input\_security\_groups\_to\_use) | Security groups to use | `list(any)` | `[]` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | target group arn | `list(any)` | n/a | yes |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | arn of the load balancer |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | load balancer id |
| <a name="output_lb_listener"></a> [lb\_listener](#output\_lb\_listener) | load balancer listener |
| <a name="output_lb_type"></a> [lb\_type](#output\_lb\_type) | load balancer type |
| <a name="output_lb_zoneid"></a> [lb\_zoneid](#output\_lb\_zoneid) | zone id of the load balancer |

