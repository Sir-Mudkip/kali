FROM docker.io/kalilinux/kali-rolling

ENV SHELL=/bin/bash
ENV LANG=en_GB.UTF-8

COPY ./config/bashrc /root/.bashrc
COPY ./config/aliases /root/.bashrc.d/
COPY ./config/bash-color-prompt.sh /etc/profile.d/
COPY ./config/nvim /root/.config/nvim
COPY ./config/tmux.conf /root/.tmux.conf
COPY ./config/tmux/ /root/.tmux/

RUN echo "set completion-ignore-case On" >> /etc/inputrc

COPY tools /

# install packages
RUN apt update && \
    apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt -y install \
        $(cat tools | xargs) && \
    rm -rd /var/lib/apt/lists/*

# locales
RUN sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_GB.UTF-8

# hide login banner
RUN touch ~/.hushlogin

COPY Brewfile /

# homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN /home/linuxbrew/.linuxbrew/bin/brew bundle --file=/Brewfile 
RUN /home/linuxbrew/.linuxbrew/bin/brew unlink util-linux

# pip2
RUN wget -q https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
    python2 get-pip.py

WORKDIR /opt/
# seth
RUN git clone https://github.com/SySS-Research/Seth

# john the ripper
RUN git clone https://github.com/openwall/john -b bleeding-jumbo /opt/john
WORKDIR /opt/john/src
RUN /opt/john/src/configure && \
    make -s clean && \
    make -sj4 && \
    echo "alias john=\"/opt/john/run/john\"" > /root/.bashrc.d/john.rc

# sccmhunter
RUN git clone https://github.com/garrettfoster13/sccmhunter /opt/sccmhunter && \
    python3 -m venv /opt/sccmhunter/venv && \
    /opt/sccmhunter/venv/bin/pip install -r /opt/sccmhunter/requirements.txt && \
    echo "alias sccmhunter=\"/opt/sccmhunter/venv/bin/python /opt/sccmhunter/sccmhunter.py\"" > /root/.bashrc.d/sccmhunter.rc

# powerhub
RUN python3 -m venv /opt/powerhub/venv && \
    /opt/powerhub/venv/bin/pip install powerhub && \
    install -o root -g root -m 0755 /opt/powerhub/venv/bin/powerhub /usr/local/bin/powerhub

# eavesarp
RUN git clone https://github.com/ImpostorKeanu/eavesarp /opt/eavesarp && \
    python3 -m venv /opt/eavesarp/venv && \
    /opt/eavesarp/venv/bin/pip install -r /opt/eavesarp/requirements.txt && \
    echo "alias eavesarp=\"/opt/eavesarp/venv/bin/python /opt/eavesarp/eavesarp.py\"" > /root/.bashrc.d/eavesarp.rc

# netexec
RUN git clone https://github.com/Pennyw0rth/NetExec /opt/NetExec && \
    python3 -m venv /opt/NetExec/venv && \
    /opt/NetExec/venv/bin/pip install /opt/NetExec/ && \
    install -o root -g root -m 0755 /opt/NetExec/venv/bin/netexec /usr/local/bin/netexec && \
    install -o root -g root -m 0755 /opt/NetExec/venv/bin/nxcdb /usr/local/bin/nxcdb

# dnscan
RUN git clone https://github.com/rbsec/dnscan /opt/dnscan && \
    python3 -m venv /opt/dnscan/venv && \
    /opt/dnscan/venv/bin/pip install -r /opt/dnscan/requirements.txt && \
    echo "alias dnsscan=\"/opt/dnscan/venv/bin/python /opt/dnscan/dnscan.py\"" > /root/.bashrc.d/dnsscan.rc

# pre2k
RUN git clone https://github.com/garrettfoster13/pre2k /opt/pre2k && \
    python3 -m venv /opt/pre2k/venv && \
    /opt/pre2k/venv/bin/pip install /opt/pre2k/ && \
    install -o root -g root -m 0755 /opt/pre2k/venv/bin/pre2k /usr/local/bin/pre2k

# impacket latest
RUN git clone https://github.com/fortra/impacket /opt/impacket && \
    python3 -m venv /opt/impacket/venv && \
    /opt/impacket/venv/bin/pip install /opt/impacket/ && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/addcomputer.py /usr/local/bin/addcomputer && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/atexec.py /usr/local/bin/atexec && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/changepasswd.py /usr/local/bin/changepasswd && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/dacledit.py /usr/local/bin/dacledit && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/dcomexec.py /usr/local/bin/dcomexec && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/describeTicket.py /usr/local/bin/describeTicket && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/dpapi.py /usr/local/bin/dpapi && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/DumpNTLMInfo.py /usr/local/bin/DumpNTLMInfo && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/esentutl.py /usr/local/bin/esentutl && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/exchanger.py /usr/local/bin/exchanger && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/findDelegation.py /usr/local/bin/findDelegation && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/GetADComputers.py /usr/local/bin/GetADComputers && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/GetADUsers.py /usr/local/bin/GetADUsers && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/getArch.py /usr/local/bin/getArch && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/Get-GPPPassword.py /usr/local/bin/Get-GPPPassword && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/GetLAPSPassword.py /usr/local/bin/GetLAPSPassword && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/GetNPUsers.py /usr/local/bin/GetNPUsers && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/getPac.py /usr/local/bin/getPac && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/getST.py /usr/local/bin/getST && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/getTGT.py /usr/local/bin/getTGT && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/GetUserSPNs.py /usr/local/bin/GetUserSPNs && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/goldenPac.py /usr/local/bin/goldenPac && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/karmaSMB.py /usr/local/bin/karmaSMB && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/keylistattack.py /usr/local/bin/keylistattack && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/kintercept.py /usr/local/bin/kintercept && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/lookupsid.py /usr/local/bin/lookupsid && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/machine_role.py /usr/local/bin/machine_role && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/mimikatz.py /usr/local/bin/mimikatz && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/mqtt_check.py /usr/local/bin/mqtt_check && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/mssqlclient.py /usr/local/bin/mssqlclient && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/mssqlinstance.py /usr/local/bin/mssqlinstance && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/net.py /usr/local/bin/net && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/netview.py /usr/local/bin/netview && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/ntfs-read.py /usr/local/bin/ntfs-read && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/ntlmrelayx.py /usr/local/bin/ntlmrelayx && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/owneredit.py /usr/local/bin/owneredit && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/ping6.py /usr/local/bin/ping6 && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/ping.py /usr/local/bin/ping && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/psexec.py /usr/local/bin/psexec && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/raiseChild.py /usr/local/bin/raiseChild && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/rbcd.py /usr/local/bin/rbcd && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/rdp_check.py /usr/local/bin/rdp_check && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/registry-read.py /usr/local/bin/registry-read && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/reg.py /usr/local/bin/reg && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/rpcdump.py /usr/local/bin/rpcdump && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/rpcmap.py /usr/local/bin/rpcmap && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/sambaPipe.py /usr/local/bin/sambaPipe && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/samrdump.py /usr/local/bin/samrdump && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/secretsdump.py /usr/local/bin/secretsdump && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/services.py /usr/local/bin/services && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/smbclient.py /usr/local/bin/smbclient && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/smbexec.py /usr/local/bin/smbexec && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/smbserver.py /usr/local/bin/smbserver && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/sniffer.py /usr/local/bin/sniffer && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/sniff.py /usr/local/bin/sniff && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/split.py /usr/local/bin/split && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/ticketConverter.py /usr/local/bin/ticketConverter && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/ticketer.py /usr/local/bin/ticketer && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/tstool.py /usr/local/bin/tstool && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/wmiexec.py /usr/local/bin/wmiexec && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/wmipersist.py /usr/local/bin/wmipersist && \
    install -o root -g root -m 0755 /opt/impacket/venv/bin/wmiquery.py /usr/local/bin/wmiquery

# targetted kerberoast
RUN git clone https://github.com/ShutdownRepo/targetedKerberoast /opt/targetedKerberoast && \
    python3 -m venv /opt/targetedKerberoast/venv && \
    /opt/targetedKerberoast/venv/bin/pip install -r /opt/targetedKerberoast/requirements.txt && \
    echo "alias targetedKerberoast=\"/opt/targetedKerberoast/venv/bin/python /opt/targetedKerberoast/targetedKerberoast.py\"" > /root/.bashrc.d/targetedKerberoast.rc

# pywhisker
RUN git clone https://github.com/ShutdownRepo/pywhisker /opt/pywhisker && \
    python3 -m venv /opt/pywhisker/venv && \
    /opt/pywhisker/venv/bin/pip install /opt/pywhisker/ && \
    install -o root -g root -m 0755 /opt/pywhisker/venv/bin/pywhisker /usr/local/bin/pywhisker

# git-dumper
RUN git clone https://github.com/arthaud/git-dumper /opt/git-dumper && \
    python3 -m venv /opt/git-dumper/venv && \
    /opt/git-dumper/venv/bin/pip install /opt/git-dumper/ && \
    install -o root -g root -m 0755 /opt/git-dumper/venv/bin/git-dumper /usr/local/bin/git-dumper

# bloodyAD
RUN git clone https://github.com/CravateRouge/bloodyAD /opt/bloodyAD && \
    python3 -m venv /opt/bloodyAD/venv && \
    /opt/bloodyAD/venv/bin/pip install /opt/bloodyAD/ && \
    install -o root -g root -m 0755 /opt/bloodyAD/venv/bin/bloodyAD /usr/local/bin/bloodyAD

# haiti-hash
RUN gem install haiti-hash

# cve-2019-1040-scanner
RUN git clone https://github.com/fox-it/cve-2019-1040-scanner /opt/cve-2019-1040-scanner && \
    echo "alias cve-2019-1040-scanner=\"python3 /opt/cve-2019-1040-scanner/scan.py\"" > /root/.bashrc.d/cve-2019-1040-scanner.rc

# adidnsdump
RUN git clone https://github.com/dirkjanm/adidnsdump /opt/adidnsdump && \
    python3 -m venv /opt/adidnsdump/venv && \
    /opt/adidnsdump/venv/bin/pip install /opt/adidnsdump/ && \
    install -o root -g root -m 0755 /opt/adidnsdump/venv/bin/adidnsdump /usr/local/bin/adidnsdump

# privexchange
RUN git clone https://github.com/dirkjanm/privexchange /opt/privexchange && \
    python3 -m venv /opt/privexchange/venv && \
    /opt/privexchange/venv/bin/pip install -r /opt/privexchange/requirements.txt && \
    echo "alias privexchange=\"/opt/privexchange/venv/bin/python /opt/privexchange/privexchange.py\"" > /root/.bashrc.d/privexchange.rc

# pcredz
RUN git clone https://github.com/lgandx/PCredz /opt/PCredz && \
    DEBIAN_FRONTEND=noninteractive apt update -y && \
    apt install -y libpcap-dev && \
    python3 -m venv /opt/PCredz/venv && \
    /opt/PCredz/venv/bin/pip install Cython && \
    /opt/PCredz/venv/bin/pip install python-libpcap && \
    echo "alias Pcredz=\"/opt/PCredz/venv/bin/python /opt/PCredz/Pcredz\"" > /root/.bashrc.d/Pcredz.rc
  
# krbrelayx
RUN git clone https://github.com/dirkjanm/krbrelayx /opt/krbrelayx && \
    python3 -m venv /opt/krbrelayx/venv && \
    /opt/krbrelayx/venv/bin/pip install impacket ldap3 dnspython && \
    echo "alias krbrelayx=\"/opt/krbrelayx/venv/bin/python /opt/krbrelayx/krbrelayx.py\"" > /root/.bashrc.d/krbrelayx.rc

# ldaprelayscan
RUN git clone https://github.com/zyn3rgy/LdapRelayScan /opt/LdapRelayScan && \
    python3 -m venv /opt/LdapRelayScan/venv && \
    /opt/LdapRelayScan/venv/bin/pip install -r /opt/LdapRelayScan/requirements.txt && \
    echo "alias LdapRelayScan=\"/opt/LdapRelayScan/venv/bin/python /opt/LdapRelayScan/LdapRelayScan.py\"" > /root/.bashrc.d/LdapRelayScan.rc

# passthecert
RUN git clone https://github.com/AlmondOffSec/PassTheCert /opt/PassTheCert && \
    echo "alias passthecert=\"python3 /opt/PassTheCert/Python/passthecert.py\"" > /root/.bashrc.d/PassTheCert.rc

# gittools
RUN git clone https://github.com/internetwache/GitTools /opt/GitTools && \
    install -o root -g root -m 0755 /opt/GitTools/Dumper/gitdumper.sh /usr/local/bin/gitdumper && \
    install -o root -g root -m 0755 /opt/GitTools/Extractor/extractor.sh /usr/local/bin/gitextractor && \
    echo "alias gitfinder=\"python3 /opt/GitTools/Finder/gitfinder.py\"" > /root/.bashrc.d/gitfinder.rc

# pkinittools
RUN git clone https://github.com/dirkjanm/PKINITtools /opt/PKINITtools && \
    python3 -m venv /opt/PKINITtools/venv && \
    /opt/PKINITtools/venv/bin/pip install -r /opt/PKINITtools/requirements.txt && \
    echo "alias gettgtpkinit=\"python3 /opt/PKINITtools/gettgtpkinit.py\"" > /root/.bashrc.d/gettgtpkinit.rc && \
    echo "alias getnthash=\"python3 /opt/PKINITtools/getnthash.py\"" > /root/.bashrc.d/getnthash.rc && \
    echo "alias gets4uticket=\"python3 /opt/PKINITtools/gets4uticket.py\"" > /root/.bashrc.d/gets4uticket.rc

# sapito
RUN git clone https://github.com/eldraco/Sapito /opt/Sapito && \
    python3 -m venv /opt/Sapito/venv && \
    /opt/Sapito/venv/bin/pip install -r /opt/Sapito/requirements.txt && \
    echo "alias sapito=\"python3 /opt/Sapito/sapito.py\"" > /root/.bashrc.d/sapito.rc

# pgexec
RUN git clone https://github.com/Dionach/pgexec /opt/pgexec && \
    install -o root -g root -m 0755 /opt/pgexec/pg_exec.sh /usr/local/bin/pg_exec

# jexboss
RUN git clone https://github.com/joaomatosf/jexboss /opt/jexboss && \
    python3 -m venv /opt/jexboss/venv && \
    /opt/jexboss/venv/bin/pip install -r /opt/jexboss/requires.txt && \
    echo "alias jexboss=\"python3 /opt/jexboss/jexboss.py\"" > /root/.bashrc.d/jexboss.rc

# o365enum
RUN git clone https://github.com/gremwell/o365enum /opt/o365enum && \
    echo "alias o365enum=\"python3 /opt/o365enum/o365enum.py\"" > /root/.bashrc.d/o365enum.rc

# rsh
RUN git clone https://github.com/mzfr/rsh /opt/rsh && \
    python3 -m venv /opt/rsh/venv && \
    /opt/rsh/venv/bin/pip install -r /opt/rsh/requirements.txt && \
    echo "alias rsh=\"python3 /opt/rsh/rsh\"" > /root/.bashrc.d/rsh.rc

# jwt_tool
RUN git clone https://github.com/ticarpi/jwt_tool /opt/jwt_tool && \
    python3 -m venv /opt/jwt_tool/venv && \
    /opt/jwt_tool/venv/bin/pip install -r /opt/jwt_tool/requirements.txt && \
    echo "alias jwt_tool=\"python3 /opt/jwt_tool/jwt_tool.py\"" > /root/.bashrc.d/jwt_tool.rc

# Linkedin Dumper
RUN git clone https://github.com/l4rm4nd/LinkedInDumper /opt/linkedin-dumper && \
    python3 -m venv /opt/linkedin-dumper/venv && \
    /opt/linkedin-dumper/venv/bin/pip install -r /opt/linkedin-dumper/requirements.txt && \
    echo "alias linkedin-dumper=\"python3 /opt/linkedin-dumper/linkedin-dumper.py\"" > /root/.bashrc.d/linkedin-dumper.rc

# NoPrompt
RUN git clone https://github.com/NotSoSecure/NoPrompt /opt/NoPrompt && \
    python3 -m venv /opt/NoPrompt/venv && \
    /opt/NoPrompt/venv/bin/pip install -r /opt/NoPrompt/requirements.txt && \
    echo "alias noprompt=\"python3 /opt/NoPrompt/noprompt.py\"" > /root/.bashrc.d/NoPrompt.rc

# sharpcollection
RUN git clone https://github.com/Flangvik/SharpCollection /opt/SharpCollection

# brutespray
RUN /home/linuxbrew/.linuxbrew/bin/go install github.com/x90skysn3k/brutespray@latest

# aws session manager plugin
RUN curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/opt/session-manager-plugin.deb" && \
    dpkg -i /opt/session-manager-plugin.deb

# kubesec-scan
RUN /home/linuxbrew/.linuxbrew/bin/kubectl-krew install kubesec-scan

# access_matrix
RUN /home/linuxbrew/.linuxbrew/bin/kubectl-krew install access-matrix 

# score
RUN /home/linuxbrew/.linuxbrew/bin/kubectl-krew install score
        
# roadtools
RUN /home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/ROADTools/venv && \
    /opt/ROADTools/venv/bin/pip install roadlib && \
	/opt/ROADTools/venv/bin/pip install roadrecon && \
    install -o root -g root -m 0755 /opt/ROADTools/venv/bin/roadrecon /usr/local/bin/roadrecon && \
    install -o root -g root -m 0755 /opt/ROADTools/venv/bin/roadrecon-gui /usr/local/bin/roadrecon-gui

# pmapper
RUN git clone "https://github.com/mosesrenegade/PMapper" /opt/PMapper && \
	python3 -m venv /opt/PMapper/venv && \
	/opt/PMapper/venv/bin/pip install /opt/PMapper/ && \
    install -o root -g root -m 0755 /opt/PMapper/venv/bin/pmapper /usr/local/bin/pmapper

# pacu
RUN git clone https://github.com/RhinoSecurityLabs/pacu /opt/pacu && \
    python3 -m venv /opt/pacu/venv && \
	/opt/pacu/venv/bin/pip3 install -U /opt/pacu && \
    install -o root -g root -m 0755 /opt/pacu/venv/bin/pacu /usr/local/bin/pacu

# s3-account-search
RUN /home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/s3-account-search/venv && \
	/opt/s3-account-search/venv/bin/pip install s3-account-search && \
    install -o root -g root -m 0755 /opt/s3-account-search/venv/bin/s3-account-search /usr/local/bin/s3-account-search

# iamactionhunter
RUN /home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/IAMActionHunter/venv && \
	/opt/IAMActionHunter/venv/bin/pip install iamactionhunter && \
    install -o root -g root -m 0755 /opt/IAMActionHunter/venv/bin/iamactionhunter /usr/local/bin/iamactionhunter

# az powershell
RUN  pwsh -c "Install-Module -Name Az -Repository PSGallery -Force"

# ms graph powershell
RUN  pwsh -c "Install-Module -Name Microsoft.Graph -Repository PSGallery -Force"

# blackcat
RUN git clone "https://github.com/azurekid/blackcat" /opt/blackcat

# aws enumerator
RUN GOPATH=/opt/aws-enumerator /home/linuxbrew/.linuxbrew/bin/go install -v github.com/shabarkin/aws-enumerator@latest && \
    ln -s /opt/aws-enumerator/bin/aws-enumerator /usr/bin/aws-enumerator

# GoAWSConsoleSpray
RUN GOPATH=/opt/GoAWSConsoleSpray /home/linuxbrew/.linuxbrew/bin/go install github.com/WhiteOakSecurity/GoAWSConsoleSpray@latest && \
    ln -s /opt/GoAWSConsoleSpray/bin/GoAWSConsoleSpray /usr/bin/GoAWSConsoleSpray

# kubernetes-rbac-audit
RUN git clone "https://github.com/PalindromeLabs/kubernetes-rbac-audit" /opt/kubernetes-rbac-audit && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/kubernetes-rbac-audit/venv && \
	/opt/kubernetes-rbac-audit/venv/bin/pip install colorama

# kubenumerate
RUN git clone "https://github.com/0x5ubt13/kubenumerate" /opt/kubenumerate && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/kubenumerate/venv && \
	/opt/kubenumerate/venv/bin/pip install -r /opt/kubenumerate/requirements.txt && \
    echo "alias kubenumerate=\"/opt/kubenumerate/venv/bin/python /opt/kubenumerate/kubenumerate.py\"" > /root/.bashrc.d/kubenumerate.rc

# cloud_enum
RUN git clone "https://github.com/initstring/cloud_enum" /opt/cloud_enum && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/cloud_enum/venv && \
	/opt/cloud_enum/venv/bin/pip install /opt/cloud_enum/ && \
    install -o root -g root -m 0755 /opt/cloud_enum/venv/bin/cloud_enum /usr/local/bin/cloud_enum

# azure kubelogin
RUN /home/linuxbrew/.linuxbrew/bin/az aks install-cli

# kubiscan
RUN git clone "https://github.com/cyberark/KubiScan" /opt/KubiScan && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/KubiScan/venv && \
	/opt/KubiScan/venv/bin/pip install -r /opt/KubiScan/requirements.txt && \
    echo "alias KubiScan=\"/opt/KubiScan/venv/bin/python /opt/KubiScan/KubiScan.py\"" > /root/.bashrc.d/KubiScan.rc

# graphpython
RUN git clone "https://github.com/mlcsec/Graphpython" /opt/Graphpython && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/Graphpython/venv && \
	/opt/Graphpython/venv/bin/pip install /opt/Graphpython/ && \
    install -o root -g root -m 0755 /opt/Graphpython/venv/bin/Graphpython /usr/local/bin/Graphpython

# kubeaudit
RUN /home/linuxbrew/.linuxbrew/bin/wget2 "https://github.com/Shopify/kubeaudit/releases/download/v0.22.1/kubeaudit_0.22.1_linux_amd64.tar.gz" -O /opt/kubeaudit_0.22.1_linux_amd64.tar.gz && \
    tar -xzf /opt/kubeaudit_0.22.1_linux_amd64.tar.gz -C /opt/ && \
    install -o root -g root -m 0755 /opt/kubeaudit /usr/local/bin/kubeaudit && \
    rm /opt/kubeaudit_0.22.1_linux_amd64.tar.gz

# nodeshell
RUN /home/linuxbrew/.linuxbrew/bin/kubectl-krew install node-shell && \
    install -o root -g root -m 0755 $HOME/.krew/bin/kubectl-node_shell /usr/local/bin/kubectl-node_shell

# gcloud
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz -o /opt/google-cloud-cli-linux-x86_64.tar.gz && \
    tar -xf /opt/google-cloud-cli-linux-x86_64.tar.gz -C /opt/ && \
    /opt/google-cloud-sdk/install.sh -q && \
    /opt/google-cloud-sdk/bin/gcloud components install gke-gcloud-auth-plugin

# iam policy visualize
RUN git clone "https://github.com/hac01/iam-policy-visualize" /opt/iam-policy-visualize && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/iam-policy-visualize/venv && \
	/opt/iam-policy-visualize/venv/bin/pip install graphviz && \
    echo "alias iam-policy-visualize=\"/opt/iam-policy-visualize/venv/bin/python /opt/iam-policy-visualize/main.py\"" > /root/.bashrc.d/iam-policy-visualize.rc

# gcp iam priv esc
RUN git clone "https://github.com/RhinoSecurityLabs/GCP-IAM-Privilege-Escalation" /opt/GCP-IAM-Privilege-Escalation && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/GCP-IAM-Privilege-Escalation/venv && \
	/opt/GCP-IAM-Privilege-Escalation/venv/bin/pip install -r /opt/GCP-IAM-Privilege-Escalation/PrivEscScanner/requirements.txt

# gcp-iam-brute
RUN git clone "https://github.com/hac01/gcp-iam-brute" /opt/gcp-iam-brute && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/gcp-iam-brute/venv && \
	/opt/gcp-iam-brute/venv/bin/pip install -r /opt/gcp-iam-brute/requirements.txt && \
    echo "alias gcp-iam-brute=\"/opt/gcp-iam-brute/venv/bin/python /opt/gcp-iam-brute/main.py\"" > /root/.bashrc.d/gcp-iam-brute.rc

# gcp-permissions-checker
RUN git clone "https://github.com/egre55/gcp-permissions-checker" /opt/gcp-permissions-checker && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/gcp-permissions-checker/venv && \
	/opt/gcp-permissions-checker/venv/bin/pip install -r /opt/gcp-permissions-checker/requirements.txt && \
    echo "alias gcp-permissions-checker=\"/opt/gcp-permissions-checker/venv/bin/python /opt/gcp-permissions-checker/main.py\"" > /root/.bashrc.d/gcp-permissions-checker.rc

# cloudsploit
WORKDIR /opt/cloudsploit
RUN git clone "http://github.com/aquasecurity/cloudsploit.git" /opt/cloudsploit && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    /home/linuxbrew/.linuxbrew/bin/npm install && \
    chmod +x /opt/cloudsploit/index.js

# kics
WORKDIR /opt/kics
RUN git clone "https://github.com/Checkmarx/kics.git" /opt/kics && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    /home/linuxbrew/.linuxbrew/bin/go mod vendor && \
    make build && \
    install -o root -g root -m 0755 /opt/kics/bin/kics /usr/local/bin/kics

# sharefiltrator
WORKDIR /opt/sharefiltrator
RUN git clone "https://github.com/Friends-Security/sharefiltrator" /opt/sharefiltrator && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/sharefiltrator/venv && \
	/opt/sharefiltrator/venv/bin/pip install -r /opt/sharefiltrator/requirements.txt && \
    echo "alias sharefiltrator=\"/opt/sharefiltrator/venv/bin/python /opt/sharefiltrator/sharefiltrator.py\"" > /root/.bashrc.d/sharefiltrator.rc

# noCAP
WORKDIR /opt/noCAP
RUN git clone "https://github.com/securesloth/noCAP" /opt/noCAP && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/noCAP/venv && \
	/opt/noCAP/venv/bin/pip install -r /opt/noCAP/requirements.txt && \
    echo "alias noCAP=\"/opt/noCAP/venv/bin/python /opt/noCAP/noCAP.py\"" > /root/.bashrc.d/noCAP.rc

# caReports
WORKDIR /opt/caReports
RUN git clone "https://github.com/uniQuk/caReports" /opt/caReports

# CAPs
WORKDIR /opt/CAPs
RUN git clone "https://github.com/techBrandon/CAPs" /opt/CAPs

# EntraFalcon
WORKDIR /opt/EntraFalcon
RUN git clone "https://github.com/CompassSecurity/EntraFalcon" /opt/EntraFalcon

# snotra aws
WORKDIR /opt/snotra_aws
RUN git clone "https://gitlab.com/snotra.cloud/aws.git" /opt/snotra_aws && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/snotra_aws/venv && \
	/opt/gcp-iam-brute/venv/bin/pip install -r /opt/snotra_aws/requirements.txt && \
    echo "alias snotra_aws=\"/opt/snotra_aws/venv/bin/python /opt/snotra_aws/snorta.py\"" > /root/.bashrc.d/snotra.rc

# snotra azure
WORKDIR /opt/snotra_azure
RUN git clone "https://gitlab.com/snotra.cloud/azure.git" /opt/snotra_azure && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/snotra_azure/venv && \
	/opt/gcp-iam-brute/venv/bin/pip install -r /opt/snotra_azure/requirements.txt && \
    echo "alias snotra_azure=\"/opt/snotra_azure/venv/bin/python /opt/snotra_azure/snorta.py\"" >> /root/.bashrc.d/snotra.rc

# snotra kubernetes
WORKDIR /opt/snotra_kubernetes
RUN git clone "https://gitlab.com/snotra.cloud/kubernetes.git" /opt/snotra_kubernetes && \
	/home/linuxbrew/.linuxbrew/bin/python3 -m venv /opt/snotra_kubernetes/venv && \
	/opt/gcp-iam-brute/venv/bin/pip install -r /opt/snotra_kubernetes/requirements.txt && \
    echo "alias snotra_kubernetes=\"/opt/snotra_kubernetes/venv/bin/python /opt/snotra_kubernetes/snorta.py\"" >> /root/.bashrc.d/snotra.rc


# binaries
RUN wget -q https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64 -O /opt/kerbrute && \
    install -o root -g root -m 0755 /opt/kerbrute /usr/local/bin/kerbrute

RUN wget -q https://github.com/ropnop/go-windapsearch/releases/download/v0.3.0/windapsearch-linux-amd64 -O /opt/windapsearch && \
    install -o root -g root -m 0755 /opt/windapsearch /usr/local/bin/windapsearch

RUN wget -q https://github.com/sensepost/gowitness/releases/download/2.5.1/gowitness-2.5.1-linux-amd64 -O /opt/gowitness && \
    install -o root -g root -m 0755 /opt/gowitness /usr/local/bin/gowitness

RUN wget -q https://github.com/hdm/nextnet/releases/download/v0.0.2/nextnet_0.0.2_linux_amd64.tar.gz -O /opt/nextnet_0.0.2_linux_amd64.tar.gz

RUN wget -q https://github.com/liamg/traitor/releases/download/v0.0.14/traitor-amd64 -O /opt/traitor && \
    install -o root -g root -m 0755 /opt/traitor /usr/local/bin/traitor

RUN wget -q https://github.com/lkarlslund/ldapnomnom/releases/download/v1.3.0/ldapnomnom-linux-x64 -O /opt/ldapnomnom && \
    install -o root -g root -m 0755 /opt/ldapnomnom /usr/local/bin/ldapnomnom

RUN wget -q https://github.com/Chocapikk/wpprobe/releases/download/v0.8.0/wpprobe_v0.8.0_linux_amd64 -O /opt/wpprobe && \
    install -o root -g root -m 0755 /opt/wpprobe /usr/local/bin/wpprobe

RUN wget -q https://github.com/antonioCoco/RunasCs/releases/download/v1.5/RunasCs.zip -O /opt/RunasCs.zip

# update nuclei templates
RUN /home/linuxbrew/.linuxbrew/bin/nuclei -ut

# wordlists
RUN git clone https://github.com/insidetrust/statistically-likely-usernames /usr/share/statistically-likely-usernames

# prep wordlist files for msf usage
RUN sed -e "s/:/ /" /usr/share/seclists/Passwords/Default-Credentials/mssql-betterdefaultpasslist.txt > /usr/share/seclists/Passwords/Default-Credentials/mssql-betterdefaultpasslist_spaces.txt && \
    sed -e "s/:/ /" /usr/share/seclists/Passwords/Default-Credentials/mysql-betterdefaultpasslist.txt > /usr/share/seclists/Passwords/Default-Credentials/mysql-betterdefaultpasslist_spaces.txt && \
    sed -e "s/:/ /" /usr/share/seclists/Passwords/Default-Credentials/ssh-betterdefaultpasslist.txt > /usr/share/seclists/Passwords/Default-Credentials/ssh-betterdefaultpasslist_spaces.txt && \
    sed -e "s/:/ /" /usr/share/seclists/Passwords/Default-Credentials/ftp-betterdefaultpasslist.txt > /usr/share/seclists/Passwords/Default-Credentials/ftp-betterdefaultpasslist_spaces.txt && \
    sed -e "s/:/ /" /usr/share/seclists/Passwords/Default-Credentials/postgres-betterdefaultpasslist.txt > /usr/share/seclists/Passwords/Default-Credentials/postgres-betterdefaultpasslist_spaces.txt && \
    sed -e "s/:/ /" /usr/share/seclists/Passwords/Default-Credentials/vnc-betterdefaultpasslist.txt > /usr/share/seclists/Passwords/Default-Credentials/vnc-betterdefaultpasslist_spaces.txt && \ 
    sed -e "s/:/ /" /usr/share/seclists/Passwords/Default-Credentials/tomcat-betterdefaultpasslist.txt > /usr/share/seclists/Passwords/Default-Credentials/tomcat-betterdefaultpasslist_spaces.txt

RUN DEBIAN_FRONTEND=noninteractive apt update -y && apt install -y && apt autoremove && apt autoclean

WORKDIR /root

CMD /bin/bash
