hi

[root@btwsdlvxxx310 scguser]# cat ReplaceJDK.bash
#!/bin/bash
DATE=$(date +'%m%d%Y')
VERSION=$(java -version 2>&1)
if [[ $? -ne 0 ]]; then
 echo "mailx -s \"No java found on $(uname -n)\" recipient@triwest.com"
 exit 11
fi
if [[ ! -L $(which java) ]]; then
 echo "mailx -s \"java not a link on $(uname -n)\" recipient@triwest.com"
 exit 11
fi
if [[ "$VERSION" == *"OpenJDK"* ]]; then
 echo "already Open JDK"
 echo "mailx -s \"OpenJDK already installed on $(uname -n)\" recipient@triwest.com"
 exit 12
fi
yum --quiet --disableexcludes=all list java-1.8.0-openjdk-devel.x86_64 > /dev/null 2>&1
if [[ $? -ne 0 ]]; then
 echo "OpenJDK not available on yum"
 echo "mailx -s \"OpenJDK not available on yum on $(uname -n)\" recipient@triwest.com"
 exit 13
fi
echo "systemctl stop tomcat"
WHEREJAVA=$(dirname $(dirname $(ls -ld $(ls -ld $(which java) | awk '{print $11}') | awk '{print $11}')))
echo "mkdir -p /opt/javabak"
echo "cd $WHEREJAVA/.."
echo "tar czf /opt/javabak/javabackup_${DATE}.tar.gz $(basename $WHEREJAVA)"
echo "cd -"
CACERTSFILE=$(find $WHEREJAVA -name cacerts)
if [[ ! -L $CACERTSFILE ]]; then
 echo "cp -p $CACERTSFILE /opt/javabak/cacerts"
 NOTLINK=yes
fi
PACKAGENAME=$(rpm -qf $WHEREJAVA)
echo "yum --quiet -y remove $PACKAGENAME"
echo "yum --quiet --disableexcludes=all -y install java-1.8.0-openjdk-devel.x86_64 2>/dev/null"
WHERENEWJAVA=$(dirname $(dirname $(ls -ld $(ls -ld $(which java) | awk '{print $11}') | awk '{print $11}')))
NEWCACERTSFILE=$(find $WHERENEWJAVA -name cacerts)
if [[ $NOTLINK -eq "yes" ]]; then
 echo "mv $NEWCACERTSFILE ${NEWCACERTSFILE}.${DATE}"
 echo "cp -p /opt/javabak/cacerts $NEWCACERTSFILE"
fi
echo "cp -p /opt/tomcat/bin/setetnv.sh /opt/javabak"
echo "cp -p /opt/tomcat/bin/setetnv.sh /opt/tomcat/bin/setetnv.sh.${DATE}"
echo -E sed -i "s#^\(export JAVA_HOME=\).*#\1\"$WHERENEWJAVA\"#g" /opt/tomcat/bin/setetnv.sh
echo "systemctl start tomcat"
exit 0
#exit codes: 11 - problem with installed java, 12 - already on OpenJDK, 13 - OpenJDK not available in yum repo
#BTWSDLVXXX310
#Stop tomcat
#Backup the java folder.
# REMOVE OLD JAVA
#Check if the package is available in Yum
#if not edit yum.conf file to include java and run the yum install.
#Once installed, copy the cacerts in jre/lib/security file in the installed folder.
#update the java home in the tomcat classpath
#start the tomcat.
