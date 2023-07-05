#!/usr/bin/env bash

set -euo pipefail

SSH_HOST_ED25519_KEY=${SSH_HOST_ED25519_KEY:-}
SSH_HOST_ED25519_PUBLIC_KEY=${SSH_HOST_ED25519_PUBLIC_KEY:-}

SSH_AUTHORIZED_KEYS=${SSH_AUTHORIZED_KEYS:-}

if [[ -n "${SSH_HOST_ED25519_KEY}" ]]; then
  echo "${SSH_HOST_ED25519_KEY}" >/etc/ssh/ssh_host_ed25519_key
  chown root:root /etc/ssh/ssh_host_ed25519_key
  chmod 0400 /etc/ssh/ssh_host_ed25519_key
  unset SSH_HOST_ED25519_KEY
else
  ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
fi

if [[ -n "${SSH_HOST_ED25519_PUBLIC_KEY}" ]]; then
  echo "${SSH_HOST_ED25519_PUBLIC_KEY}" >/etc/ssh/ssh_host_ed25519_key.pub
  chown root:root /etc/ssh/ssh_host_ed25519_key.pub
  chmod 0400 /etc/ssh/ssh_host_ed25519_key.pub
  unset SSH_HOST_ED25519_PUBLIC_KEY
fi

if [[ -n "${SSH_AUTHORIZED_KEYS}" ]]; then
  echo "${SSH_AUTHORIZED_KEYS}" >/home/publisher/.ssh/authorized_keys
  chown -R publisher:publisher /home/publisher/.ssh
  chmod 0400 /home/publisher/.ssh/authorized_keys
  unset SSH_AUTHORIZED_KEY
fi

exec supervisord -n -c /etc/supervisor/supervisord.conf
