#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/jdk15u-jdk-15.0.2-ga
 then
  rm -rf /sources/jdk15u-jdk-15.0.2-ga
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download https://github.com/openjdk/jdk15u/archive/jdk-15.0.2-ga.tar.gz \
        /sources &&
check_and_download http://anduin.linuxfromscratch.org/BLFS/OpenJDK/OpenJDK-15.0.2/jtreg-4.2.0-tip.tar.gz \
        /sources &&

md5sum -c ${SCRIPTPATH}/md5-jdk &&

tar xf /sources/jdk-15.0.2-ga.tar.gz -C /sources/ &&

cd /sources/jdk15u-jdk-15.0.2-ga &&

tar -xf ../jtreg-4.2.0-tip.tar.gz &&

unset JAVA_HOME                                       &&
bash configure --enable-unlimited-crypto              \
               --disable-warnings-as-errors           \
               --with-stdc++lib=dynamic               \
               --with-giflib=system                   \
               --with-jtreg=$PWD/jtreg                \
               --with-lcms=system                     \
               --with-libjpeg=system                  \
               --with-libpng=system                   \
               --with-zlib=system                     \
               --with-version-build="7"               \
               --with-version-pre=""                  \
               --with-version-opt=""                  \
               --with-cacerts-file=/etc/pki/tls/java/cacerts &&
${log} `basename "$0"` " configured" blfs_all &&
make images &&
${log} `basename "$0"` " built" blfs_all &&

if [ ${ENABLE_TEST} == true ]
 then
  export JT_JAVA=$(echo $PWD/build/*/jdk) &&
  jtreg/bin/jtreg -jdk:$JT_JAVA -automatic -ignore:quiet -v1 \
    test/jdk:tier1 test/langtools:tier1 &&
  unset JT_JAVA &&
  ${log} `basename "$0"` " check succeed" blfs_all ||
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root install -vdm755 /opt/jdk-15.0.2+7             &&
as_root cp -Rv build/*/images/jdk/* /opt/jdk-15.0.2+7 &&
as_root chown -R root:root /opt/jdk-15.0.2+7          &&
for s in 16 24 32 48; do
  as_root install -vDm644 src/java.desktop/unix/classes/sun/awt/X11/java-icon${s}.png \
                  /usr/share/icons/hicolor/${s}x${s}/apps/java.png
done

as_root ln -v -nsf /opt/jdk-15.0.2+7 /opt/jdk &&

as_root mkdir -pv /usr/share/applications &&

cat > ./openjdk-java.desktop << "EOF" &&
[Desktop Entry]
Name=OpenJDK Java 15.0.2 Runtime
Comment=OpenJDK Java 15.0.2 Runtime
Exec=/opt/jdk/bin/java -jar
Terminal=false
Type=Application
Icon=java
MimeType=application/x-java-archive;application/java-archive;application/x-jar;
NoDisplay=true
EOF

cat > ./openjdk-jconsole.desktop << "EOF" &&
[Desktop Entry]
Name=OpenJDK Java 15.0.2 Console
Comment=OpenJDK Java 15.0.2 Console
Keywords=java;console;monitoring
Exec=/opt/jdk/bin/jconsole
Terminal=false
Type=Application
Icon=java
Categories=Application;System;
EOF

as_root mv -v ./openjdk-java.desktop /usr/share/applications/openjdk-java.desktop &&
as_root chown root:root /usr/share/applications/openjdk-java.desktop &&

as_root mv -v ./openjdk-jconsole.desktop /usr/share/applications/openjdk-jconsole.desktop &&
as_root chown root:root /usr/share/applications/openjdk-jconsole.desktop &&

as_root ln -sfv /etc/pki/tls/java/cacerts /opt/jdk/lib/security/cacerts &&
cd /opt/jdk &&
as_root bin/keytool -list -cacerts &&

cp /etc/man_db.conf /tmp &&

cat >> /tmp/man_db.conf << "EOF" &&
# Begin Java addition
MANDATORY_MANPATH     /opt/jdk/man
MANPATH_MAP           /opt/jdk/bin     /opt/jdk/man
MANDB_MAP             /opt/jdk/man     /var/cache/man/jdk
# End Java addition
EOF

as_root mv -v /tmp/man_db.conf /etc/man_db.conf &&

as_root mkdir -p /var/cache/man &&
as_root mandb -c /opt/jdk/man &&

as_root ln -sfv /etc/pki/tls/java/cacerts /opt/jdk/lib/security/cacerts &&
as_root /opt/jdk/bin/keytool -list -cacerts &&

${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
