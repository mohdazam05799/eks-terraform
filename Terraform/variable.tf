variable "environment" {
  type    = string
  default = "dev"
}

variable "cluster_version" {
  type    = string
  default = "1.25"

}

variable "cluster_service_ipv4_cidr" {
  type    = string
  default = "172.20.0.0/16"

}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true

}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = false

}

variable "cluster_endpoint_public_access_ciders" {
  type    = list(string)
  default = ["0.0.0.0/0"]

}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]

}