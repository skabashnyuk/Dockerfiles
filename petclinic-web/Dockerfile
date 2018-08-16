FROM rhche/centos_jdk8:latest


# The following lines are needed to set the correct locale after `yum update`
# c.f. https://github.com/CentOS/sig-cloud-instance-images/issues/71
RUN sudo localedef -i en_US -f UTF-8 C.UTF-8
ENV LANG="C.UTF-8"

# Generate passwd.template
RUN cat /etc/passwd | \
    sed s#user:x.*#user:x:\${USER_ID}:\${GROUP_ID}::\${HOME}:/bin/bash#g \
    > /home/user/passwd.template

# Generate group.template
RUN cat /etc/group | \
    sed s#root:x:0:#root:x:0:0,\${USER_ID}:#g \
    > /home/user/group.template

ENV HOME /home/user

# Overwride entrypoint
COPY ["entrypoint.sh","/home/user/entrypoint.sh"]
ENTRYPOINT ["/home/user/entrypoint.sh"]

CMD tail -f /dev/null




COPY ["init-maven.sh","/tmp/init-maven.sh"]
RUN sudo chown user:user /tmp/init-maven.sh && \
    chmod +x /tmp/init-maven.sh && \
    /tmp/init-maven.sh && \
    sudo rm -f /tmp/init-maven.sh


# Give write access to /home/user for
# users with an arbitrary UID
RUN sudo chgrp -R 0 /home/user \
  && sudo chmod -R g+rwX /home/user \
  && sudo chgrp -R 0 /etc/passwd \
  && sudo chmod -R g+rwX /etc/passwd \
  && sudo chgrp -R 0 /etc/group \
  && sudo chmod -R g+rwX /etc/group \
  && sudo mkdir -p /projects \
  && sudo chgrp -R 0 /projects \
  && sudo chmod -R g+rwX /projects
