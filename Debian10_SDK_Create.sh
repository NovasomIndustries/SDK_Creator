#!/bin/sh
DIRS="AutoRun Codeblocks DtbUserWorkArea FileSystems Logs Qt Bootloaders Deploy Doc-2020.09 ExternalFileSystems Kernels NOVAembed_Settings Packages-2020.09"
COMPILERS="gcc-7.x-aarch64-eabihf.tar.bz2  gcc-7.x-aarch64-plus-eabihf.tar.bz2  gcc-7.x-arm-eabihf.tar.bz2"
if ! [ -d /Devel ]; then
	echo "Please create a world readable folder called \"/Devel\""
	exit -1
fi
cd /Devel

if [ -d NOVAsdk2020.09 ]; then
	echo "Dir NOVAsdk2020.09 is present. Remove it before continuing"
	exit
fi
mkdir NOVAsdk2020.09
ln -s NOVAsdk2020.09 NOVAsdk
cd NOVAsdk
for i in ${DIRS}; do
	mkdir ${i}
done
git clone https://github.com/NovasomIndustries/Utils-2020.09.git
git clone https://github.com/NovasomIndustries/XCompilers-2020.09.git
ln -s Utils-2020.09 Utils
ln -s XCompilers-2020.09 XCompilers
ln -s Doc-2020.09 Doc
ln -s Packages-2020.09 Packages
cd Utils
./clone_novaembed
cd ..

cd FileSystems
ln -s ../Utils/rock/rk_external external
cd ..

cd XCompilers
for i in ${COMPILERS}; do
	tar jxf ${i}
done

sudo apt-get install -y build-essential git wget cpio unzip rsync bc libncurses5-dev screen curl qt5-default qtcreator codeblocks meld libfl-dev patchelf cmake

