sudo apt update
sudo apt install software-properties-common -y
#sudo apt-add-repository ppa:ansible/ansible
#sudo apt update
sudo apt install ansible -y
sudo apt install python3-argcomplete -y

ansible-pull -U https://github.com/WolfgrammJ/ucs.git workstation.yml --checkout main