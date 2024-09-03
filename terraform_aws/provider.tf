//config. para não limitar a ultilização de outros usuários 

terraform {
  required_version = ">=1.9.2"
  required_providers {
    aws = ">=5.61.0"
    local = ">=2.5.1"
  }
}

  provider "aws"{
    region = "us-east-1"
  }
