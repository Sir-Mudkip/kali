#!/usr/bin/bash

set -eoux pipefail

# Testssl
git clone --depth 1 https://github.com/testssl/testssl.sh.git --branch 3.3dev /opt/testssl
chmod +x /opt/testssl/testssl.sh
echo "alias testssl=\"/opt/testssl/testssl.sh\"" > /root/.bashrc.d/testssl.rc

# pip2
wget -q https://bootstrap.pypa.io/pip/2.7/get-pip.py
python2 get-pip.py

# seth
git clone https://github.com/SySS-Research/Seth /opt/seth

# sccmhunter
git clone https://github.com/garrettfoster13/sccmhunter /opt/sccmhunter
python3 -m venv /opt/sccmhunter/venv
/opt/sccmhunter/venv/bin/pip install --no-cache-dir -r /opt/sccmhunter/requirements.txt
echo "alias sccmhunter=\"/opt/sccmhunter/venv/bin/python /opt/sccmhunter/sccmhunter.py\"" > /root/.bashrc.d/sccmhunter.rc

# powerhub
python3 -m venv /opt/powerhub/venv
/opt/powerhub/venv/bin/pip install --no-cache-dir powerhub
install -o root -g root -m 0755 /opt/powerhub/venv/bin/powerhub /usr/local/bin/powerhub

# eavesarp
git clone https://github.com/ImpostorKeanu/eavesarp /opt/eavesarp
python3 -m venv /opt/eavesarp/venv
/opt/eavesarp/venv/bin/pip install --no-cache-dir -r /opt/eavesarp/requirements.txt
echo "alias eavesarp=\"/opt/eavesarp/venv/bin/python /opt/eavesarp/eavesarp.py\"" > /root/.bashrc.d/eavesarp.rc

# netexec
git clone https://github.com/Pennyw0rth/NetExec /opt/NetExec
python3 -m venv /opt/NetExec/venv
/opt/NetExec/venv/bin/pip install --no-cache-dir /opt/NetExec/
install -o root -g root -m 0755 /opt/NetExec/venv/bin/netexec /usr/local/bin/netexec
install -o root -g root -m 0755 /opt/NetExec/venv/bin/nxcdb /usr/local/bin/nxcdb

# dnscan
git clone https://github.com/rbsec/dnscan /opt/dnscan
python3 -m venv /opt/dnscan/venv
/opt/dnscan/venv/bin/pip install --no-cache-dir -r /opt/dnscan/requirements.txt
echo "alias dnsscan=\"/opt/dnscan/venv/bin/python /opt/dnscan/dnscan.py\"" > /root/.bashrc.d/dnsscan.rc

# pre2k
git clone https://github.com/garrettfoster13/pre2k /opt/pre2k
python3 -m venv /opt/pre2k/venv
/opt/pre2k/venv/bin/pip install --no-cache-dir /opt/pre2k/
install -o root -g root -m 0755 /opt/pre2k/venv/bin/pre2k /usr/local/bin/pre2k

