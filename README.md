# Simple Cloudflare Keepalived Docker Image

## Description
This is a simple docker that will run the script from https://github.com/zbblanton/cloudflare_keepalived every 1 minute using a cronjob.

## Requirements
* Cloudflare account
* Sendmail account (Optional)

## How To Use
```
git clone https://github.com/zbblanton/cloudflare_keepalived_docker.git
```

Edit the Dockerfile and fill in the variables where "PUT YOUR blank HERE" is:

```
RUN sed -i 's/CLOUDFLARE API KEY/PUT YOUR CLOUDFLARE API KEY HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/CLOUDFLARE EMAIL/PUT YOUR CLOUDFLARE EMAIL HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/DOMAIN/PUT YOUR DOMAIN HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/CLOUDFLARE ZONE ID/PUT YOUR CLOUDFLARE ZONE ID HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/SENDMAIL API KEY/PUT YOUR SENDMAIL API KEY HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/MAIL TO ADDRESS/PUT YOUR MAIL TO ADDRESS HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i 's/MAIL FROM ADDRESS/PUT YOUR MAIL FROM ADDRESS HERE/' /cloudflare_keepalived/cloudflare_keepalived.py \
    && sed -i "s/'COMMA SEPARATED IP ADDRESSES'/'PUT YOUR IP HERE','PUT YOUR IP HERE','PUT YOUR IP HERE'/" /cloudflare_keepalived/cloudflare_keepalived.py 
```

* To get the cloudflare zone id, simply login to cloudflare and copy the Zone ID from the Domain Summary.
* The ip list is the pool of server IP's, you can add or remove IP's here.

Once the Dockerfile has been edited you can run the following commands to build and run the container:

```
docker build -t cloudflare_keepalived_docker .
docker run -dt cloudflare_keepalived_docker
```

## Notes
* If sendmail is not required, you may need to add the python script manually and comment out the 2 send_mail functions at the end of the script.