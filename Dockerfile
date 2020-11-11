FROM ubuntu:20.04

ENV TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y wget unzip curl jq sed dpkg-dev build-essential \
                       debhelper devscripts autotools-dev meson pandoc \
                       libgtk-3-dev libgtksourceview-3.0-dev \
                       libwebkit2gtk-4.0-dev libgtkspell3-3-dev

COPY build.sh .

RUN mkdir /output

CMD ["./build.sh", "/output"]
