# My dotfiles

This repo contains some important configuration files I might want across
various machines. As such, this is a relatively personal set of files, with few
of them relevant to other people.

I manage my dotfiles with [chezmoi](https://www.chezmoi.io/), making it easy to
sync changes.

## Setting up a new machine

1. Add [age](https://age-encryption.org/) private key.

```sh
touch ~/age-key.txt
chmod 700 ~/age-key.txt
...
```

2. Install and initialize chezmoi.

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply bsoyka
```

## Explanation of files

| File path | Description |
|---|---|
| [`.config/fish/config.fish`](home/dot_config/fish/config.fish) | fish shell configuration |
| [`.config/git/ignore`](home/dot_config/git/ignore) | Global Git ignore list |
| [`.ssh/config`](home/private_dot_ssh/encrypted_config.age) | SSH configuration, including aliases and key agent (encrypted) |
| [`.ssh/known_hosts`](home/private_dot_ssh/encrypted_private_known_hosts.age) | Known SSH host identities (encrypted) |
| [`.gitconfig`](home/dot_gitconfig.tmpl) | Configuration options for Git |

## Explanation of scripts

### [1Password agent symlink](home/run_once_1password_agent_symlink.sh.tmpl)

This script runs once on Mac devices to symlink the 1Password SSH agent to its
more common Linux location, making SSH configuration simpler to manage across
both platforms.
