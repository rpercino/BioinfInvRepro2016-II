#################################################################
# Dockerfile 
#
# Version: 			1
# Software: 		FASTXToolkit
# Softare Version: 	0.0.14
# Description:      A set of tools written in bash and C++ for working with Fastxtoolkit files
# Website:          https://hannonlab.cshl.edu/fastx_toolkit/
# Tags:             Genomics
# Provides:         fastxtoolkit 0.1.14
# Base Image:       tareasbioinfinvrepro2016-II/biodocker
# Build Cmd:        docker build tareasbioinfinvrepro2016-II/fastxtoolkit 0.1.14/.
# Pull Cmd:         docker pull tareasbioinfinvrepro2016-II/fastxtoolkit 0.1.14
# Run Cmd:          docker run tareasbioinfinvrepro2016-II/fastoxtoolkit fastxtoolkit
#################################################################

# Set the base image to Ubuntu
FROM biodckr/biodocker

################## BEGIN INSTALLATION ###########################

# Change user to root
USER root

RUN apt-get update && \
  apt-get install g++ \
  apt-get clean && \
  apt-get purge && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#ADD FIlES

ENV ZIP=libgtextutils-0.7
ENV URL=https://github.com/agordon/libgtextutils/releases/download/0.7/libgtextutils-0.7.tar.gz
ENV FOLDER=libgtextutils-0.7
ENV DST=/tmp

RUN wget $URL/$ZIP -O $DST/$ZIP && \
  tar xvf $DST/$ZIP -C $DST && \
  rm $DST/$ZIP && \
  cd $DST/$FOLDER && \
  ./configure && \
  make && \
  make install && \
  cd / && \
  rm -rf $DST/$FOLDER
  
RUN ZIP=fastx_toolkit-0.0.14.tar.bz2 && \
  wget https://github.com/agordon/fastx_toolkit/releases/download/0.0.14/fastx_toolkit-0.0.14.tar.bz2
  unzip /tmp/$ZIP -d /home/biodocker/bin/ && \
  rm /tmp/$ZIP

WORKDIR /home/biodocker/bin/fastx_toolkit-0.0.14/

RUN ./configure && \
  make && \
	make install

WORKDIR /data/

################# END INSTALLATION ##############################

# File Author / Maintainer
Maintainer Ruth Percino <rpercino@gmail.com>
