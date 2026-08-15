module "rg_name" {
  source  = "../child/resource_group"
  rg_name = var.rg_name
}

module "ravistg" {
  depends_on = [module.rg_name]
  source     = "../child/Storage_account"
  ravistg    = var.ravistg
}

module "ravi_vnet" {
  depends_on = [module.ravistg]
  source     = "../child/vnet"
  ravivnet   = var.ravivnet
}

module "rg_subnet" {
  depends_on = [module.ravi_vnet]
  source     = "../child/subnet"
  rg_subnet  = var.rg_subnet
}

module "rg_nic" {
  depends_on = [module.rg_subnet]
  source     = "../child/nic"
  rg_nic     = var.rg_nic
  subnet_ids = module.rg_subnet.subnet_ids
}

module "rgtcsvm" {
  depends_on = [module.rg_nic]
  source     = "../child/virtual_machine"
  rgtcsvm    = var.rgtcsvm
}