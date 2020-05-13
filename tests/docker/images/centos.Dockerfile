FROM centos:7

## Tell systemd we are running in container
ENV container=docker

## Do not remove "iproute" package, it is required to make {{ ansible_interfaces }} work
RUN yum install -y iproute && \
    yum clean all

## Run systemd by default
ENTRYPOINT ["/sbin/init"]

CMD ["--unit=sysinit.target", "--log-level=info"]

## This makes systemd correctly respond on 'docker stop' command
STOPSIGNAL SIGRTMIN+3
