locals {
  is_valid_tier_for_kind = (
    var.account_tier == "Standard" ||
    (var.account_tier == "Premium" && contains(["BlockBlobStorage", "FileStorage"], var.account_kind))
  )
}