resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory.ini"

  content = <<EOT
[k3s_master]
${split("/", var.vms["master"].ip_vmbr0)[0]} ansible_host=${split("/", var.vms["master"].ip_vmbr0)[0]} node_ip=${split("/", var.vms["master"].ip_vmbr1)[0]}

[k3s_worker]
${split("/", var.vms["worker"].ip_vmbr0)[0]} ansible_host=${split("/", var.vms["worker"].ip_vmbr0)[0]} node_ip=${split("/", var.vms["worker"].ip_vmbr1)[0]}
${split("/", var.vms["monitoring"].ip_vmbr0)[0]} ansible_host=${split("/", var.vms["monitoring"].ip_vmbr0)[0]} node_ip=${split("/", var.vms["monitoring"].ip_vmbr1)[0]}

[all:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOT
}