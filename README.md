# Shriyans' Nix Darwin Configuration

A modular, maintainable Nix configuration for macOS using nix-darwin and home-manager.

## Structure

This configuration follows a simple modular structure:

```sh
.
├── lib
│   └── common.nix             # Common variables (username, hostname, etc.)
├── modules
│   ├── custom-packages/       # Custom nix packages
│   ├── packages.nix           # Nix packages configuration
│   ├── homebrew.nix           # All Homebrew-related configuration
│   ├── macos-defaults.nix     # Macos system defaults and preferences
│   └── system-config.nix      # Nix system configuration
├── dotfiles/                  # Dotfiles directory
├── secrets.yaml               # Sops encrypted secrets
├── flake.nix                  # Main flake entry point
└── home.nix                   # Home-manager configuration
```

## Usage

### Setup

1. Install Nix if you haven't already:

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
   ```

2. Clone this repository into `~/config`

3. Change the hostname in file `/lib/common.nix`, get hostname using

   ```bash
   scutil --get LocalHostName
   ```

### Building and Activating

To build without activating (test run):

```bash
darwin-rebuild build --flake  ~/config
```

To build and activate:

```bash
darwin-rebuild switch --flake ~/config
```
