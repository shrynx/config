# Shriyans' Nix Darwin Configuration

A modular, maintainable Nix configuration for macOS using nix-darwin and home-manager.

## Structure

This configuration follows a simple modular structure:

```
.
├── lib
│   └── common.nix             # Common variables (username, hostname, etc.)
├── modules
│   ├── homebrew.nix           # All Homebrew-related configuration
│   ├── packages               # Nix packages configuration
│   ├── macos-defaults.nix     # Macos system defaults and preferences
│   └── system-config.nix      # Nix system configuration
├── flake.nix                  # Main flake entry point
├── home.nix                   # Home-manager configuration
└── dotfiles/                  # Your dotfiles directory
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
