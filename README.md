# Enterprise-Active-Directory-Single-Domain-Multi-Site-Implementation-with-Hyper-V
Project Overview:
This project simulates an enterprise-scale Active Directory deployment across multiple sites using Hyper-V virtualisation. 
The objectives were:

Centralised identity management with a single domain

Multi‑site replication for redundancy and scalability

Integrated DNS and DHCP services for seamless client connectivity

Future‑ready design with options for RODCs, IPAM, and hybrid cloud integration

The lab was built entirely on Hyper‑V, enabling multiple servers and sites to be deployed virtually, without physical hardware.


Project Constraints & Requirements:
Virtualisation: Hyper‑V is used to simulate multiple sites and servers

Domain Design: Single forest, single domain, multiple sites

Replication: Configured for redundancy and site awareness

Networking: DHCP and DNS integrated with AD DS

Scalability: Architecture designed to expand with additional sites or cloud integration


Architecture:
Site A: Primary Domain Controller (DC1), DHCP, DNS

Site B: Secondary Domain Controller (DC2), replication partner

Hyper‑V Hosts: Virtualised servers simulating enterprise topology

Clients: Windows PCs joined to the domain for validation


Configuration Steps:
Active Directory Installation

powershell:
Install-ADDSForest -DomainName "corp.local" -InstallDns
DNS Zone Creation

powershell:
Add-DnsServerPrimaryZone -Name "corp.local" -ReplicationScope Forest
DHCP Scope Setup

powershell:
Add-DhcpServerv4Scope -Name "CorpScope" -StartRange 192.168.10.100 -EndRange 192.168.10.200 -SubnetMask 255.255.255.0
Site/Subnet Definition

powershell:
New-ADReplicationSite -Name "SiteA"
New-ADReplicationSite -Name "SiteB"
New-ADReplicationSubnet -Name "192.168.10.0/24" -Site "SiteA"
Replication Validation

powershell:
repadmin /showrepl
Get-ADReplicationSite

Validation:
Domain Join: Clients successfully joined the corporate network. local

Replication Check: Verified with repadmin /showrepl

DNS Resolution: Tested with nslookup

DHCP Leases: Confirmed with Get-DhcpServerv4Lease

PowerShell Command Library:
powershell:
# Install Active Directory Domain Services
Install-WindowsFeature AD-Domain-Services

# Create new forest and domain
Install-ADDSForest -DomainName "corp.local" -InstallDns

# Add additional domain controller
Install-ADDSDomainController -DomainName "corp.local"

# Configure DNS zone
Add-DnsServerPrimaryZone -Name "corp.local" -ReplicationScope Forest

# Add DHCP scope
Add-DhcpServerv4Scope -Name "CorpScope" -StartRange 192.168.10.100 -EndRange 192.168.10.200 -SubnetMask 255.255.255.0

# Define replication sites
New-ADReplicationSite -Name "SiteA"
New-ADReplicationSite -Name "SiteB"

# Define subnets for sites
New-ADReplicationSubnet -Name "192.168.10.0/24" -Site "SiteA"
New-ADReplicationSubnet -Name "192.168.20.0/24" -Site "SiteB"

# Validate replication
repadmin /showrepl
Get-ADReplicationSite

Future Enhancements:
Read‑Only Domain Controllers (RODCs) for branch offices

IP Address Management (IPAM) integration

Hybrid Cloud: Extend AD DS to Azure AD for cloud identity sync

Advanced Monitoring: Implement AD replication health checks

✅ Result
A multi‑site Active Directory environment built on Hyper‑V, demonstrating:

Centralised identity management

Redundant replication across sites

Integrated DNS/DHCP services

Scalable enterprise‑style design
