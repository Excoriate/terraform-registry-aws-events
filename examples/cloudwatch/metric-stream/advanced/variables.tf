variable "is_enabled" {
  type        = bool
  description = <<-DESC
  Whether this module will be created or not. It is useful for stack-composite
  modules that conditionally include resources provided by this module.
  DESC
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}
