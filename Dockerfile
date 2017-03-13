FROM xdebian

RUN apt-get update && \ 
    apt-get install -y python-pip
    

RUN apt-get install -y python-dev cython python-kivy

RUN pip install buildozer kivy

ADD etc/ /etc/
RUN apt-get update
RUN apt-get build-dep -y python-pygame
RUN apt-get install -y openjdk-7-jdk

RUN apt-get install -y sqlite3 libsqlite3-dev
ADD tmp/ /usr/src/
RUN apt-get install -y mercurial
RUN pip install hg+http://bitbucket.org/pygame/pygame
RUN cd /usr/src/passwall && \
    pip install -r requirements.txt 
    

RUN cd /usr/src/passwall && \
    buildozer android debug
    
RUN dpkg --add-architecture i386 && \
    apt-get update && \ 
    apt-get install -y build-essential ccache git libncurses5:i386 libstdc++6:i386 libgtk2.0-0:i386 libpangox-1.0-0:i386 libpangoxft-1.0-0:i386 libidn11:i386 python2.7 python2.7-dev openjdk-7-jdk unzip zlib1g-dev zlib1g:i386
    
ENTRYPOINT /bin/bash
