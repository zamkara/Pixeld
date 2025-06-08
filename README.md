# PixelD

`pixeld` is a minimal yet powerful CLI tool to interact with the [PixelDrain](https://pixelddrain.com) file hosting service. It allows you to upload, download, inspect, and manage files from the terminal. This tool is ideal for automation, scripting, or quick file sharing from the command line.

## 🌐 Abstract

PixelDrain is a fast and privacy-friendly file sharing service. `pixeld` wraps around its API to allow developers and command-line users to quickly interact with their PixelDrain account without relying on a graphical interface. Built for speed and simplicity, `pixeld` supports multi-file operations.

## ✨ Features

* Upload one or more files with real-time progress and speed
* Download files by ID
* View file metadata
* Delete individual or multiple files
* Purge all (local listed) files in your account
* Auto-detects and supports Bash, Zsh, and Fish shells

## 🔧 Requirements

Make sure the following dependencies are installed:

* `curl`
* `jq`
* POSIX-compliant shell (Bash, Zsh, Fish supported)

## 📦 Installation

### 🔁 One-liner Installation (Bash/Zsh/Fish):

```bash
curl -fsSL https://raw.githubusercontent.com/zamkara/pixeld/main/install.sh -o install.sh && sh install.sh
```

This script:

* Downloads the `pixeld` executable to `/usr/local/bin/pixeld`
* Makes it executable
* Prompts for your PixelDrain API key and guides you to set it based on your shell

You may be asked for `sudo` permission during install.

## 🔐 API Key Setup

After installation, you'll be prompted to set your API key. Here's how you can do it manually for different shells:

### Bash / Zsh:

Add to `~/.bashrc` or `~/.zshrc`:

```bash
export PIXEL_API_KEY=your_api_key_here
```

Then reload:

```bash
source ~/.bashrc # or source ~/.zshrc
```

### Fish:

```fish
set -Ux PIXEL_API_KEY your_api_key_here
```

To remove:

```fish
set -eU PIXEL_API_KEY
```

## 🚀 Usage

```bash
pixeld upload <file1> [file2 ...]      # Upload one or more files
pixeld download <id1> [id2 ...]        # Download file(s) by ID
pixeld info <id1> [id2 ...]            # Show metadata for files
pixeld delete <id1> [id2 ...]          # Delete files by ID
pixeld purge                           # Delete all files (with confirmation)
```

## 🧪 Examples

### Upload:

```bash
pixeld upload photo.jpg notes.pdf
```

### Download:

```bash
pixeld download AbCdEfGh QwErTyUi
```

### Delete:

```bash
pixeld delete AbCdEfGh
```

### Purge:

```bash
pixeld purge
# Lists files and asks: Are you sure you want to delete ALL files? [y/N]
```

## ⚙ Installer Script

The installer script is available at:

```
https://raw.githubusercontent.com/zamkara/pixeld/main/install.sh
```

It:

* Installs `pixeld` to `/usr/local/bin`
* Sets permissions
* Prompts user to enter their API key interactively
* Displays quick start usage instructions

## 📜 License

MIT License. See [LICENSE](LICENSE) for details.

## 🙇 Credits

Developed by [@zamkara](https://github.com/zamkara)

Powered by:

* [PixelDrain API](https://pixelddrain.com)
* Bash + Fish Shell scripting
* `curl` and `jq`
