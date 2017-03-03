ssh-agent
ssh-add ~/.vagrant.d/insecure_private_key

cd ./coreos-vagrant
vagrant destroy -f
vagrant up

cd ..
sleep  10
ansible-playbook -i hosts cluster.yml
