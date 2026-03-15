locals {
  access_policy_config = flatten([
    for i, policy in var.access_policy : [
      for object_ids in policy.object_id : {
        object_ids              = object_ids
        key_permissions         = policy.key_permissions
        secret_permissions      = policy.secret_permissions
        certificate_permissions = policy.certificate_permissions
        storage_permissions     = policy.storage_permissions
      }
    ]
  ])
}