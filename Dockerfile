FROM ubuntu
MAINTAINER Tom Fagerland

# This Dockerfile will NOT WORK without a volume mapped to /work.
# Please use start.sh or at least read it, understand ut, and then copy it
# in your own environment BEFORE filing a bug

VOLUME /work
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install git gcc gcc-avr avr-libc make moreutils -y
RUN git clone https://github.com/jackhumbert/qmk_firmware.git /qmk
COPY lib/make.sh /qmk/keyboards/planck/make.sh
RUN chmod a+x /qmk/keyboards/planck/make.sh