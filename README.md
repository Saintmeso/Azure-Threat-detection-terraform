# Azure Honeypot & Threat Detection Using Terraform

## Overview

This project focuses on deploying an intentionally exposed Azure environment using Terraform (Infrastructure as Code) to explore internet-based threats and security monitoring.

The goal was to understand how exposed cloud resources can become targets and how Azure services can be used to collect, centralize, and investigate security events.

## Technologies Used

- **Terraform** – Infrastructure as Code
- **Microsoft Azure** – Cloud infrastructure
- **Azure Virtual Machines** – Hosted the exposed Windows machine
- **Azure Virtual Network** – Network infrastructure
- **Network Security Groups (NSGs)** – Network traffic filtering
- **Azure Monitor Agent (AMA)** – Security event collection
- **Data Collection Rules (DCRs)** – Configured log collection
- **Log Analytics Workspace** – Centralized log storage and analysis
- **Microsoft Sentinel** – SIEM and security investigation
- **KQL** – Security log queries

## Project Implementation

1. Used Terraform to provision the required Azure infrastructure.
2. Deployed a Windows virtual machine with a public IP address.
3. Configured networking and Network Security Group rules to expose the test environment.
4. Installed and configured Azure Monitor Agent.
5. Created Data Collection Rules to collect Windows security events.
6. Connected the collected logs to a Log Analytics Workspace.
7. Integrated Microsoft Sentinel for security monitoring and investigation.
8. Used KQL to query and analyze collected security events.

## Testing & Results

Generated and analyzed Windows security events to verify that log collection was working correctly.

Events investigated included:

- **Event ID 4625:** Failed login attempts.
- **Event ID 4624:** Successful logins.
- **Event ID 4672:** Special privilege assignments.

Successfully verified the collection of:

- 12 failed login events
- 3 successful login events
- 3 privilege-related events

## What I Learned

Through this project, I gained hands-on experience with:

- Automating Azure infrastructure deployments using Terraform.
- Understanding how exposed cloud resources can attract unwanted traffic.
- Configuring Azure Monitor Agent and Data Collection Rules.
- Centralizing Windows security logs in Log Analytics.
- Using Microsoft Sentinel to investigate security events.
- Writing KQL queries to identify authentication and privilege-related activity.

## Repository Structure

```text
Azure-Honeypot-Terraform/
│
├── main.tf
├── variables.tf
├── monitoring.tf
├── providers.tf
├── sentinel.tf
├── screenshots/
├──sentinel_monitoring.tf
└── README.md
```

## Disclaimer

This project was created for educational and security research purposes. Intentionally exposing cloud infrastructure to the internet carries security and financial risks. Deployments should use appropriate isolation, access restrictions, monitoring, and resource cleanup.
