# Sourced by ~/.bashrc on every new Cloud Shell tab.

gcloud config set project cs-project-qkuds7ux --quiet 2>/dev/null
gcloud config set compute/zone us-central1-a --quiet 2>/dev/null
gcloud config set compute/region us-central1 --quiet 2>/dev/null

export PATH="$HOME/.local/bin:$PATH"

alias vms='gcloud compute instances list'

refresh_vms() {
  mkdir -p ~/.cache
  gcloud compute instances list --format 'value(name)' > ~/.cache/gce-vms.tmp 2>/dev/null \
    && mv ~/.cache/gce-vms.tmp ~/.cache/gce-vms
}
alias vms='gcloud compute instances list && refresh_vms'
refresh_vms &

# Quietly pick up team updates in the background
git -C "$(dirname "${BASH_SOURCE[0]}")" pull -q 2>/dev/null &

