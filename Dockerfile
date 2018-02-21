FROM debian:stretch
MAINTAINER Nelson Gomez <nelson.gomez@columbia.edu>

# Make sure container is up-to-date
RUN echo "deb http://ftp.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/backports.list
RUN apt-get update
RUN apt-get -y upgrade

# Install dependencies for MicroC
RUN apt-get -y install ocaml m4 cmake pkg-config git opam
RUN apt-get -t stretch-backports -y install llvm-5.0-dev

# Use a separate user for OPAM. OPAM complains if it's run as root,
# and probably for good reason.
RUN useradd -m opam -s /bin/bash
USER opam

# Initialize OPAM
RUN echo 'eval `opam config env`' >> $HOME/.bashrc
RUN echo '. /home/opam/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true' >> $HOME/.bashrc
RUN opam init
COPY .ocamlinit $HOME/.ocamlinit

# Set up basic compiler build dependencies
RUN opam install llvm

# Finalize base environment
WORKDIR /lang

# Set up additional OPAM/APT dependencies below this line
