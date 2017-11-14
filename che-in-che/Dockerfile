FROM eclipse/che-dev:nightly

RUN mkdir /home/user/traefik ;\
    wget -O /home/user/traefik/traefik "https://github.com/containous/traefik/releases/download/v1.4.3/traefik_linux-amd64"; \
    chmod +x /home/user/traefik/traefik
COPY traefik.toml /home/user/traefik/
