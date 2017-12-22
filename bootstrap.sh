#!/bin/bash

## Application Security Threat Attack Modeling (ASTAM)
##
## Copyright (C) 2017 Applied Visions - http://securedecisions.com
##
## Written by Aspect Security - http://aspectsecurity.com
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
updateRepos="true"
downloadApps="true"
unzipApps="true"
installOracleJDK8="true"
installMySQL="true"

version="3.3.1"
dotCMSDownloadURL="https://dotcms.com/physical_downloads/release_builds/dotcms_$version.tar.gz"

if  [ "$updateRepos" = "true" ]; then
	echo 'Updating repos'
	apt-get update
	echo 'Finished updating repos'
fi

if [ "$installOracleJDK8" = "true" ]; then
	echo "Installing Java"
	add-apt-repository ppa:webupd8team/java
	apt-get update
	echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
	apt-get -y install oracle-java8-installer
fi

if [ "$downloadApps" = "true" ]; then
	echo "Downloading Apps..."
	mkdir /downloadedApps
	cd /downloadedApps
  if [ ! -f dotcms_$version.tar.gz ]; then
	  wget -cN --progress=bar:force ${dotCMSDownloadURL}
  fi
fi

if [ "$unzipApps" = "true" ]; then
	echo "Unzipping apps"
	cd /downloadedApps
  if [ ! -d dotcms-$version ]; then
	  mkdir dotcms-$version
    cd dotcms-$version
    tar xzf ../dotcms_$version.tar.gz
  fi
fi

if [ "$installMySQL" = "true" ]; then
	echo "Installing MySQL"
	sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
	sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
	apt-get -y install mysql-server
	apt-get -y install mysql-client

	echo "Setting up MySQL"
	if ! grep "lower_case_table_names=1" /etc/mysql/my.cnf ; then
	sed -i '/\[mysqld\]/alower_case_table_names=1' /etc/mysql/my.cnf
	service mysql restart
	fi

	echo "Configuring dotCMS to use MySQL"
	echo 'create database dotcms default character set = utf8 default collate = utf8_general_ci;' | mysql --password=root
	# necessary updates in context.xml
	cd /downloadedApps/dotcms-3.3.1/dotserver/tomcat-8.0.18/webapps/ROOT/META-INF
	cat context.xml | sed '29s/-->//' | sed '37s/^.*$/ -->/' | sed '47s/$/ -->/' | sed '54s/^.*$//' | sed '50s/dotcms2/dotcms/' | sed '51s/{your db user}/root/' | sed '51s/{your db password}/root/' > context.tmp
	mv context.tmp context.xml
fi
#  Not necessary for most installations
#sed -i  's/port="8080"/port="8081"/' /downloadedApps/dotcms-3.2.4/dotserver/tomcat-8.0.18/conf/server.xml #change the tomcat port
#sed -i  's/Host name="localhost"/Host name="myHost"/' /downloadedApps/dotcms-3.2.4/dotserver/tomcat-8.0.18/conf/server.xml #update hostname for this tomcat instance

echo "starting dotCMS"
/downloadedApps/dotcms-3.3.1/bin/shutdown.sh
#handled in the Vagrantfile
#/downloadedApps/dotcms-3.3.1/bin/startup.sh

echo ''
echo 'IN A FEW MINUTES, dotCMS will be accessible at http://localhost:8080/ (from your host)'
echo '===== Application Credentials ====='
echo ''
echo '=== Admin ==='
echo '     URL: http://localhost:8080/admin'
echo 'username: admin@dotcms.com'
echo 'password: admin'
echo ''
echo '=== Intranet User ==='
echo 'username: bill@dotcms.com'
echo 'password: bill'
echo ''
echo '=== Limited User ==='
echo 'username: joe@dotcms.com'
echo 'password: joe'
echo '===== Application Credentials ====='
echo 'Script finished.'
