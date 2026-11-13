# My Nix Configs

## How to get the IP address on target system?

`ip -4 addr`

## System Services and Logs

NixOS uses **systemd** to manage services and collect system logs. The two main commands are `systemctl` for managing services and `journalctl` for inspecting logs.

### systemctl — Manage Services

`systemctl` allows you to list, inspect, start, stop, and restart services. On NixOS, services should generally be configured declaratively in `configuration.nix`.

| Command | Description |
|---|---|
| `systemctl list-units --type=service --state=running` | List running services |
| `systemctl list-unit-files --type=service` | List installed services |
| `systemctl --failed` | Show failed units |
| `systemctl status <service>` | Check service status |
| `sudo systemctl restart <service>` | Restart a service |

### journalctl — View Logs

`journalctl` displays logs from services, the kernel, and other system processes. It is useful for diagnosing errors and understanding system behavior.

| Command | Description |
|---|---|
| `journalctl -b` | Logs from the current boot |
| `journalctl -b -1` | Logs from the previous boot |
| `journalctl -u <service>` | Logs for a specific service |
| `journalctl -b -p err` | Show errors |
| `journalctl -fu <service>` | Follow service logs in real time |
| `journalctl -n 50 --no-pager` | Show the latest 50 log entries |

**Tip:** Add `--no-pager` to avoid opening the terminal pager.

**Key distinction:** `systemctl` manages services; `journalctl` shows their logs.

## VM

I am running a NixOS VM on my MacBook Pro. See `hosts/vm.nix` for details. Rebuild via `nix run nixpkgs#nixos-rebuild -- switch \
  --flake .#vm \
  --target-host jo@ip \
  --build-host jo@ip \
  --elevate sudo \
  --ask-elevate-password`
