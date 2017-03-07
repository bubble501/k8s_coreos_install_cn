echo "###create bootstrap.sh file"
userIP=$1
cp roles/aaron.coreos-bootstrap/files/bootstrap.sh.sample roles/aaron.coreos-bootstrap/files/bootstrap.sh
sed -i "s/USER_IP/${userIP}/g" `grep USER_IP -rl roles/aaron.coreos-bootstrap/files/bootstrap.sh`

echo "###delete context default-cluster "
kubectl config delete-context default-cluster

echo "###create ~/.ssh/config file"
echo -e "StrictHostKeyChecking=no\nUserKnownHostsFile=/dev/null" > ~/.ssh/config


ssh-agent
ssh-add ~/.vagrant.d/insecure_private_key

cd ./coreos-vagrant
echo "###Destroy original coreos vagrant instance..."
vagrant destroy -f
echo "###Create coreos vagrant instance...."
vagrant up

cd ..
sleep  10
echo "### run ansible-playbook -i hosts cluster.yml..."
ansible-playbook -i hosts cluster.yml
