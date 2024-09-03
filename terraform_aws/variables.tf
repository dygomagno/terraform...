variable "cluster_name" {default = "eks-cluster"}

variable retention_days {
  type        = number
  default     = 30
  description = "Number of days to retain log events. Default is 30 days."
}
 