FROM debian:stretch
MAINTAINER Nelson Gomez <nelson.gomez@columbia.edu>

# Make sure container is up-to-date
RUN echo "deb http://ftp.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/backports.list
RUN apt-get update
RUN apt-get -y upgrade

# Install dependencies for MicroC
RUN apt-get -y install ocaml m4 cmake pkg-config git opam
RUN apt-get -t stretch-backports -y install llvm-5.0-dev

# Set up OPAM and its MicroC dependencies
RUN opam init
RUN eval `opam config env`
RUN opam install llvm
