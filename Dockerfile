FROM xdebian



RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list && \
    apt-get update
    
RUN apt-get update && \ 
    apt-get install -y python wget && \
    cd /usr/src/ && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py
    
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/
# python-kivy buildozer kivy 

ADD etc/apt/ /etc/apt/

RUN apt-get update && apt-get install -y curl python-dev cython mercurial sqlite3 libsqlite3-dev   openjdk-7-jdk && \ 
    apt-get build-dep -y python-pygame libxml2-dev
    
    RUN pip install hg+http://bitbucket.org/pygame/pygame && \
    
    dpkg --add-architecture i386 && \
    apt-get update && \ 
    apt-get install -y build-essential ccache git libncurses5:i386 libstdc++6:i386 libgtk2.0-0:i386 libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 python2.7 python2.7-dev openjdk-7-jdk unzip zlib1g-dev zlib1g:i386


ADD etc/ /etc/
ADD tmp/ /usr/src/
RUN pip install -U Cython
RUN cd /usr/src/passwall && \
    pip install -r requirements.txt 
    
RUN cd /usr/src/passwall && \
    buildozer android debug
    
    
ENTRYPOINT /bin/bash
