To run the ansible script for the machine the public key for zeus (or whatever machine is being used to run the script) needs to be copied onto hades. The other initial setup described in the zeus readme also is assumed to be done such as configuring the /etc/ansible/hosts file. 

ssh-copy-id loud@192.168.100.3

If the machine executing the ansible script does not have an SSH key it can be generated with:

ssh-keygen

After the public key is copied onto a machine the script for that machine's ansible script can be run with:

ansible-playbook hades.yml --user loud

It is also possible to use the --ask-pass and --ask-become-pass options and run the scripts without copying the public key but this requires the installation of another package and in my opinion was less effecient and ideal so I did not use this option when running my scripts. 