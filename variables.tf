variable "media_services_stream_packaging_configs" {
  description = <<EOT
Map of media_services_stream_packaging_configs, attributes below
Required:
    - display_name
    - distribution_channel_id
    - segment_time_in_seconds
    - stream_packaging_format
Optional:
    - defined_tags
    - freeform_tags
    - is_lock_override
    - encryption (block):
        - algorithm (required)
        - kms_key_id (optional)
    - locks (block):
        - compartment_id (required)
        - message (optional)
        - related_resource_id (optional)
        - time_created (optional)
        - type (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    display_name            = string
    distribution_channel_id = string
    segment_time_in_seconds = number
    stream_packaging_format = string
    defined_tags            = optional(map(string))
    freeform_tags           = optional(map(string))
    is_lock_override        = optional(bool)
    encryption = optional(object({
      algorithm  = string
      kms_key_id = optional(string)
    }))
    locks = optional(list(object({
      compartment_id      = string
      message             = optional(string)
      related_resource_id = optional(string)
      time_created        = optional(string)
      type                = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.media_services_stream_packaging_configs : (
        v.encryption == null || (contains([for v in ["AES128", "AES", "RSA", "NONE"] : lower(v)], lower(v.encryption.algorithm)))
      )
    ])
    error_message = "must be one of: \"AES128\", \"AES\", \"RSA\", \"NONE\""
  }
}

