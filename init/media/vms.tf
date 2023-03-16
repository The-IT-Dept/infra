module "virtual_machine" {
  source = "../../modules/vm-ubuntu-2204"

  pm_api_url = "https://hv01:8006/api2/json"
  pm_api_token_id = "terraform-prov@pve!terraform-prov"
  pm_api_token_secret = data.external.env.result["PM_API_TOKEN_SECRET"]

  machines = local.machines
  template = "ubuntu-2204-cloudinit-template"
  dns_zone = "media.theitdept.au"

  ssh_keys = [
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGhF0XL0hKR8Z97ZvsR8pOfVFPqzJ+5rTlT02s1iNeYFL0kvINgYjC+8SXJq2Vjx2ILvAPF8DhEYfT7BTp1dUIk= nick@npratley.net-1",
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFZG7NHiFmrHIzB8ThHEyKtPZZsKlxcNjD7qy3tCsSFYw+5ZlSswXpsxaRmoubiAZzL2qWUvwI93kI84OC/7Y+k= nick@npratley.net-2"
  ]
}
