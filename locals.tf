locals {
    account_id = "358665735850"
    region = "us-east-1"
    environment = "prod"
    name = "my-aws-org"
    org = "my-aws-org"
    ou = "my-ou"
    created_by = "terraform"
    owner = "prdgreene@gmail.com"
    dns_records = {
        record_a = {   
            records = ["127.0.0.1"]
            name = "www.something.com"
            type = "A"
            ttl = "300"
        },
        record_b = {   
            records = ["127.0.0.1"]
            name = "portal.something.com"
            type = "A"
            ttl = "60"
        }
    }
    tags = {
        environment = local.environment
        org = local.org
        ou = local.ou
        created_by = local.created_by
        owner = local.owner
    }
}

