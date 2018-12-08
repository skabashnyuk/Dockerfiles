FROM alpine:3.8  as builder

ENV HOME=/home/user
WORKDIR ${HOME}

RUN PACKAGE="wget ca-certificates git bash xvfb x11vnc supervisor wget curl" && \
    apk update upgrade --no-cache && apk add --no-cache ${PACKAGE} && \
    # noVNC download
    git clone https://github.com/novnc/noVNC.git /opt/novnc \
    && git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify

COPY novnc-index.html /opt/novnc/index.html
# Add VNC startup script
COPY start-vnc-session.sh /usr/bin/
RUN chmod +x /usr/bin/start-vnc-session.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


RUN adduser --disabled-password -S -u 1001 -G root -h ${HOME} -s /bin/sh user \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    # Create /projects for Che
    && mkdir /projects \
    #&& for f in "${HOME}" "/etc/passwd" "/etc/group /projects"; do\
    #       sudo chgrp -R 0 ${f} && \
    #       sudo chmod -R g+rwX ${f}; \
    #   done \
    && cat /etc/passwd | sed s#root:x.*#root:x:\${USER_ID}:\${GROUP_ID}::\${HOME}:/bin/bash#g > ${HOME}/passwd.template \
    && cat /etc/group | sed s#root:x:0:#root:x:0:0,\${USER_ID}:#g > ${HOME}/group.template \
    # Cleanup tmp folder
    && rm -rf /tmp/* \
    # Change permissions to allow editing of files for openshift user
    && find ${HOME} -exec sh -c "chgrp 0 {}; chmod g+rwX {}" \;


USER user

#https://az764295.vo.msecnd.net/stable/bc24f98b5f70467bc689abf41cc5550ca637088e/code-stable-1542309103.tar.g
WORKDIR /projects

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
