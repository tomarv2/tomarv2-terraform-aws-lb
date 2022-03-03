terraform {
  required_version = ">= 1.0.1"
  required_providers {
    aws = {
      version = "~> 3.63"
    }
  }
}

provider "aws" {
  region = var.region
}

module "load_balancer" {
  source = "../../"

  lb_port          = ["80"]
  target_group_arn = ["<target_group_arn>"]
  # ----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
