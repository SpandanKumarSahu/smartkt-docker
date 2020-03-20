FROM ubuntu:16.04

# Install dependencies
RUN apt-get -qq update; \
    apt-get install -qqy --no-install-recommends \
        autoconf automake cmake dpkg-dev file git make patch curl \
        libc-dev libc++-dev libgcc-5-dev libstdc++-5-dev  dwarfdump \
        dirmngr gnupg2 lbzip2 wget xz-utils git ca-certificates \
        libxml2-dev g++ python3 python3-dev python3-pip vim castxml;

# Signing keys
RUN curl -k https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

# Install Clang and LLVM
RUN wget -nv --no-check-certificate -O llvm.tar.xz https://releases.llvm.org/6.0.1/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
RUN wget -nv --no-check-certificate -O llvm.tar.xz.sig https://releases.llvm.org/6.0.1/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz.sig
RUN tar xf llvm.tar.xz
RUN cp -a clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/* /usr/local/

# EXPOSE
EXPOSE 5000
EXPOSE 5001
EXPOSE 7000
EXPOSE 7777
EXPOSE 22

CMD exec "$@"
