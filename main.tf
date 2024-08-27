module "org" {
    source = "git@github.com:pgreene/terraform-aws-organizations-organization.git?ref=1.0.0"
    aws_service_access_principals = [
        "cloudtrail.amazonaws.com",
        "sso.amazonaws.com"
    ]
    feature_set = "ALL"
    enabled_policy_types = [
        "SERVICE_CONTROL_POLICY"
    ]
}

module "org_account" {
    source = "git@github.com:pgreene/terraform-aws-organizations-account.git?ref=1.0.1"
    name = local.org
    email = "ferensick@gmail.com"
    close_on_deletion = true
    create_govcloud = false
    iam_user_access_to_billing = "ALLOW"
    #parent_id = local.account_id
    role_name = local.org
    tags = local.tags
}

module "org_unit" {
    source = "git@github.com:pgreene/terraform-aws-organizations-organizational-unit.git?ref=1.0.1"
    name = local.ou
    parent_id = module.org.roots[0].id
    tags = local.tags
}

module "idstore_group" {
    source = "git@github.com:pgreene/terraform-aws-identitystore-group.git?ref=1.0.0"
    display_name = "admin"
    description = join("-",["identity store group for ", local.ou])
    identity_store_id = tolist(data.aws_ssoadmin_instances.general.identity_store_ids)[0]
}

module "org_policy" {
    source = "git@github.com:pgreene/terraform-aws-organizations-policy.git?ref=1.0.0"
    name = "admin"
    description = join("-",["policy for ", local.ou])
    type = "SERVICE_CONTROL_POLICY"
    content = file("${path.module}/files/role-policy.json")
    #skip_destroy = false
    tags = local.tags
}

module "org_policy_attach" {
    source = "git@github.com:pgreene/terraform-aws-organizations-policy-attachment.git?ref=1.0.0"
    policy_id = module.org_policy.id
    target_id = local.account_id
}

module "route53_zone_something_com" {
    source = "git@github.com:pgreene/terraform-aws-route53-zone.git?ref=1.0.5"
    name = "something.com"
    comment = "Created by terraform"
    tags = local.tags
}

module "aws_route53_record_something_com" {
    source = "git@github.com:pgreene/terraform-aws-route53-record.git?ref=1.0.1"
    for_each = local.dns_records
    records = each.value.records
    name = each.value.name
    zone_id = module.route53_zone_something_com.zone_id
    type = each.value.type
    ttl = each.value.ttl
}
