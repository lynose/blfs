#!/bin/bash
${log} `basename "$0"` " started" blfs_all &&

${log} `basename "$0"` " download" blfs_all &&
if test -d /sources/jdk-14.0.1
 then
  rm -rf /sources/jdk-14.0.1
fi

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

check_and_download http://hg.openjdk.java.net/jdk-updates/jdk14u/archive/jdk-14.0.1+7.tar.bz2 \
        /sources
check_and_download http://anduin.linuxfromscratch.org/BLFS/OpenJDK/OpenJDK-14.0.1/jtreg-4.2-b13-517.tar.gz \
        /sources
check_and_download http://www.linuxfromscratch.org/patches/blfs/10.0/openjdk-14.0.1-make_4.3_fix-1.patch \
        /sources


md5sum -c ${SCRIPTPATH}/md5-jdk &&

tar xf /sources/jdk-14.0.1+7.tar.bz2 -C /sources/ &&

cd /sources/jdk-14.0.1 &&

tar -xf ../jtreg-4.2-b13-517.tar.gz &&
patch -p1 -i ../openjdk-14.0.1-make_4.3_fix-1.patch &&
sed -i /sysctl/d \
    src/jdk.incubator.jpackage/unix/native/libapplauncher/PosixPlatform.cpp &&

unset JAVA_HOME                                       &&
bash configure --enable-unlimited-crypto              \
               --with-extra-cflags="$CFLAGS -fcommon" \
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
  ${log} `basename "$0"` " unexpected check succeed" blfs_all
  ${log} `basename "$0"` " expected check fail?" blfs_all
fi

as_root install -vdm755 /opt/jdk-14.0.1+7             &&
as_root cp -Rv build/*/images/jdk/* /opt/jdk-14.0.1+7 &&
as_root chown -R root:root /opt/jdk-14.0.1+7          &&
for s in 16 24 32 48; do
  as_root install -vDm644 src/java.desktop/unix/classes/sun/awt/X11/java-icon${s}.png \
                  /usr/share/icons/hicolor/${s}x${s}/apps/java.png
done

as_root ln -v -nsf /opt/jdk-14.0.1+7 /opt/jdk &&

as_root mkdir -pv /usr/share/applications &&

cat > ./openjdk-java.desktop << "EOF" &&
[Desktop Entry]
Name=OpenJDK Java 14.0.1 Runtime
Comment=OpenJDK Java 14.0.1 Runtime
Exec=/opt/jdk/bin/java -jar
Terminal=false
Type=Application
Icon=java
MimeType=application/x-java-archive;application/java-archive;application/x-jar;
NoDisplay=true
EOF
cat > ./openjdk-jconsole.desktop << "EOF" &&
[Desktop Entry]
Name=OpenJDK Java 14.0.1 Console
Comment=OpenJDK Java 14.0.1 Console
Keywords=java;console;monitoring
Exec=/opt/jdk/bin/jconsole
Terminal=false
Type=Application
Icon=java
Categories=Application;System;
EOF

as_root mv -v ./openjdk-java.desktop /usr/share/applications/openjdk-java.desktop &&
as_root mv -v ./openjdk-jconsole.desktop /usr/share/applications/openjdk-jconsole.desktop &&

as_root ln -sfv /etc/pki/tls/java/cacerts /opt/jdk/lib/security/cacerts &&
cd /opt/jdk &&
as_root bin/keytool -list -cacerts &&

cat > ./openjdk.sh << "EOF" &&
# Begin /etc/profile.d/openjdk.sh

# Set JAVA_HOME directory
JAVA_HOME=/opt/jdk

# Adjust PATH
pathappend $JAVA_HOME/bin

# Add to MANPATH
pathappend $JAVA_HOME/man MANPATH

# Auto Java CLASSPATH: Copy jar files to, or create symlinks in, the
# /usr/share/java directory. Note that having gcj jars with OpenJDK 8
# may lead to errors.

AUTO_CLASSPATH_DIR=/usr/share/java

pathprepend . CLASSPATH

for dir in `find ${AUTO_CLASSPATH_DIR} -type d 2>/dev/null`; do
    pathappend $dir CLASSPATH
done

for jar in `find ${AUTO_CLASSPATH_DIR} -name "*.jar" 2>/dev/null`; do
    pathappend $jar CLASSPATH
done

export JAVA_HOME
unset AUTO_CLASSPATH_DIR dir jar

# End /etc/profile.d/openjdk.sh
EOF

as_root mv -v ./openjdk.sh /etc/profile.d/openjdk.sh &&

cat > ./java << "EOF" &&
Defaults env_keep += JAVA_HOME
Defaults env_keep += CLASSPATH
EOF
as_root mv -v ./java /etc/sudoers.d/java &&

cat >> ./man_db.conf << "EOF" &&
# Begin Java addition
MANDATORY_MANPATH     /opt/jdk/man
MANPATH_MAP           /opt/jdk/bin     /opt/jdk/man
MANDB_MAP             /opt/jdk/man     /var/cache/man/jdk
# End Java addition
EOF

as_root mv -v ./man_db.conf /etc/man_db.conf &&

mkdir -p /var/cache/man &&
mandb -c /opt/jdk/man &&

as_root ln -sfv /etc/pki/tls/java/cacerts /opt/jdk/lib/security/cacerts &&
as_root /opt/jdk/bin/keytool -list -cacerts &&
${log} `basename "$0"` " installed" blfs_all &&
${log} `basename "$0"` " finished" blfs_all 
