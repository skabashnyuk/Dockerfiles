FROM eclipse/che-dev:nightly

RUN mkdir /home/user/traefik ;\
    wget -O /home/user/traefik/traefik "https://github.com/containous/traefik/releases/download/v1.4.3/traefik_linux-amd64"; \
    chmod +x /home/user/traefik/traefik
COPY traefik.toml /home/user/traefik/

RUN rm -rf /home/user/tomcat8 ;\
     wget -O  /home/user/tomcat8.zip "http://maven.codenvycorp.com/content/groups/public/org/eclipse/che/lib/che-tomcat8-slf4j-logback/6.0.0-M1/che-tomcat8-slf4j-logback-6.0.0-M1.zip" ;\
     unzip   /home/user/tomcat8.zip -d /home/user/tomcat8;\
     rm /home/user/tomcat8.zip;\
     mkdir /home/user/tomcat8/webapps

