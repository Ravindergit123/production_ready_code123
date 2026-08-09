module "rg_name" {
  source      = "../child/resource_group"
  rg_name     = var.rg_name
  environment = local.environment
  tags        = local.common_tags
}

module "ravistg" {
  depends_on  = [module.rg_name]
  source      = "../child/Storage_account"
  ravistg     = var.ravistg
  environment = local.environment
  tags        = local.common_tags
}

module "ravi_vnet" {
  depends_on  = [module.ravistg]
  source      = "../child/vnet"
  ravivnet    = var.ravivnet
  environment = local.environment
  tags        = local.common_tags
}

module "rg_subnet" {
  depends_on = [module.ravi_vnet]
  source     = "../child/subnet"
  rg_subnet  = var.rg_subnet
}

module "rg_nic" {
  depends_on  = [module.rg_subnet]
  source      = "../child/nic"
  rg_nic      = var.rg_nic
  environment = local.environment
  tags        = local.common_tags
}

module "rgtcsvm" {
  depends_on  = [module.rg_nic]
  source      = "../child/virtual_machine"
  rgtcsvm     = var.rgtcsvm
  environment = local.environment
  tags        = local.common_tags
}