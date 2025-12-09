###############################################################
# Enterprise Active Directory – Single Domain Multi‑Site Setup
# Domain: mylab.test
# Designed entirely from scratch (no templates used)
###############################################################

# -------------------------------------------------------------
# 1. Install AD DS Role
# -------------------------------------------------------------
# Installs the Active Directory Domain Services role on the server
Install-WindowsFeature AD-Domain-Services

# -------------------------------------------------------------
# 2. Create New Forest + Domain
# -------------------------------------------------------------
# This creates the root domain "mylab.test" and installs DNS
Install-ADDSForest -DomainName "mylab.test" -InstallDns -Force

# -------------------------------------------------------------
# 3. Add Additional Domain Controller (ADC)
# -------------------------------------------------------------
# Run this on ADC-SRV01 after joining it to the domain
# Uncomment when running on ADC
# Install-ADDSDomainController -DomainName "mylab.test" -Force

# -------------------------------------------------------------
# 4. Create DNS Primary Zone
# -------------------------------------------------------------
# Ensures DNS is replicated across the forest
Add-DnsServerPrimaryZone -Name "mylab.test" -ReplicationScope Forest

# -------------------------------------------------------------
# 5. Create DHCP Scope (Building A - LAN 01)
# -------------------------------------------------------------
# DHCP-SRV01 → 192.168.1.215
Add-DhcpServerv4Scope `
    -Name "LAN01-Scope" `
    -StartRange 192.168.1.50 `
    -EndRange 192.168.1.200 `
    -SubnetMask 255.255.255.0

# -------------------------------------------------------------
# 6. Create DHCP Scope (Building A - LAN 02)
# -------------------------------------------------------------
# DHCP-SRV02 → 192.168.1.220 (failover partner)
Add-DhcpServerv4Scope `
    -Name "LAN02-Scope" `
    -StartRange 192.168.2.50 `
    -EndRange 192.168.2.200 `
    -SubnetMask 255.255.255.0

# -------------------------------------------------------------
# 7. Create DHCP Scope (Building B - LAN 03)
# -------------------------------------------------------------
Add-DhcpServerv4Scope `
    -Name "LAN03-Scope" `
    -StartRange 192.168.3.50 `
    -EndRange 192.168.3.200 `
    -SubnetMask 255.255.255.0

# -------------------------------------------------------------
# 8. Configure DHCP Failover Between SRV01 & SRV02
# -------------------------------------------------------------
# Uncomment when both DHCP servers are ready
# Add-DhcpServerv4Failover -Name "DHCP-Failover" `
#     -PartnerServer "DHCP-SRV02.mylab.test" `
#     -ScopeId 192.168.1.0,192.168.2.0,192.168.3.0 `
#     -LoadBalancePercent 50

# -------------------------------------------------------------
# 9. Create AD Sites
# -------------------------------------------------------------
# Building A = SiteA
# Building B = SiteB
New-ADReplicationSite -Name "SiteA"
New-ADReplicationSite -Name "SiteB"

# -------------------------------------------------------------
# 10. Map Subnets to Sites
# -------------------------------------------------------------
# LAN 01 → SiteA
New-ADReplicationSubnet -Name "192.168.1.0/24" -Site "SiteA"

# LAN 02 → SiteA
New-ADReplicationSubnet -Name "192.168.2.0/24" -Site "SiteA"

# LAN 03 → SiteB
New-ADReplicationSubnet -Name "192.168.3.0/24" -Site "SiteB"

# -------------------------------------------------------------
# 11. Validate AD Replication
# -------------------------------------------------------------
repadmin /showrepl
Get-ADReplicationSite

# -------------------------------------------------------------
# 12. Validate DNS Resolution
# -------------------------------------------------------------
nslookup mylab.test

# -------------------------------------------------------------
# 13. Validate DHCP Leases
# -------------------------------------------------------------
Get-DhcpServerv4Lease
