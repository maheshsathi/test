terraform {
  backend "s3" {
    bucket = "tfstatefilestorebucket"
    key    = "tf/terraform.tfstate"
  }
}