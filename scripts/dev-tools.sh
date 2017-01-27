

set -e

#emulator:
sudo apt-get install bochs bochs-x -y

#c/c++ compiler:
sudo apt-get install gcc -y

#tools to rebuild gcc as a cross-compiler:
mkdir -p tools
cd tools

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

cd ..
