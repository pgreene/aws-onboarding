output "arn" {
  value = tolist(data.aws_ssoadmin_instances.general.arns)[0]
}

output "identity_store_id" {
  value = tolist(data.aws_ssoadmin_instances.general.identity_store_ids)[0]
}
