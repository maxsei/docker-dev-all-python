FROM ubuntu:18.04

# Add deadsnakes repo.
RUN apt update
RUN apt install -y software-properties-common curl
RUN add-apt-repository ppa:deadsnakes/ppa

# Install python
COPY python-exts.txt .
RUN apt search --names-only "^python" |\
  grep -Po "^python\d(\.\d){0,2}($(grep -v "^#" python-exts.txt | sed 's/^/-/g' | paste -s -d '|'))*(?=\/)" |\
  xargs apt install -y
RUN rm python-exts.txt

# Ensure pip.
RUN for PY_VERSION in $(curl -s https://bootstrap.pypa.io/pip/ | grep -Po '(?<=href\=\")\d.\d'); do \
  curl -s https://bootstrap.pypa.io/pip/$PY_VERSION/get-pip.py | python$PY_VERSION - ; \
done
