FROM ubuntu:16.04

#This is used to make sure we dont get any questions about installing recommended extras, if I recall correctly
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#some musts and some nice to haves
RUN apt-get update \
        && apt-get -y install \
        sudo \
        git \
        wget \
        curl \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

USER root
###The above should not change often at all

#stuff for codechecker editing
RUN apt-get update && apt-get -y install clang-3.9 build-essential curl doxygen gcc-multilib \
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

EXPOSE 8001

CMD ["/opt/codechecker/build/CodeChecker/bin/CodeChecker","server","--host=0.0.0.0"]
#CMD /bin/bash
#ENTRYPOINT