# impacket latest
git clone https://github.com/fortra/impacket /opt/impacket
python3 -m venv /opt/impacket/venv
/opt/impacket/venv/bin/pip install --no-cache-dir /opt/impacket/
install -o root -g root -m 0755 /opt/impacket/venv/bin/addcomputer.py /usr/local/bin/addcomputer
install -o root -g root -m 0755 /opt/impacket/venv/bin/atexec.py /usr/local/bin/atexec
install -o root -g root -m 0755 /opt/impacket/venv/bin/changepasswd.py /usr/local/bin/changepasswd
install -o root -g root -m 0755 /opt/impacket/venv/bin/dacledit.py /usr/local/bin/dacledit
install -o root -g root -m 0755 /opt/impacket/venv/bin/dcomexec.py /usr/local/bin/dcomexec
install -o root -g root -m 0755 /opt/impacket/venv/bin/describeTicket.py /usr/local/bin/describeTicket
install -o root -g root -m 0755 /opt/impacket/venv/bin/dpapi.py /usr/local/bin/dpapi
install -o root -g root -m 0755 /opt/impacket/venv/bin/DumpNTLMInfo.py /usr/local/bin/DumpNTLMInfo
install -o root -g root -m 0755 /opt/impacket/venv/bin/esentutl.py /usr/local/bin/esentutl
install -o root -g root -m 0755 /opt/impacket/venv/bin/exchanger.py /usr/local/bin/exchanger
install -o root -g root -m 0755 /opt/impacket/venv/bin/findDelegation.py /usr/local/bin/findDelegation
install -o root -g root -m 0755 /opt/impacket/venv/bin/GetADComputers.py /usr/local/bin/GetADComputers
install -o root -g root -m 0755 /opt/impacket/venv/bin/GetADUsers.py /usr/local/bin/GetADUsers
install -o root -g root -m 0755 /opt/impacket/venv/bin/getArch.py /usr/local/bin/getArch
install -o root -g root -m 0755 /opt/impacket/venv/bin/Get-GPPPassword.py /usr/local/bin/Get-GPPPassword
install -o root -g root -m 0755 /opt/impacket/venv/bin/GetLAPSPassword.py /usr/local/bin/GetLAPSPassword
install -o root -g root -m 0755 /opt/impacket/venv/bin/GetNPUsers.py /usr/local/bin/GetNPUsers
install -o root -g root -m 0755 /opt/impacket/venv/bin/getPac.py /usr/local/bin/getPac
install -o root -g root -m 0755 /opt/impacket/venv/bin/getST.py /usr/local/bin/getST
install -o root -g root -m 0755 /opt/impacket/venv/bin/getTGT.py /usr/local/bin/getTGT
install -o root -g root -m 0755 /opt/impacket/venv/bin/GetUserSPNs.py /usr/local/bin/GetUserSPNs
install -o root -g root -m 0755 /opt/impacket/venv/bin/goldenPac.py /usr/local/bin/goldenPac
install -o root -g root -m 0755 /opt/impacket/venv/bin/karmaSMB.py /usr/local/bin/karmaSMB
install -o root -g root -m 0755 /opt/impacket/venv/bin/keylistattack.py /usr/local/bin/keylistattack
install -o root -g root -m 0755 /opt/impacket/venv/bin/kintercept.py /usr/local/bin/kintercept
install -o root -g root -m 0755 /opt/impacket/venv/bin/lookupsid.py /usr/local/bin/lookupsid
install -o root -g root -m 0755 /opt/impacket/venv/bin/machine_role.py /usr/local/bin/machine_role
install -o root -g root -m 0755 /opt/impacket/venv/bin/mimikatz.py /usr/local/bin/mimikatz
install -o root -g root -m 0755 /opt/impacket/venv/bin/mqtt_check.py /usr/local/bin/mqtt_check
install -o root -g root -m 0755 /opt/impacket/venv/bin/mssqlclient.py /usr/local/bin/mssqlclient
install -o root -g root -m 0755 /opt/impacket/venv/bin/mssqlinstance.py /usr/local/bin/mssqlinstance
install -o root -g root -m 0755 /opt/impacket/venv/bin/net.py /usr/local/bin/net
install -o root -g root -m 0755 /opt/impacket/venv/bin/netview.py /usr/local/bin/netview
install -o root -g root -m 0755 /opt/impacket/venv/bin/ntfs-read.py /usr/local/bin/ntfs-read
install -o root -g root -m 0755 /opt/impacket/venv/bin/ntlmrelayx.py /usr/local/bin/ntlmrelayx
install -o root -g root -m 0755 /opt/impacket/venv/bin/owneredit.py /usr/local/bin/owneredit
install -o root -g root -m 0755 /opt/impacket/venv/bin/ping6.py /usr/local/bin/ping6
install -o root -g root -m 0755 /opt/impacket/venv/bin/ping.py /usr/local/bin/ping
install -o root -g root -m 0755 /opt/impacket/venv/bin/psexec.py /usr/local/bin/psexec
install -o root -g root -m 0755 /opt/impacket/venv/bin/raiseChild.py /usr/local/bin/raiseChild
install -o root -g root -m 0755 /opt/impacket/venv/bin/rbcd.py /usr/local/bin/rbcd
install -o root -g root -m 0755 /opt/impacket/venv/bin/rdp_check.py /usr/local/bin/rdp_check
install -o root -g root -m 0755 /opt/impacket/venv/bin/registry-read.py /usr/local/bin/registry-read
install -o root -g root -m 0755 /opt/impacket/venv/bin/reg.py /usr/local/bin/reg
install -o root -g root -m 0755 /opt/impacket/venv/bin/rpcdump.py /usr/local/bin/rpcdump
install -o root -g root -m 0755 /opt/impacket/venv/bin/rpcmap.py /usr/local/bin/rpcmap
install -o root -g root -m 0755 /opt/impacket/venv/bin/sambaPipe.py /usr/local/bin/sambaPipe
install -o root -g root -m 0755 /opt/impacket/venv/bin/samrdump.py /usr/local/bin/samrdump
install -o root -g root -m 0755 /opt/impacket/venv/bin/secretsdump.py /usr/local/bin/secretsdump
install -o root -g root -m 0755 /opt/impacket/venv/bin/services.py /usr/local/bin/services
install -o root -g root -m 0755 /opt/impacket/venv/bin/smbclient.py /usr/local/bin/smbclient
install -o root -g root -m 0755 /opt/impacket/venv/bin/smbexec.py /usr/local/bin/smbexec
install -o root -g root -m 0755 /opt/impacket/venv/bin/smbserver.py /usr/local/bin/smbserver
install -o root -g root -m 0755 /opt/impacket/venv/bin/sniffer.py /usr/local/bin/sniffer
install -o root -g root -m 0755 /opt/impacket/venv/bin/sniff.py /usr/local/bin/sniff
install -o root -g root -m 0755 /opt/impacket/venv/bin/split.py /usr/local/bin/split
install -o root -g root -m 0755 /opt/impacket/venv/bin/ticketConverter.py /usr/local/bin/ticketConverter
install -o root -g root -m 0755 /opt/impacket/venv/bin/ticketer.py /usr/local/bin/ticketer
install -o root -g root -m 0755 /opt/impacket/venv/bin/tstool.py /usr/local/bin/tstool
install -o root -g root -m 0755 /opt/impacket/venv/bin/wmiexec.py /usr/local/bin/wmiexec
install -o root -g root -m 0755 /opt/impacket/venv/bin/wmipersist.py /usr/local/bin/wmipersist
install -o root -g root -m 0755 /opt/impacket/venv/bin/wmiquery.py /usr/local/bin/wmiquery

