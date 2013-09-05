#!/bin/sh

if [ ! -x "hooks/post-receive-push" ]; then
    echo "This is designed to be run from inside a git repo."
    exit 1
fi

# Otherwise openssh whines
SSH_KEY="/git/athena/private/github_id_rsa"
chmod=0
if [ "$(id -u)" = "$(stat -c '%u' "$SSH_KEY")" ]; then
    chmod 600 "$SSH_KEY"
    chmod=1
fi
hooks/post-receive-push
[ $chmod -eq 1 ] && chmod 640 "$SSH_KEY"
