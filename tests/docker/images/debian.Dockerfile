FROM debian:10

## Tell systemd we are running in container
ENV container=docker

## Do not remove "iproute2" package is required to make {{ ansible_interfaces }} work
RUN apt update && \
    apt install -y systemd python3 python3-apt iproute2 && \
    ln -sf /lib/systemd/systemd /sbin/init

## Run systemd by default
ENTRYPOINT ["/sbin/init"]

CMD ["--unit=sysinit.target", "--log-level=info"]

## This makes systemd correctly respond on 'docker stop' command
STOPSIGNAL SIGRTMIN+3
