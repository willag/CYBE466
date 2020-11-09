This specific ansible playbook is the first playbook to be run that configures the ansible server itself. Before running the command I copy the publickey onto loud@localhost so that it can login to itself. The commands to generate an SSH keypair and then copy the SSH public key are:

ssh-keygen
ssh-copy-id loud@localhost

The password "loud" must be entered when prompted. After the ansible script runs the password for loud is updated.

The 4 linux hostnames must also be added to the /etc/ansible/hosts file before running any ansible scipts. 

Once the above inital setup is done the playbook can then be run with the command: 

ansible-playbook zeus.yml --user loud

Once its keypair has been generated it can be loaded onto other machines with 

ssh-copy-id loud@192.168.100.X

After the public key is copied onto a machine the script for that machine's ansible script can be run with:

ansible-playbook MACHINESCRIPTNAME.yml --user loud

It is also possible to use the --ask-pass and --ask-become-pass options and run the scripts without copying the public key but this requires the installation of another package and in my opinion was less effecient and ideal so I did not use this option when running my scripts. 