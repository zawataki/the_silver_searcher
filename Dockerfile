FROM centos

LABEL maintainer="Yuki Takizawa <y.takizawa64@gmail.com>"

ENV LLVM_VERSION=6.0.1
ENV LLVM_PATH=$HOME/clang+llvm
ENV CLANG_FORMAT=$LLVM_PATH/bin/clang-format

RUN yum -y update \
 && yum -y groupinstall "Development Tools" \
 && yum -y install \
    pcre-devel \
    xz-devel \
    zlib-devel \
    wget \
 && yum clean all \
 && rm -rf /var/cache/yum \
 && wget http://llvm.org/releases/$LLVM_VERSION/clang+llvm-$LLVM_VERSION-x86_64-linux-gnu-ubuntu-14.04.tar.xz -O $LLVM_PATH.tar.xz \
 && mkdir $LLVM_PATH \
 && tar xf $LLVM_PATH.tar.xz -C $LLVM_PATH --strip-components=1 \
 && export PATH=$HOME/.local/bin:$PATH \
 && git clone https://github.com/ggreer/the_silver_searcher.git \
 && cd the_silver_searcher \
 && ./build.sh \
 && yum -y install epel-release \
 && yum -y install python-pip \
 && pip install pip --upgrade \
 && pip install cram \
 && make test

CMD yum -y update \
 && yum -y upgrade \
 && cd the_silver_searcher \
 && git pull --prune

