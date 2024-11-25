variable "project_id" {
  type        = string
  description = "project id"
}
variable "region" {
  type        = string
  default     = "us-central1"
  description = "default region to use"
}

variable "services" {
  type    = list(any)
  default = []
}

data "google_client_openid_userinfo" "service_account" {
  provider = google.config
}

data "google_project" "the_project" {
  
}

variable "da_account" {
  type        = string
  description = "Deployment Account"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "project_viewer_roles" {
  description = "customer role to be used for viewer"
  type        = list(string)
  default     = []
}

variable "project_admin_roles" {
  type        = list(string)
  description = "list of roles that are given to admin/developer"
  default     = []
}

variable "default_labels" {
  type = map(string)
  description = "The default labels to assign to resources that support them."
}

variable "my_account_email" {
  type        = string
  default     = ""
  description = "initiative user email account to permitting single user access to resources"
}

variable "intentional_google_oauth_key" {
  type        = string
  description = "This is an inert Google Oauth Key"
  default = "092625-01234567890123456789abcdefghijKL.apps.googleusercontent.com"
}

variable "intentional_aws_access_key" {
  type        = string
  description = "This is an inert AWS Access Key"
  default = "AKIAIOSFODNN7EXAMPLE,o2/+wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

variable "another_intentional_aws_access_key" {
  type        = string
  description = "This is an inert AWS Access Key"
  default = "AKIAIOSFOD4N7EXAMPLE,exampleofakey"
}

variable "intentional_gcp_sa_key" {
  type    = string
  description = "This is an intentional GCP Service Account Key"
  default = "{\"type\": \"service_account\",  \"project_id\": \"PROJECT_ID\",  \"private_key_id\": \"KEY_ID\",  \"private_key\": \"-----BEGIN PRIVATE KEY-----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-----END PRIVATE KEY-----\n\",  \"client_email\": \"SERVICE_ACCOUNT_EMAIL\",  \"client_id\": \"CLIENT_ID\",  \"auth_uri\": \"https://accounts.google.com/o/oauth2/auth\",  \"token_uri\": \"https://accounts.google.com/o/oauth2/token\",  \"auth_provider_x509_cert_url\": \"https://www.googleapis.com/oauth2/v1/certs\",  \"client_x509_cert_url\": \"https://www.googleapis.com/robot/v1/metadata/x509/SERVICE_ACCOUNT_EMAIL\"}"
}
