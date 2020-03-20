FROM ubuntu:16.04

ENV HTTP_PROXY "http://172.16.2.30:8080"
ENV HTTPS_PROXY "http://172.16.2.30:8080"
ENV http_proxy "http://172.16.2.30:8080"
ENV https_proxy "http://172.16.2.30:8080"
ENV HTTP_PROXY=http://172.16.2.30:8080
ENV HTTPS_PROXY=http://172.16.2.30:8080
ENV http_proxy=http://172.16.2.30:8080
ENV https_proxy=http://172.16.2.30:8080
ENV NO_PROXY "127.0.0.1, localhost"

COPY apt.conf /etc/apt/apt.conf.d/proxy.conf

# Install dependencies
RUN apt-get -qq update; \
    apt-get install -qqy --no-install-recommends \
        autoconf automake cmake dpkg-dev file git make patch curl \
        libc-dev libc++-dev libgcc-5-dev libstdc++-5-dev  \
        dirmngr gnupg2 lbzip2 wget xz-utils git ca-certificates \
        libxml2-dev g++ python3 python3-dev python3-pip vim;

# Signing keys
RUN curl -k https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

# Install Clang and LLVM
RUN wget -nv --no-check-certificate -O llvm.tar.xz https://releases.llvm.org/6.0.1/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz
RUN wget -nv --no-check-certificate -O llvm.tar.xz.sig https://releases.llvm.org/6.0.1/clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04.tar.xz.sig
RUN tar xf llvm.tar.xz
RUN cp -a clang+llvm-6.0.1-x86_64-linux-gnu-ubuntu-16.04/* /usr/local/ 


# Set Git proxy
RUN git config --global http.proxy 172.16.2.30:8080
RUN git config --global https.proxy 172.16.2.30:8080

# EXPOSE
EXPOSE 5000
EXPOSE 5001
EXPOSE 7000
EXPOSE 7777
EXPOSE 22

CMD exec "$@"
