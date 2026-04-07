output "nat_public_ip" {
  description = "Public IP of NAT instance"
  value       = yandex_compute_instance.nat.network_interface[0].nat_ip_address
}

output "public_vm_ip" {
  description = "Public IP of public VM"
  value       = yandex_compute_instance.public_vm.network_interface[0].nat_ip_address
}

output "private_vm_ip" {
  description = "Internal IP of private VM"
  value       = yandex_compute_instance.private_vm.network_interface[0].ip_address
}

output "ssh_to_public" {
  description = "SSH command to connect to public VM"
  value       = "ssh -i ~/.ssh/id_ed25519 ubuntu@${yandex_compute_instance.public_vm.network_interface[0].nat_ip_address}"
}

output "ssh_to_private_via_public" {
  description = "SSH command to connect to private VM via public VM (jump host)"
  value       = "ssh -i ~/.ssh/id_ed25519 -J ubuntu@${yandex_compute_instance.public_vm.network_interface[0].nat_ip_address} ubuntu@${yandex_compute_instance.private_vm.network_interface[0].ip_address}"
}
