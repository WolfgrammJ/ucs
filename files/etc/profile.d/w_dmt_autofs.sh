#!/bin/bash

# check if user is a domain user
if id -nG "$USER" | grep -qw "Domain Users"; then
  # Create autofs map file in user's home directory (temporary)
  echo "$USER -fstype=nfs,vers=3,rw,async,noatime,nodiratime,relatime 10.10.0.21:/volume1/RedirectedFolders/$USER" > ~/.auto.user

  # Move file to final destination
  sudo mv -f ~/.auto.user /etc/auto.user

  # Create symlinks for Documents, Pictures, Videos, Music
  rm -rf ~/Documents
  rm -rf ~/Dokumente
  rm -rf ~/Pictures
  rm -rf ~/Bilder
  rm -rf ~/Videos
  rm -rf ~/Music
  rm -rf ~/Musik
  ln -s /mnt/user/$USER/Documents ~/Documents
  ln -s /mnt/user/$USER/Pictures ~/Pictures
  ln -s /mnt/user/$USER/Videos ~/Videos
  ln -s /mnt/user/$USER/Music ~/Music
fi


# Delete a possibly existing map file in users home before creating an new one
rm -f ~/.auto.damantec
touch ~/.auto.damantec

# check if user is member of group "g-share-damantec"
if id -nG "$USER" | grep -qw "g-share-damantec"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "damantec -fstype=nfs,vers=3,rw,async,noatime,nodiratime,relatime 10.10.0.21:/volume1/share_damantec" >> ~/.auto.damantec
  echo "damantec_win -fstype=cifs,rw,noperm,vers=3.0,credentials=$HOME/.smbcredentials_win ://10.10.0.1/DAMANTEC" >> ~/.auto.damantec

fi

# check if user is member of group "g-share-knowledge"
if id -nG "$USER" | grep -qw "g-share-knowledge"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "knowledge -fstype=nfs,vers=3,rw,async,noatime,nodiratime,relatime 10.10.0.21:/volume1/share_knowledge" >> ~/.auto.damantec
  echo "knowledge_win -fstype=cifs,rw,noperm,vers=3.0,credentials=$HOME/.smbcredentials_win ://10.10.0.1/Knowledge" >> ~/.auto.damantec
fi

# check if user is member of group "g-share-development"
if id -nG "$USER" | grep -qw "g-share-development"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "development -fstype=nfs,vers=3,rw,async,noatime,nodiratime,relatime 10.10.0.21:/volume1/share_development" >> ~/.auto.damantec
  echo "development_win -fstype=cifs,rw,noperm,vers=3.0,credentials=$HOME/.smbcredentials_win ://10.10.0.1/Development" >> ~/.auto.damantec
fi

# check if user is member of group "g-share-multimedia"
if id -nG "$USER" | grep -qw "g-share-multimedia"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "multimedia -fstype=nfs,vers=3,rw,async,noatime,nodiratime,relatime 10.10.0.21:/volume1/share_multimedia" >> ~/.auto.damantec
  echo "multimedia_win -fstype=cifs,rw,noperm,vers=3.0,credentials=$HOME/.smbcredentials_win ://10.10.0.1/Multimedia" >> ~/.auto.damantec
fi

# check if user is member of group "g-share-software"
if id -nG "$USER" | grep -qw "g-share-software"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "software -fstype=nfs,vers=3,rw,async,noatime,nodiratime,relatime 10.10.0.21:/volume1/share_software" >> ~/.auto.damantec
  echo "software_win -fstype=cifs,rw,noperm,vers=3.0,credentials=$HOME/.smbcredentials_win ://10.10.0.1/Software" >> ~/.auto.damantec
fi

# check if user is member of group "g-share-temporaer"
if id -nG "$USER" | grep -qw "g-share-temporaer"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "temporaer -fstype=nfs,vers=3,rw,async,noatime,nodiratime,relatime 10.10.0.21:/volume1/share_temporaer" >> ~/.auto.damantec
  echo "temporaer_win -fstype=cifs,rw,noperm,vers=3.0,credentials=$HOME/.smbcredentials_win ://10.10.0.1/Temporaer" >> ~/.auto.damantec
fi


# create template "$HOME/.smbcredentials_win", if file does not exist
if [ ! -f ~/.smbcredentials_win ]; then
  # Move file to final destination
  touch ~/.smbcredentials_win
  echo "username=" >> ~/.smbcredentials_win
  echo "password=" >> ~/.smbcredentials_win
  echo "domain=ad.damantec.org" >> ~/.smbcredentials_win
  chmod 600 ~/.smbcredentials_win
fi

# check if map file was created, then move it to the final destination
if [ -f ~/.auto.damantec ]; then
  # Move file to final destination
  sudo mv -f ~/.auto.damantec /etc/auto.damantec
fi

sudo systemctl restart autofs