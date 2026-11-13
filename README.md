# My Nix Configs

## How to get the IP address on target system?

`ip -4 addr`

## VM

I am running a NixOS VM on my MacBook Pro. See `hosts/vm.nix` for details. Rebuild via `nix run nixpkgs#nixos-rebuild -- switch \
  --flake .#vm \
  --target-host jo@ip \
  --build-host jo@ip \
  --elevate sudo \
  --ask-elevate-password`
