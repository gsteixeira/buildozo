FROM debian

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update

RUN apt-get install -y apt-utils && \
    apt-get -y dist-upgrade && \
    apt-get -y install tar bzip2 gzip wget apt-utils locales vim git
    
ENV LANG en_US.utf8
ENV LC_ALL en_US.utf8


RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US en_US.utf8 pt_BR pt_BR.utf8 && \
    dpkg-reconfigure locales

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/

ADD etc/ /etc/

RUN dpkg --add-architecture i386 && \
    apt-get update && \ 
    apt-get install -y python wget curl python-dev cython mercurial \ 
                        sqlite3 libsqlite3-dev openjdk-7-jdk \ 
                        build-essential ccache git unzip\ 
                        libncurses5:i386 libstdc++6:i386 libgtk2.0-0:i386 \ 
                        libpangox-1.0-0:i386 libpangoxft-1.0-0:i386  \ 
                        libidn11:i386 zlib1g:i386 zlib1g-dev \ 
                        python2.7 python2.7-dev 


RUN apt-get build-dep -y pygame libxml2 && \
    cd /usr/src/ && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \ 
    pip install -U Cython && \ 
    pip install hg+http://bitbucket.org/pygame/pygame 

ADD tmp/requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

# ADD tmp/ /usr/src/
# RUN cd /usr/src/passwall && \
RUN cd /usr/src/ && \
#     pip install virtualenv && \ 
#     virtualenv /venvs/passwall/ && \
#     . /venvs/passwall/bin/activate && \
    git clone https://github.com/gstsistemas/passwall && \ 
    cd passwall && \ 
    pip install Cython && \ 
    pip install -r requirements.txt && \
    cd /usr/src/passwall && \
    buildozer android debug && \
    apt-get clean
    
    
CMD ["/etc/entrypoint.sh"]
# CMD ["/bin/bash"]
