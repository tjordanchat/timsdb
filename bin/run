sudo yum install git
ssh-keygen -t rsa
cd .ssh
cat *pub
git clone git@github.com:tjordanchat/timsdb.git
git config --global user.name "Tim Jordan"
git config --global user.email jamestjordan@gmail.com
wget http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo rpm -ivh puppetlabs-release-el-6.noarch.rpm
sudo yum install puppet-server
sudo rpm -Uvh http://yum.pgrpms.org/reporpms/8.4/pgdg-fedora-8.4-2.noarch.rpm
sudo yum install fedora-release
sudo rpm -ivh pgdg-fedora-8.4-2.noarch
sudo vi /etc/yum/pluginconf.d/rhnplugin.conf 
curl -O http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
sudo rpm -ivh pgdg-centos93-9.3-1.noarch.rpm
sudo yum install puppet
sudo vi /etc/puppet/puppet.conf
sudo puppet resource service puppet ensure=running enable=true
sudo puppet resource service puppetmaster ensure=running enable=true
sudo service iptables save
sudo service iptables stop
sudo chkconfig iptables off
sudo service ip6tables save
sudo service ip6tables stop
sudo chkconfig ip6tables off
sudo yum remove puppet-server
sudo yum remove puppet 
wget http://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-6.1.3-x64.bin
sudo basc -c atlassian-jira-6.1.3-x64.bin 
sudo bash -c ./atlassian-jira-6.1.3-x64.bin 
cd /opt/atlassian/jira/bin
sudo ./start-jira.sh 
sudo service jira start
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
sudo python ez_setup.py 
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
sudo python get-pip.py
sudo pip install Genshi
sudo yum install sqlite3
sudo yum install sqlite
sudo yum install trac
sudo pip install trac psycopg2 
sudo yum install postgresql-devel
sudo pip install trac psycopg2 
sudo yum install gcc
sudo pip install trac psycopg2 
sudo yum  install python-devel.x86_64
sudo pip install trac psycopg2 
sudo service trac start
trac-admin
trac-admin ~/projects/MyProject initenv
sudo yum provides \*bin/htpasswd
sudo yum install httpd-tools-2.2.15-29.el6_4.x86_64
htpasswd -c ~/projects/MyProject/.htpasswd admin
cd; ( sudo nohup /usr/bin/tracd -s -p 80 --basic-auth='\''MyProject,/home/ec2-user/projects/MyProject/.htpasswd,My Project'\'' /home/ec2-user/projects/MyProject & )
sudo yum install telnet
telnet localhost 80
service iptables save
cd ~/projects/MyProject/templates/
cp site.html.sample site.html
vi index.html
trac-admin ~/projects/MyProject/ permission add admin TRAC_ADMIN
cd ~/projects/MyProject/htdocs
wget http://thumbs4.ebaystatic.com/d/l225/m/mkEyMhqRpseNxok55kgRJCA.jpg
mv mkEyMhqRpseNxok55kgRJCA.jpg timjordan.jpg
cd ../config
vi trac.ini
cd; ( sudo nohup /usr/bin/tracd -s -p 80 --basic-auth='\''MyProject,/home/ec2-user/projects/MyProject/.htpasswd,My Project'\'' /home/ec2-user/projects/MyProject & )
sudo cat > /etc/yum.repos.d/nginx.repo
wget http://nginx.org/packages/rhel/6/noarch/RPMS/nginx-release-rhel-6-0.el6.ngx.noarch.rpm
sudo rpm -ivh nginx-release-rhel-6-0.el6.ngx.noarch.rpm
sudo yum install nginx
sudo vi vi /etc/nginx/conf.d/default.conf
sudo service nginx start
sudo vi /etc/nginx/conf.d/default.conf
sudo vi /etc/nginx/nginx.conf
sudo service nginx start
wget http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
sudo rpm -ivh puppetlabs-release-el-6.noarch.rpm 
sudo yum install puppet-server
sudo vi /etc/puppet/puppet.conf 
sudo puppet resource service puppet ensure=running enable=true
sudo puppet resource service puppetmaster ensure=running enable=true
sudo yum install puppet-dashboard
cd ~/projects/MyProject/conf
vi trac.ini
cd; ( sudo nohup /usr/bin/tracd -s -p 80 --basic-auth='\''MyProject,/home/ec2-user/projects/MyProject/.htpasswd,My Project'\'' /home/ec2-user/projects/MyProject & )
sudo yum install tree
vi myPermissions.py
sudo adduser guest -p password
sudo rpm -ivh puppetlabs-release-el-6.noarch.rpm 
sudo yum install puppet
sudo vi /etc/puppet/puppet.conf
sudo useradd git -p password
sudo yum install ruby ruby-devel ruby-ri ruby-rdoc ruby-shadow gcc gcc-c++ automake autoconf make curl dmidecode
curl -O http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz
tar zxf rubygems-1.8.10.tgz
cd rubygems-1.8.10
sudo ruby setup.rb --no-format-executable
sudo gem install chef --no-ri --no-rdoc
sudo yum update -y
sudo yum install dpkg
sudo rpm -ivh chef-server-11.0.8-1.el6.x86_64.rpm 
sudo chef-server-ctl reconfigure
sudo vi /opt/chef-server/embedded/cookbooks/cache/chef-stacktrace.out
sudo rpm --import oracle_vbox.asc
