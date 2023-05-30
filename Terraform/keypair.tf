resource "aws_key_pair" "EKS" {
  key_name   = "EKS"
  public_key = file("${path.module}/id_rsa.pub")

}