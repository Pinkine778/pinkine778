mod_yum() {
    if [ -e /etc/yum.repos.d/CentOS-Base.repo ]; then
        cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.default
wget -P /etc/yum.repos.d http://mirrors.aliyun.com/repo/Centos-7.repo
wget -P /etc/yum.repos.d http://mirrors.aliyun.com/repo/epel-7.repo
        yum install -y epel-release  && yum clean all && yum makecache && yum -y update
    fi
}
close_selinux() {
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    setenforce 0 &> /dev/null
}
close_firewalld() {
    systemctl stop firewalld.service && systemctl disable firewalld.service
}
install_softwares() {
    if [ `rpm -qa vim lrzsz wget nmap nc tree curl tcpdump sysstat lsof net-tools ntpdate|wc -l` -lt 13 ];
	 then
        yum -y install vim lrzsz wget nmap nc tree curl tcpdump sysstat lsof net-tools ntpdate dos2unix &>/dev/null
    fi
}
python_install() {
yum -y install python36 python36-pip &>/dev/null
mkdir /root/.pip &>/dev/null
if [ $? -eq 0 ]
then
cat > /root/.pip/pip.conf <<EOF
[global]
timeout = 6000
index-url=https://mirrors.aliyun.com/pypi/simple
EOF
pip3 install wechat &>/dev/null
else
	echo "您可能已经下载过python,请尝试启动"
fi
}
