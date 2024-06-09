FROM debian/eol:sarge

RUN apt-get update && apt-get install -y build-essential

WORKDIR /root
COPY linux-2.4.26.tar.gz .
RUN tar -zxvf linux-2.4.26.tar.gz
COPY src/linux-2.4.26-tcc.patch tcc.patch
RUN patch -p2 < tcc.patch
WORKDIR /root/linux-2.4.26
COPY src/linux-2.4.26-config .config
RUN make ARCH=i386 oldconfig
RUN make ARCH=i386 dep
RUN make ARCH=i386
RUN make ARCH=i386 bzImage

COPY tcc-0.9.22 /root/tcc-0.9.22
WORKDIR /root/tcc-0.9.22
RUN ./configure && make tcc

RUN apt-get install -y genromfs

COPY src /root/src
WORKDIR /root/src
RUN make
