FROM ubuntu:jammy

LABEL maintainer="suisrc@outlook.com"

# update linux
RUN apt update && apt install --no-install-recommends -y \
    sudo ca-certificates curl procps bash net-tools iputils-ping nano ntpdate locales &&\
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

ENV K3S_VERSION=v1.25.8+k3s1
RUN curl -fSL "https://github.com/k3s-io/k3s/releases/download/${K3S_VERSION}/k3s" -o /bin/k3s &&\
    chmod +x /bin/k3s

ENV CRI_CONFIG_FILE=/var/lib/rancher/k3s/agent/etc/crictl.yaml
VOLUME ["/var/lib/rancher/k3s", "/var/lib/kubelet", "/var/lib/cni", "/var/log"]

ENTRYPOINT ["/bin/k3s"]
CMD ["agent"]
