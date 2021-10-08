FROM ubuntu:18.04

RUN apt update
RUN apt install -y software-properties-common curl
RUN add-apt-repository ppa:deadsnakes/ppa

RUN curl http://ppa.launchpad.net/deadsnakes/ppa/ubuntu/dists/bionic/main/binary-amd64/Packages.gz | \
  gunzip | grep '^Package' | \
  # Types of packages to remove. \
  # grep -v lib | \
  grep -v complete | \
  grep -v dbg | \
  # grep -v dev | \
  # grep -v distutils | \
  grep -v doc | \
  grep -v examples | \
  grep -v full | \
  grep -v gdbm | \
  grep -v idle | \
  grep -v lib2to3 | \
  grep -v minimal | \
  grep -v stdlib | \
  grep -v testsuite | \
  grep -v tk | \
  grep -v venv | \
  # Install. \
  awk '{print $2}' | xargs apt install -y

RUN apt remove -y software-properties-common curl
