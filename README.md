# Dotfiles

Managed using [chezmoi](https://www.chezmoi.io/).

### First start
Initialize chezmoi with `chezmoi init`.

Add files using `chezmoi add`.

Use `chezmoi cd` to open a subshell into the chezmoi source directory and use commit your changes.

### Quickstart
For a public repo, install your dotfiles on a new machine with:
```shell
chezmoi init --apply $GITHUB_USERNAME
```
