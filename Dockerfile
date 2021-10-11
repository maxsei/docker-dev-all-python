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

# Ensure pip for each version installed.
RUN mkdir pip-installers
RUN curl -s https://bootstrap.pypa.io/pip/get-pip.py >pip-installers/get-pip.py
RUN for PY_VERSION in $(curl -s https://bootstrap.pypa.io/pip/ | grep -Po '(?<=href\=\")\d.\d'); do \
  curl -s https://bootstrap.pypa.io/pip/$PY_VERSION/get-pip.py >pip-installers/get-pip-$PY_VERSION.py; \
done
RUN for PYTHON_BIN in $(bash -c 'compgen -c | grep -P "^python\d(\.\d){1,2}$"'); do \
  for PIP_INSTALLER in $(ls pip-installers); do \
    $PYTHON_BIN ./pip-installers/$PIP_INSTALLER && break; \
  done;\
done
RUN rm pip-installers -rf
