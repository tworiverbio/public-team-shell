#!/bin/bash
# One-time per-user setup for Cloud Shell. Safe to re-run.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"

# 1. Source team.sh from .bashrc (once)
grep -q '# team-shell' ~/.bashrc || echo "source $DIR/team.sh  # team-shell" >> ~/.bashrc

# 2. Python packages into persistent ~/.local
pip3 install --user -q numpy

# 3. SSH key registered with OS Login
mkdir -p ~/.ssh ~/.local/bin && chmod 700 ~/.ssh
[ -f ~/.ssh/google_compute_engine ] || ssh-keygen -t ed25519 -N "" -f ~/.ssh/google_compute_engine
gcloud compute os-login ssh-keys add --key-file ~/.ssh/google_compute_engine.pub --quiet >/dev/null

# 4. IAP proxy on PATH for ssh's ProxyCommand
ln -sf "$DIR/bin/iap-proxy" ~/.local/bin/iap-proxy

# 5. Team ssh_config block, with this user's OS Login username filled in
OSUSER=$(gcloud compute os-login describe-profile --format 'value(posixAccounts[0].username)')
touch ~/.ssh/config
# strip any previous team block, then append the current one
sed -i '/^# >>> team-shell/,/^# <<< team-shell/d' ~/.ssh/config
{ echo "# >>> team-shell"; sed "s/__OSLOGIN_USER__/$OSUSER/" "$DIR/ssh_config"; echo "# <<< team-shell"; } >> ~/.ssh/config
chmod 600 ~/.ssh/config

echo "Done. Open a new tab or run: source ~/.bashrc   Then try: ssh gpu"
