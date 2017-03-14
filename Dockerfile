FROM xdebian

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


ADD tmp/ /usr/src/
RUN cd /usr/src/passwall && \
#     pip install virtualenv && \ 
#     virtualenv /venvs/passwall/ && \
#     . /venvs/passwall/bin/activate && \
    pip install Cython && \ 
    pip install -r requirements.txt && \
    cd /usr/src/passwall && \
    buildozer android debug && \
    apt-get clean
    
    
CMD ["/etc/entrypoint.sh"]
# CMD ["/bin/bash"]