# targetted kerberoast
git clone https://github.com/ShutdownRepo/targetedKerberoast /opt/targetedKerberoast
python3 -m venv /opt/targetedKerberoast/venv
/opt/targetedKerberoast/venv/bin/pip install --no-cache-dir -r /opt/targetedKerberoast/requirements.txt
echo "alias targetedKerberoast=\"/opt/targetedKerberoast/venv/bin/python /opt/targetedKerberoast/targetedKerberoast.py\"" > /root/.bashrc.d/targetedKerberoast.rc

# pywhisker
git clone https://github.com/ShutdownRepo/pywhisker /opt/pywhisker
python3 -m venv /opt/pywhisker/venv
/opt/pywhisker/venv/bin/pip install --no-cache-dir /opt/pywhisker/
install -o root -g root -m 0755 /opt/pywhisker/venv/bin/pywhisker /usr/local/bin/pywhisker

# git-dumper
git clone https://github.com/arthaud/git-dumper /opt/git-dumper
python3 -m venv /opt/git-dumper/venv
/opt/git-dumper/venv/bin/pip install --no-cache-dir /opt/git-dumper/
install -o root -g root -m 0755 /opt/git-dumper/venv/bin/git-dumper /usr/local/bin/git-dumper

# bloodyAD
git clone https://github.com/CravateRouge/bloodyAD /opt/bloodyAD
python3 -m venv /opt/bloodyAD/venv
/opt/bloodyAD/venv/bin/pip install --no-cache-dir /opt/bloodyAD/
install -o root -g root -m 0755 /opt/bloodyAD/venv/bin/bloodyAD /usr/local/bin/bloodyAD

