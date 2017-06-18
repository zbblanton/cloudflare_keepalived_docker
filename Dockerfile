############################################################
# Dockerfile to build Cloudflare Keepalived
############################################################

FROM debian
MAINTAINER Zachary Blanton
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y dialog net-tools cron git python python-pip
    
RUN mkdir /cloudflare_keepalived
RUN git clone https://github.com/zbblanton/cloudflare_keepalived.git /cloudflare_keepalived

RUN sed -i 's/CLOUDFLARE API KEY/PUT YOUR CLOUDFLARE API KEY HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/CLOUDFLARE EMAIL/PUT YOUR CLOUDFLARE EMAIL HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/DOMAIN/PUT YOUR DOMAIN HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/CLOUDFLARE ZONE ID/PUT YOUR CLOUDFLARE ZONE ID HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/SENDMAIL API KEY/PUT YOUR SENDMAIL API KEY HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/MAIL TO ADDRESS/PUT YOUR MAIL TO ADDRESS HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/MAIL FROM ADDRESS/PUT YOUR MAIL FROM ADDRESS HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i "s/'COMMA SEPARATED IP ADDRESSES'/'PUT YOUR IP HERE','PUT YOUR IP HERE','PUT YOUR IP HERE'/" /cloudflare_keepalived/cloudflare_keepalived.py 

RUN echo "* * * * * python /cloudflare_keepalived/cloudflare_keepalived.py" >> /temp_cron_file
RUN crontab /temp_cron_file
RUN rm /temp_cron_file

CMD ["cron", "-f"]