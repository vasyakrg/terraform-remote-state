data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "indigo-medium-242214-tf-state-prod"
    prefix = "network"
  }
}
