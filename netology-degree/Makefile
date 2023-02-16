start: terraform ansible_work

terraform:
	@terraform apply -auto-approve --var-file="degree.tfvars"

ansible_ping:
	@ansible-playbook ./play/play.yml -i inventory.ini --tags ping

ansible_work:
	@ansible-playbook ./play/play.yml -i inventory.ini

del:
	@terraform destroy -auto-approve --var-file="degree.tfvars"

