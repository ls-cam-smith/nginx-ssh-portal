# nginx-ssh-portal

```
docker build -t nginx-ssh-portal .
docker run -it -p 80:80 -p 22:22 \
  -e SSH_HOST_ED25519_KEY="SSH_HOST_ED25519_KEY_CONTENTS" \
  -e SSH_HOST_ED25519_PUBLIC_KEY="SSH_HOST_ED25519_PUBLIC_KEY_CONTENTS" \
  -e SSH_AUTHORIZED_KEYS="Users authorized keys" \
  nginx-ssh-portal
```

### Helm

The helm chart is untested. You will need to push this to a container registry of your choice and specify a value for the image source.
