#!/bin/bash

if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]$ ]]; then
  version=$1
else
  defVersion=2.5.3
  read -p "Download RCPTT version [${defVersion}]: " version && version=${version:-${defVersion}}
fi

dlUrl=https://mirrors.dotsrc.org/eclipse//rcptt/release/$version/ide/rcptt.ide-$version-linux.gtk.x86_64.zip
if [[ "$1" == http* ]]; then
    # simplify nightly installation via unique URI from https://www.eclipse.org/rcptt/download/
    dlUrl=$1
    # version from URI:
    artifact=`basename $dlUrl`
    noarch=${artifact%%\-linux\.gtk\.x86_64\.zip}
    version=${noarch##rcptt\.ide\-}
fi

echo "Downloading RCPTT IDE $version"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd /tmp
wget $dlUrl
rcpttDir=/opt/eclipse.rcptt/rcptt${version}.ide
sudo mkdir -p ${rcpttDir}
sudo unzip rcptt.ide*.zip -d ${rcpttDir}
rm rcptt.ide*.zip

jvm=/usr/lib/jvm/temurin-17-jdk-amd64/bin
sudo sed -i -e 's|\-vmargs|-vm\n'"$jvm"'\n\-vmargs|g' "${rcpttDir}/rcptt/rcptt.ini"

$DIR/eclipseRCPTTPlugins.sh $version
