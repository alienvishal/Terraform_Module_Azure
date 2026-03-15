locals {
  sbus_subscription = try(flatten([
    for topic_key, topic in var.topics : [
      for sub_key, sub in lookup(topic, "subscriptions", []) : {
        topic_key = topic_key
        topic     = topic
        sub_key   = sub_key
        sub       = sub
      }
    ]
  ]), null)
}