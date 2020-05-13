FROM archlinux:20200505

## Tell systemd we are running in container
ENV container=docker

## Do not remove "iproute2", it is required to make {{ ansible_interfaces }} work
RUN pacman -Syu --noconfirm python3 iproute2 && \
    ln -sf /lib/systemd/systemd /sbin/init

## Run systemd by default
ENTRYPOINT ["/sbin/init"]

CMD ["--unit=sysinit.target", "--log-level=info"]

## This makes systemd correctly respond on 'docker stop' command
STOPSIGNAL SIGRTMIN+3
