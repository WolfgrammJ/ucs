sudo apt update
sudo apt install software-properties-common
#sudo apt-add-repository ppa:ansible/ansible
#sudo apt update
sudo apt install ansible
sudo apt install python3-argcomplete

ansible-pull -U https://github.com/WolfgrammJ/ucs.git workstation.yml