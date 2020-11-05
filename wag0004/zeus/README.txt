This specific ansible playbook is the first playbook to be run that configures the ansible server itself. This playbook is run with the command: 

ansible-playbook zeus.yml --user loud

After the machine is configured its public key can be generated with:

sshkeygen

Once its keypair has been generated it can be loaded onto other machines with 

ssh-copy-id loud@192.168.100.X