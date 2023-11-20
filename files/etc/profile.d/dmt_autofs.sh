#!/bin/bash

# check if user is a domain user
if id -nG "$USER" | grep -qw "Domain Users"; then
  # Create autofs map file in user's home directory (temporary)
  echo "$USER -fstype=nfs4,rw 10.10.0.21:/volume1/RedirectedFolders/$USER" > ~/.auto.user

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
rm -f ~/auto.damantec

# check if user is member of group "g-share-damantec"
if id -nG "$USER" | grep -qw "g-share-damantec"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "damantec -fstype=nfs4,rw 10.10.0.21:/volume1/share_damantec" >> ~/.auto.damantec
fi

# check if user is member of group "g-share-knowledge"
if id -nG "$USER" | grep -qw "g-share-knowledge"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "knowledge -fstype=nfs4,rw 10.10.0.21:/volume1/share_knowledge" >> ~/.auto.damantec
fi

# check if user is member of group "g-share-development"
if id -nG "$USER" | grep -qw "g-share-development"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "development -fstype=nfs4,rw 10.10.0.21:/volume1/share_development" >> ~/.auto.damantec
fi

# check if user is member of group "g-share-multimedia"
if id -nG "$USER" | grep -qw "g-share-multimedia"; then
  # Add key to autofs map file in user's home directory (temporary)
  echo "multimedia -fstype=nfs4,rw 10.10.0.21:/volume1/share_multimedia" >> ~/.auto.damantec
fi

# Move file to final destination
sudo mv -f ~/.auto.damantec /etc/auto.damantec