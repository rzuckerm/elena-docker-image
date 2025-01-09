FROM ubuntu:24.04

COPY ELENA_* /tmp/
RUN apt-get update && \
    apt-get install -y git make g++ && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/ELENA-LANG/elena-lang -b v$(cat /tmp/ELENA_VERSION) && \
    cd elena-lang && \
    make all_amd64 && \
    cd build/amd64 && \
    sed -i -e 's/echo "Do you wish .*/exit 0/' build_package_amd64.script && \
    ./build_package_amd64.script && \
    cd / && \
    apt-get remove -y git make && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /opt/elena-lang
