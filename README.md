# Dotfiles ⚙️ 

My Developer First macOS setup using a modular "System vs. Project" approach for speed, isolation, and automation.

## 📂 Structure
* `install.sh` — The master bootstrap script that sets up the environment from scratch.
* `Brewfile` — Declarative list of all Homebrew formulae and casks.
* `mise.toml` — Global configuration for language runtimes (Java, Node, Python).
* `.zshrc` — Shell configuration, aliases, and environment variables.
* `.zsh/` — Directory containing modular shell functions (e.g., `sweep`, `sysdiag`).
* `.zprofile` — Handles system-level initialization once at login.
* `.gitignore` — Prevents local secrets and cache junk from being pushed.

## 🚀 Bootstrap Guide

If you are starting from a fresh macOS installation, follow these steps:

### 1. Initial Setup
Open your terminal and ensure you have command-line tools installed:
```bash
xcode-select --install
```

### 2. Clone the Repository
```bash
mkdir -p ~/GitHub && cd ~/GitHub
git clone https://github.com/D-anijel-S-tefanovic/dotfiles.git
cd dotfiles
```

### 3. Run the Bootstrap
Make the installer executable and run it:
```bash
chmod +x install.sh
./install.sh
```

## 🛠️ Maintenance & Diagnostics

Use these commands to keep your machine clean and healthy:

* **Update & Sync:** Run `./install.sh && sweep && sysdiag` to sync your tools, purge cache, and run a health check.
* **`sweep`**: Manually clear cached build artifacts and system junk.
* **`sysdiag`**: Get an instant report on your system status (runtimes, cache sizes, and storage metrics).
