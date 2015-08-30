FROM ubuntu

RUN apt-get update && apt-get install -y \
wget

WORKDIR /root

RUN wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
sed -n "s/^.*stable-download.*: \"\(.*\)\".*/\1/p" | \
wget --no-check-certificate -i - -O nzbget-latest-bin-linux.run || \
echo "*** Download failed ***" 

RUN ["sh","nzbget-latest-bin-linux.run"]

ENV PATH /root/nzbget/:$PATH

expose 6789

VOLUME ["/config"]
VOLUME ["/downloads"]

CMD ["nzbget","-D","-c","/config/nzbget.conf"]

