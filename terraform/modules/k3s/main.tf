resource "proxmox_virtual_environment_vm" "vm" {
  for_each = var.vms

  name      = each.value.name
  node_name = var.target_node

  agent {
    enabled = true
  }

  clone {
    vm_id = var.template_vm_id
  }

  cpu {
    cores = each.value.cores
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }

  network_device {
    bridge = "vmbr1"
  }

  initialization {
    datastore_id = "local-lvm"

  ip_config {
    ipv4 {
      address = each.value.ip_vmbr0
      gateway = "192.168.0.1"
    }
  }

  ip_config {
    ipv4 {
      address = each.value.ip_vmbr1
      gateway = null 

    }
  }

    user_account {
      username = "ubuntu"
      keys     = [file(var.ssh_public_key)]
    }
  }
}