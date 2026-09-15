# team-shell

Shared Cloud Shell setup for the tworiver.bio team.

## First-time setup

Open this repo in Cloud Shell (clones it to `~/team-shell`):

https://shell.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/YOURORG/team-shell

Then run once:

    ~/team-shell/setup.sh

Open a new tab (or `source ~/.bashrc`). You now have:

- gcloud defaults: project `cs-project-qkuds7ux`, zone `us-central1-a`
- `ssh gpu` — starts the GPU box if it's stopped, then connects through IAP.
  `scp`, `rsync`, and VS Code Remote-SSH work with the same host name.
- numpy installed for the Cloud Shell Python

Updates to this repo are pulled automatically on each new shell.

## Adding a machine

1. Label the VM: `gcloud compute instances add-labels NAME --labels role=ROLE`
2. Copy the `Host gpu` block in `ssh_config` and change `gpu` to `ROLE` (both lines).
3. Commit. Teammates get it on next login; they re-run `setup.sh` to refresh `~/.ssh/config`.
