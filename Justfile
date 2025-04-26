default:
  @just --list

format-nix:
  @fd --extension nix --exec nixfmt {}

update:
  git add .
  darwin-rebuild switch --flake .

upgrade:
  nix flake update

edit-secrets:
  sops edit secrets.yaml

read-secrets:
  sops decrypt secrets.yaml

set-hostname new-hostname:
  sudo scutil --set LocalHostName {{new-hostname}}
  sed -i '' 's/hostname = ".*";/hostname = "{{new-hostname}}";/' ./lib/common.nix
