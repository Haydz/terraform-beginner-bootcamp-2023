variable "user_uuid" {
  type        = string
  description = "The UUID of the user"

  validation {
    condition     = can(regex("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[4][a-fA-F0-9]{3}-[89aAbB][a-fA-F0-9]{3}-[a-fA-F0-9]{12}$", var.user_uuid))
    error_message = "The user_uuid must be a valid UUID. Example format: 123e4567-e89b-12d3-a456-426614174000."
  }
}
