FROM openjdk:8u181-jdk-alpine3.8

ENV HOME=/home/user
WORKDIR ${HOME}

RUN PACKAGE="ca-certificates supervisor" && \
    apk update upgrade --no-cache && apk add --no-cache ${PACKAGE}

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


ADD entrypoint.sh /entrypoint.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


ENTRYPOINT ["/entrypoint.sh"]
CMD /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf