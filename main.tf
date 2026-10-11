resource "oci_media_services_stream_packaging_config" "media_services_stream_packaging_configs" {
  for_each = var.media_services_stream_packaging_configs

  display_name            = each.value.display_name
  distribution_channel_id = each.value.distribution_channel_id
  segment_time_in_seconds = each.value.segment_time_in_seconds
  stream_packaging_format = each.value.stream_packaging_format
  defined_tags            = each.value.defined_tags
  freeform_tags           = each.value.freeform_tags
  is_lock_override        = each.value.is_lock_override

  dynamic "encryption" {
    for_each = each.value.encryption != null ? [each.value.encryption] : []
    content {
      algorithm  = encryption.value.algorithm
      kms_key_id = encryption.value.kms_key_id
    }
  }

  dynamic "locks" {
    for_each = each.value.locks != null ? each.value.locks : []
    content {
      compartment_id      = locks.value.compartment_id
      message             = locks.value.message
      related_resource_id = locks.value.related_resource_id
      time_created        = locks.value.time_created
      type                = locks.value.type
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

