# shrtrun

**shrtrun** is a lightweight shell-based launcher utility that lets you execute commands or trigger custom actions (like searches) using a prefix system. It uses `rofi` for user input and supports configurable settings via a simple `.conf` file.

---

## ✨ Features

- Run arbitrary shell commands
- Google and YouTube search with prefix commands
- Configurable browser and search engines
- Uses `rofi` as the input interface
- Minimal logging for debugging
- Notification support (via `notify-send`)

---

## 📦 Requirements

Make sure the following dependencies are installed:

- `bash` (default on most systems)
- `rofi` – for the graphical input menu
- `xdg-open` – to open URLs with the default browser
- `notify-send` (optional) – for desktop notifications

**Install on Debian/Ubuntu:**

```bash
sudo apt update
sudo apt install rofi xdg-utils libnotify-bin
