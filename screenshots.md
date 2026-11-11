# These are some screenshots of the development phase, as well as the creation process of this project and the configurations behind it.

Turning off windows firewall rules:
I did this intentionally to make this vm far much more intciing to be attacked by hackers.
Seeing a exposed VM with a name like "Cloud VM" would make people wonder what could potentially be inside but in reality it is just a honeypot.

<img width="401" height="457" alt="AZ-Terraform WDFAS Profile off" src="https://github.com/user-attachments/assets/1d129e1a-0770-48a4-af05-bfe844da98b4" />


Ping Check:
After turning off the Windows Firewall profiles and setting up the NSG Rules, I wanted to ensure that the VM was reachable via my own machine.

<img width="1110" height="620" alt="AZ-Terraform Ping Check" src="https://github.com/user-attachments/assets/71dbf742-8785-4117-87d3-8d70471f1fe9" />

Attack Proof / Documentation:
After about 15 Minutes after deploying the honeypot and allowing access to it over every port, I was able to recieve all these attempted logs via event ID's 4625,4624, and 4672.

<img width="1280" height="1257" alt="AZ-Terraform MC Sentinel Logs v2 chart" src="https://github.com/user-attachments/assets/7b7600fa-cf9d-4357-8243-d14574def9dd" />
