

set -e

mkdir -p tools
cd tools

#c/c++ compiler:
sudo apt-get install gcc -y

#emulator:
# sudo apt-get install bochs bochs-x -y
sudo apt-get install libgtk2.0-dev libncurses5-dev -y
curl -o bochs.tar.gz http://bochs.sourceforge.net/svn-snapshot/bochs-20170124.tar.gz
mkdir bochs
tar -zxf bochs.tar.gz -C bochs --strip-components 1
rm -f bochs.tar.gz

cd bochs
./configure --target=pentium \
    --enable-all-optimizations \
    --enable-cpu-level=6 \
    --enable-x86-64 \
    --enable-disasm \
    --enable-debugger \
    --enable-x86-debugger \
    --enable-debugger-gui \
    --enable-pci \
    --enable-vmx \
    --enable-fpu \
    --enable-3dnow \
    --enable-logging \
    --enable-cpp \
    --enable-cdrom \
    --enable-iodebug \
    --enable-sb16=dummy \
    --enable-smp \
    --disable-readline \
    --disable-plugins \
    --disable-docbook \
    --with-x --with-x11 --with-term
make
make install
cd ..

#cross-compiler version of gcc:
curl -o binutils.tar.gz http://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.gz
mkdir binutils
tar -zxf binutils.tar.gz -C binutils --strip-components 1
rm -f binutils.tar.gz

sudo apt-get install libisl-dev libcloog-isl-dev texinfo -y
#libgmp3-dev libmpfr-dev libmpc-dev

git clone http://github.com/gcc-mirror/gcc gcc-src
cd gcc-src
git checkout tags/gcc_5_3_0_release
./contrib/download_prerequisites
cd ..

#some helpful resource documents
mkdir -p interrupt-list
curl -o rolf-brown-a.zip http://www.cs.cmu.edu/~ralf/interrupt-list/inter61a.zip
curl -o rolf-brown-b.zip http://www.cs.cmu.edu/~ralf/interrupt-list/inter61b.zip
curl -o rolf-brown-c.zip http://www.cs.cmu.edu/~ralf/interrupt-list/inter61c.zip
curl -o rolf-brown-d.zip http://www.cs.cmu.edu/~ralf/interrupt-list/inter61d.zip
curl -o rolf-brown-e.zip http://www.cs.cmu.edu/~ralf/interrupt-list/inter61e.zip
curl -o rolf-brown-f.zip http://www.cs.cmu.edu/~ralf/interrupt-list/inter61f.zip
unzip -o rolf-brown-a.zip -d interrupt-list
unzip -o rolf-brown-b.zip -d interrupt-list
unzip -o rolf-brown-c.zip -d interrupt-list
unzip -o rolf-brown-d.zip -d interrupt-list
unzip -o rolf-brown-e.zip -d interrupt-list
unzip -o rolf-brown-f.zip -d interrupt-list
rm -f rolf-brown-a.zip
rm -f rolf-brown-b.zip
rm -f rolf-brown-c.zip
rm -f rolf-brown-d.zip
rm -f rolf-brown-e.zip
rm -f rolf-brown-f.zip

#and... we're done
cd ..
