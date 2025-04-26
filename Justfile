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

get-sops-key item-name:
  if [ "$(bw status | jq -r '.status')" = "unauthenticated" ]; then bw login --raw > ~/.bw-session; elif [ "$(bw status | jq -r '.status')" = "locked" ]; then bw unlock --raw > ~/.bw-session; fi
  mkdir -p ~/.config/sops/age
  export BW_SESSION=$(cat ~/.bw-session) && bw get item $(bw list items --search {{item-name}} | jq -r '.[0].id') | jq -r '.notes' > ~/.config/sops/age/keys.txt
  rm -rf ~/.bw-session
  echo "Key added to ~/.config/sops/age/keys.txt"
