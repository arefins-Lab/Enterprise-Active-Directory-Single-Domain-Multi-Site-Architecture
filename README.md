Enterprise Active Directory – Single Domain Multi‑Site Architecture

This project showcases a complete enterprise‑grade Active Directory infrastructure designed and deployed from scratch, featuring a single domain operating across multiple sites with full redundancy, routing, and service integration. The environment replicates real‑world production architecture, including multi‑site replication, DNS/DHCP services, and pfSense‑based network segmentation.

Project Overview
A fully functional Active Directory environment built with:

Multi‑site AD replication (Building - A ↔ Building - B)
AD‑Integrated DNS with forest‑wide replication
DHCP scopes across three subnets
DHCP failover (Load Balance mode)
pfSense routing and gateway segmentation
Additional Domain Controller for redundancy
Complete validation and troubleshooting workflow
All components were deployed manually without templates — designed from first principles to reflect real enterprise architecture.

Network & Infrastructure Design
Subnets
192.168.1.0/24 – Building - A
192.168.2.0/24 – Building - A
192.168.3.0/24 – Building - B

Domain Controllers
DC‑SRV01 – 192.168.1.210 (Primary DC + DNS)
ADC‑SRV01 – 192.168.3.210 (Additional DC + DNS)

DHCP Servers
DHCP‑SRV01 – 192.168.1.215
DHCP‑SRV02 – 192.168.1.220
Mode: Failover (Load Balance)

pfSense Gateways
192.168.1.1 – LAN01
192.168.2.1 – LAN02
192.168.3.1 – LAN03

Key Features
Single domain across multiple sites
AD Sites & Services with subnet mapping
Redundant DNS and domain services
DHCP failover for high availability
pfSense‑based routing between networks
Full documentation, diagrams, scripts, and configs

Validation Performed
repadmin /showrepl – AD replication health
nslookup – DNS resolution
Get-DhcpServerv4Lease – DHCP lease verification
Domain join tests across all subnets
Gateway and inter‑site connectivity tests

Repository Structure
/docs
    architecture-and-ip-plan.txt
    runbook-phase-1.txt
    runbook-phase-2.txt
    services-overview.txt

/configs
    dhcp-scope-plan.txt
    dns-zone-plan.txt
    pfsense-config.xml (coming soon)

/scripts
    *.ps1 – PowerShell automation scripts

/notes
    troubleshooting.txt
    validation-checklist.txt
    architecture-decisions.txt

/diagrams
    enterprise-ad-multi-site-architecture.png

Purpose
This project demonstrates practical, hands‑on experience with:
Enterprise identity infrastructure
Multi‑site network design
Redundancy and high availability
Documentation and automation discipline
Real‑world troubleshooting workflows

Final Observation
This lab architecture and network diagram were designed entirely from scratch without using any templates. Every component of the Active Directory, networking, and multi‑site layout reflects a self‑designed, first‑principles architecture tailored specifically for this implementation.

Original Design: No templates used; the full architecture and diagram are self‑designed from scratch.

