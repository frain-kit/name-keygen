# name-keygen
Generates ed-25519 ssh keys containing the specified string in public key.

Docker repository is [here](https://hub.docker.com/r/frainkit/name-keygen)

## How to use
The easiest way to use this image is with Docker Compose.

```yml
version: '3.7'

services:
  keygen:
    image: frainkit/name-keygen:1.0.0
    environment:
      - "NAMES=nameone:nametwo:namethree" # You can specify multiple strings using ":"
    volumes:
      - "./save/keys:/keys" # This is a directory where keys matching the pattern are stored.
      - "/tmp/ram:/workplace" # This is a directory where the key will be created; it is fastest to set up and use a RAM disk
    stop_grace_period: 1s
```

## Volumes
The `/keys` directory is used to store the keys. Without it, the keys are left inside the container, making retrieval cumbersome.
The `/workplace` directory is the directory where the keys are actually generated. It is recommended that this directory be a RAM disk, since the faster the read and write speeds, the faster the key generation.
