terraform {
  backend "s3" {
    bucket = "sctp-ce9-tfstate"
    key    = "norman-ce9-module2-assignment7.tfstate" # Replace the value of key to <your suggested name>.tfstat   
    region = "us-east-1"
  }
}
