provider "aws" {
  region     = "eu-west-1"
assume_role {
    role_arn = "arn:aws:iam::551034314098:role/GithubAccessRole"
  }
}
