# docker-python-all

Finding the right version to run your python scripts can be challenging sometimes. Often you want to start building but you might not know which python version you will need when choosing to use a particular python package.  The Dockerfile in this project solves this issue by including all pre-built python distributions from [deadsnakes](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa). All python packages that contain "lib, dev, distutils" are included in the build of this container.  You can enable specific package python builds by uncommenting them the Dockerfile for you specific use case. This Dockerfile is for development purposes and isn't for use in production due to it's large size and availability of commands.

The CPU architecture is a required build argument that must be one of the [supported architectures](http://ppa.launchpad.net/deadsnakes/ppa/ubuntu/dists/bionic/main/) prefixed by "binary-".
