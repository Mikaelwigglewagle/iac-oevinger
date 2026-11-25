variable "name_prefix" {
  type = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,40}$", var.name_prefix))
    error_message = "name_prefix kan bare inneholde små bokstaver, tall og bindestrek."
  }
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "ssh_source_prefix" {
  type        = string
  description = "Hvor SSH (port 22) er tillatt fra. Aldri '*' ."
  default     = "VirtualNetwork"
}
