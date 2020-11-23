 #!/bin/bash

cd ~/cne-sfia2-brief/terraform
terraform init
terraform plan
terraform apply -auto-approve

export ip="$(terraform output ec2_ip)"

sleep 30

cd ~/cne-sfia2-brief/ansible
ansible-playbook -i ${ip}, playbook.yaml

sleep 60
ssh -tt -i /home/ubuntu/.ssh/id_rsa ubuntu@${ip}

