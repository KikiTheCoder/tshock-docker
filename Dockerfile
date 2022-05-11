# TShock provides Terraria servers with server-side characters, anti-cheat, and community management tools.
#
# docker run -dit --name=tshock -v <config path>:/opt/tshock -p 7777:7777 <image>

# get mono base
FROM mono:6.12.0.122

# install unzip
RUN apt-get update && \
    apt-get install -y \
    unzip

# grab tshock release
ENV TSHOCK_VERSION 4.5.17
ENV TERRARIA_VERSION 1.4.3.6
RUN cd /opt && \
    curl -OL "https://github.com/Pryaxis/TShock/releases/download/v${TSHOCK_VERSION}/TShock${TSHOCK_VERSION}_Terraria_${TERRARIA_VERSION}.zip" && \
    unzip TShock${TSHOCK_VERSION}_Terraria_${TERRARIA_VERSION}.zip

# set the working directory
WORKDIR /opt

# expose server port
EXPOSE 7777

# define default command
ENTRYPOINT /usr/bin/mono --server --gc=sgen -O=all TerrariaServer.exe -config /opt/tshock/serverconfig.txt -autocreate -world /opt/tshock/worlds/${WORLD}.wld -worldselectpath /opt/tshock/worlds -port 7777 -ip 0.0.0.0 -maxplayers 16
