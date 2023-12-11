FROM ubuntu:22.04

COPY ELENA_* /tmp/
RUN apt-get update && \
    apt-get install -y git make g++-multilib && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/ELENA-LANG/elena-lang -b v$(cat /tmp/ELENA_VERSION) && \
    cd elena-lang && \
    make all_i386 && \
    cd install/i386 && \
    sed -i -e 's/echo "Do you wish .*/exit 0/' build_package_i386.script && \
    ./build_package_i386.script && \
    cd / && \
    apt-get remove -y git make && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /opt/elena-lang
