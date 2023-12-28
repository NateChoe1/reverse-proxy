FROM nginx:latest
EXPOSE 80
EXPOSE 443
RUN apt-get update && apt-get upgrade -y
RUN apt-get install python3-certbot-nginx certbot cron -y

# Rebuilds don't cache artifacts
ARG CACHEBUST=1

COPY ./artifacts /artifacts
RUN /artifacts/build.sh
ENTRYPOINT [ "/artifacts/start.sh" ]
