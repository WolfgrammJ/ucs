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
