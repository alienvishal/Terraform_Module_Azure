locals{
    rai_policy_content_filter = try(flatten([
        for rai_policy_key, rai_policy in var.rai_policy : [
            for content_filter_key, content_filter in lookup(rai_policy, "content_filter", []) : {
                rai_policy_key = rai_policy_key
                rai_policy = rai_policy
                content_filter = content_filter
                content_filter_key = content_filter_key
            }
        ]
    ]), null)
}