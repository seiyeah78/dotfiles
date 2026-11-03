FROM registry.access.redhat.com/ubi9/ubi:9.8

USER root
RUN dnf install -y bash ca-certificates curl-minimal git shadow-utils tar gzip \
    && dnf clean all


RUN groupadd --gid 1000 agent \
    && useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash agent \
    && mkdir -p /home/agent/workspace /home/agent/.local/bin \
        /home/agent/.local/share /home/agent/.local/state \
        /home/agent/.config/claude-team /home/agent/.docker/sandbox/locks \
    && chown -R agent:agent /home/agent

RUN update-ca-trust \
    && mkdir -p /usr/local/share/ca-certificates /etc/ssl/certs \
    && cp /etc/pki/tls/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt \
    REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt \
    NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

RUN touch /etc/sandbox-persistent.sh \
    && chown agent:agent /etc/sandbox-persistent.sh \
    && chmod 0644 /etc/sandbox-persistent.sh \
    && printf '%s\n' '. /etc/sandbox-persistent.sh' \
        > /etc/profile.d/sandbox-persistent.sh \
    && printf '%s\n' '. /etc/sandbox-persistent.sh' >> /home/agent/.bashrc

ENV HOME=/home/agent \
    PATH="/home/agent/.local/bin:${PATH}" \
    BASH_ENV=/etc/sandbox-persistent.sh


USER agent
ENV CLAUDE_ENV_FILE=/etc/sandbox-persistent.sh \
    IS_SANDBOX=1
ARG CLAUDE_VERSION
RUN curl -fsSL https://claude.ai/install.sh -o /tmp/install-claude.sh \
    && bash /tmp/install-claude.sh "${CLAUDE_VERSION}" \
    && rm /tmp/install-claude.sh

WORKDIR /home/agent/workspace
ENTRYPOINT ["claude", "--settings", "/home/agent/.config/claude-team/settings.json"]
CMD []
