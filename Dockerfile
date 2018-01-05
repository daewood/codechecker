FROM ubuntu:16.04

#stuff for codechecker editing
RUN apt-get update \
    && apt-get -y install apt-utils sudo git  wget curl \
    clang-3.9 build-essential curl doxygen gcc-multilib \
    git python-dev python-pip thrift-compiler \
    && pip install --upgrade pip \
    && pip install thrift psutil alembic portalocker \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

###The above should now change too often.
# below are the more lightweight stuff that can change more often

RUN cd /opt \
    && git clone https://github.com/Ericsson/codechecker.git \
    && cd codechecker \
    && make package \
    && echo "export PATH=$PATH:/opt/codechecker/build/CodeChecker/bin/" >> /root/.bashrc

RUN wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && chmod +x /usr/bin/dumb-init

EXPOSE 8001
WORKDIR /works

CMD ["/opt/codechecker/build/CodeChecker/bin/CodeChecker","server","--host=0.0.0.0"]
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
