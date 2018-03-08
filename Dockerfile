FROM        alpine:3.5
MAINTAINER  lavra

#       FXServer default build to use
#       Use --build-arg "FXS_BUILD=<ID>" to specify at build time
ARG     FXS_BUILD="401-7da138fa4851430482ff2fb4e196b871d5ea3efb"

#       Disable SECCOMP to make PROOT work 
ENV     PROOT_NO_SECCOMP 1

#       Update packages, then install any required for build process
RUN     apk update; \
        apk add wget xz

#       Create the folders used for data and the application
RUN     mkdir /var/fxserver; \
        mkdir /var/fxserver/resources; \
        mkdir /app

#       Set the working directory to the FXServer location
WORKDIR /app

#       Fetch and extract the specified FXServer build
RUN     wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${FXS_BUILD}/fx.tar.xz --no-check-certificate
RUN     tar xf fx.tar.xz
RUN     rm fx.tar.xz

#       Change to #!/bin/sh from #!/bin/bash
RUN     sed -i 's/bash/sh/g' /app/run.sh

#       Expose the necessary ports for FiveM
EXPOSE  30120
EXPOSE  30120/udp

#       Set the working directory for running the entry command
WORKDIR /var/fxserver

#       Run FXServer when the instance starts
CMD     ["/app/run.sh", "+exec", "server.cfg"]