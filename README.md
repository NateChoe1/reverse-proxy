# reverse-proxy docker image

This is the reverse-proxy that lives behind [natechoe.dev](https://natechoe.dev)
and [agilesalt.net](https://agilesalt.net). Both sites have a single public IP
address.

## Instructions

1. Have a machine ("amdserver") where you can run docker. Make sure ports 80 and 443 are available.
2. Set up your router to forward 80 and 443 to the amdserver.
3. On amdserver, clone this repo.
4. Set CERTBOT\_AGREE="y" in `docker-compose.yml`
4. Put your domain names into artifacts/domains
5. Put your email into artifacts/email
6. Run `./build.sh`
7. Run `docker-compose up -d`

## References

- https://phoenixnap.com/kb/nginx-reverse-proxy
- https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/