# cve-2019-1040-scanner
git clone https://github.com/fox-it/cve-2019-1040-scanner /opt/cve-2019-1040-scanner
echo "alias cve-2019-1040-scanner=\"python3 /opt/cve-2019-1040-scanner/scan.py\"" > /root/.bashrc.d/cve-2019-1040-scanner.rc

# adidnsdump
git clone https://github.com/dirkjanm/adidnsdump /opt/adidnsdump
python3 -m venv /opt/adidnsdump/venv
/opt/adidnsdump/venv/bin/pip install --no-cache-dir /opt/adidnsdump/
install -o root -g root -m 0755 /opt/adidnsdump/venv/bin/adidnsdump /usr/local/bin/adidnsdump

# privexchange
git clone https://github.com/dirkjanm/privexchange /opt/privexchange
python3 -m venv /opt/privexchange/venv
/opt/privexchange/venv/bin/pip install --no-cache-dir -r /opt/privexchange/requirements.txt
echo "alias privexchange=\"/opt/privexchange/venv/bin/python /opt/privexchange/privexchange.py\"" > /root/.bashrc.d/privexchange.rc

# pcredz
git clone https://github.com/lgandx/PCredz /opt/PCredz
DEBIAN_FRONTEND=noninteractive apt update -y
apt install -y libpcap-dev
python3 -m venv /opt/PCredz/venv
/opt/PCredz/venv/bin/pip install --no-cache-dir Cython
/opt/PCredz/venv/bin/pip install --no-cache-dir python-libpcap
echo "alias Pcredz=\"/opt/PCredz/venv/bin/python /opt/PCredz/Pcredz\"" > /root/.bashrc.d/Pcredz.rc

# krbrelayx
git clone https://github.com/dirkjanm/krbrelayx /opt/krbrelayx
python3 -m venv /opt/krbrelayx/venv
/opt/krbrelayx/venv/bin/pip install --no-cache-dir impacket ldap3 dnspython
echo "alias krbrelayx=\"/opt/krbrelayx/venv/bin/python /opt/krbrelayx/krbrelayx.py\"" > /root/.bashrc.d/krbrelayx.rc

# ldaprelayscan
git clone https://github.com/zyn3rgy/LdapRelayScan /opt/LdapRelayScan
python3 -m venv /opt/LdapRelayScan/venv
/opt/LdapRelayScan/venv/bin/pip install --no-cache-dir -r /opt/LdapRelayScan/requirements.txt
echo "alias LdapRelayScan=\"/opt/LdapRelayScan/venv/bin/python /opt/LdapRelayScan/LdapRelayScan.py\"" > /root/.bashrc.d/LdapRelayScan.rc

# passthecert
git clone https://github.com/AlmondOffSec/PassTheCert /opt/PassTheCert
echo "alias passthecert=\"python3 /opt/PassTheCert/Python/passthecert.py\"" > /root/.bashrc.d/PassTheCert.rc

# gittools
git clone https://github.com/internetwache/GitTools /opt/GitTools
install -o root -g root -m 0755 /opt/GitTools/Dumper/gitdumper.sh /usr/local/bin/gitdumper
install -o root -g root -m 0755 /opt/GitTools/Extractor/extractor.sh /usr/local/bin/gitextractor
echo "alias gitfinder=\"python3 /opt/GitTools/Finder/gitfinder.py\"" > /root/.bashrc.d/gitfinder.rc

# pkinittools
git clone https://github.com/dirkjanm/PKINITtools /opt/PKINITtools
python3 -m venv /opt/PKINITtools/venv
/opt/PKINITtools/venv/bin/pip install --no-cache-dir -r /opt/PKINITtools/requirements.txt
echo "alias gettgtpkinit=\"python3 /opt/PKINITtools/gettgtpkinit.py\"" > /root/.bashrc.d/gettgtpkinit.rc
echo "alias getnthash=\"python3 /opt/PKINITtools/getnthash.py\"" > /root/.bashrc.d/getnthash.rc
echo "alias gets4uticket=\"python3 /opt/PKINITtools/gets4uticket.py\"" > /root/.bashrc.d/gets4uticket.rc

# sapito
git clone https://github.com/eldraco/Sapito /opt/Sapito
python3 -m venv /opt/Sapito/venv
/opt/Sapito/venv/bin/pip install --no-cache-dir -r /opt/Sapito/requirements.txt
echo "alias sapito=\"python3 /opt/Sapito/sapito.py\"" > /root/.bashrc.d/sapito.rc

