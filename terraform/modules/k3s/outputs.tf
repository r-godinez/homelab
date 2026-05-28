# VM Metadata Output
output "vm_info" {
  value = {
    for name, vm in proxmox_virtual_environment_vm.vm :
    name => {
      name  = vm.name
      vm_id = vm.vm_id
      node  = vm.node_name
    }
  }
}

# VM IP Addresses Output
# output "vm_ips" {
#   value = {
#     for name, vm in proxmox_virtual_environment_vm.vm :
#     name => vm.ipv4_addresses
#   }
# }

output "vm_ips" {
  value = {
    for name, vm in proxmox_virtual_environment_vm.vm :
    name => [
      for ip_group in vm.ipv4_addresses :
      ip_group
      if length(vm.ipv4_addresses) > 0
    ]
  }
}

# SSH Command Output
# output "ssh_commands" {
#   value = {
#     for name, vm in proxmox_virtual_environment_vm.vm :
#     name => length(flatten(vm.ipv4_addresses)) > 0 ?
#       "ssh ubuntu@${flatten(vm.ipv4_addresses)[0]}" :
#       "IP not available"
#   }
# }
output "ssh_commands" {
  value = {
    for name, vm in var.vms :
    name => "ssh ubuntu@${split("/", vm.ip_vmbr0)[0]}"
  }
}

output "master_ip" {
  value = proxmox_virtual_environment_vm.vm["master"].ipv4_addresses[0][0]
}

output "worker_ip" {
  value = proxmox_virtual_environment_vm.vm["worker"].ipv4_addresses[0][0]
}

output "monitoring_ip" {
  value = proxmox_virtual_environment_vm.vm["monitoring"].ipv4_addresses[0][0]
}