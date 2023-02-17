start: terraform ansible_work

terraform:
	@terraform apply -auto-approve --var-file="degree.tfvars"

ansible_work:
	@ansible-playbook ./play/play.yml -i inventory.ini 

del:
	@terraform destroy -auto-approve --var-file="degree.tfvars"