# pgexec
git clone https://github.com/Dionach/pgexec /opt/pgexec
install -o root -g root -m 0755 /opt/pgexec/pg_exec.sh /usr/local/bin/pg_exec

# jexboss
git clone https://github.com/joaomatosf/jexboss /opt/jexboss
python3 -m venv /opt/jexboss/venv
/opt/jexboss/venv/bin/pip install --no-cache-dir -r /opt/jexboss/requires.txt
echo "alias jexboss=\"python3 /opt/jexboss/jexboss.py\"" > /root/.bashrc.d/jexboss.rc

# jwt_tool
git clone https://github.com/ticarpi/jwt_tool /opt/jwt_tool
python3 -m venv /opt/jwt_tool/venv
/opt/jwt_tool/venv/bin/pip install --no-cache-dir -r /opt/jwt_tool/requirements.txt
echo "alias jwt_tool=\"python3 /opt/jwt_tool/jwt_tool.py\"" > /root/.bashrc.d/jwt_tool.rc

# Linkedin Dumper
git clone https://github.com/l4rm4nd/LinkedInDumper /opt/linkedin-dumper
python3 -m venv /opt/linkedin-dumper/venv
/opt/linkedin-dumper/venv/bin/pip install --no-cache-dir --no-cache-dir -r /opt/linkedin-dumper/requirements.txt
echo "alias linkedin-dumper=\"/opt/linkedin-dumper/venv/bin/python /opt/linkedin-dumper/linkedindumper.py\"" > /root/.bashrc.d/linkedin-dumper.rc

# NoPrompt
git clone "https://github.com/NotSoSecure/NoPrompt" /opt/NoPrompt
python3 -m venv /opt/NoPrompt/venv
/opt/NoPrompt/venv/bin/pip install --no-cache-dir -r /opt/NoPrompt/requirements.txt
echo "alias noprompt=\"/opt/NoPrompt/venv/bin/python /opt/NoPrompt/noprompt.py\"" > /root/.bashrc.d/noprompt.rc

# caReports
git clone "https://github.com/uniQuk/caReports" /opt/caReports

# CAPs
git clone "https://github.com/techBrandon/CAPs" /opt/CAPs

# binaries
wget -q https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 -O /opt/kerbrute && \
install -o root -g root -m 0755 /opt/kerbrute /usr/local/bin/kerbrute

wget -q https://github.com/ropnop/go-windapsearch/releases/download/v0.3.0/windapsearch-linux-amd64 -O /opt/windapsearch && \
install -o root -g root -m 0755 /opt/windapsearch /usr/local/bin/windapsearch

wget -q https://github.com/sensepost/gowitness/releases/download/2.5.1/gowitness-2.5.1-linux-amd64 -O /opt/gowitness && \
install -o root -g root -m 0755 /opt/gowitness /usr/local/bin/gowitness

wget -q https://github.com/hdm/nextnet/releases/download/v0.0.2/nextnet_0.0.2_linux_amd64.tar.gz -O /opt/nextnet_0.0.2_linux_amd64.tar.gz

wget -q https://github.com/liamg/traitor/releases/download/v0.0.14/traitor-amd64 -O /opt/traitor && \
install -o root -g root -m 0755 /opt/traitor /usr/local/bin/traitor

wget -q https://github.com/lkarlslund/ldapnomnom/releases/download/v1.3.0/ldapnomnom-linux-x64 -O /opt/ldapnomnom && \
install -o root -g root -m 0755 /opt/ldapnomnom /usr/local/bin/ldapnomnom

wget -q https://github.com/Chocapikk/wpprobe/releases/download/v0.8.0/wpprobe_v0.8.0_linux_amd64 -O /opt/wpprobe && \
install -o root -g root -m 0755 /opt/wpprobe /usr/local/bin/wpprobe

wget -q https://github.com/antonioCoco/RunasCs/releases/download/v1.5/RunasCs.zip -O /opt/RunasCs.zip

# Haiti Hash
gem install haiti-hash

# Nuclei Update
nuclei -ut
