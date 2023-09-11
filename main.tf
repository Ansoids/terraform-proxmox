terraform {
  required_version = ">= 1.1.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.9.5"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure     = true
  pm_api_url          = var.api_url
  pm_api_token_id     = var.api_token_id
  pm_api_token_secret = var.api_token_secret
  pm_otp              = ""
}

resource "proxmox_vm_qemu" "cloudinit-test" {
  name = "terraform-test-vm"
  desc = "A test for using terraform and cloudinit"

  # Node name has to be the same name as within the cluster
  # this might not include the FQDN
  target_node = "proxmox-server02"

  # The template name to clone this vm from
  clone = var.template_name

  # Activate QEMU agent for this VM
  agent = 1

  os_type = "cloud-init"
  cores   = 2
  sockets = 1
  vcpus   = 0
  cpu     = "host"
  memory  = 2048
  scsihw  = "virtio-scsi-pci"

  # Setup the disk
  disk {
    size     = 32
    type     = "virtio"
    storage  = "local-lvm"
    iothread = 1
    ssd      = 1
    discard  = "on"
  }

  # Setup the network interface and assign a vlan tag: 256
  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = -1
  }

  sshkeys = <<EOF
    
    EOF

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}