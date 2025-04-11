# 🚀 shrtrun

**shrtrun** is a lightweight command launcher script for Linux, powered by `rofi`. It supports quick access to web search engines, YouTube searches, and execution of shell commands through a simple and customizable interface.

## ✨ Features

- ⚡ Launch custom shell commands
- 🌐 Search the web using your preferred search engine
- 📺 Search YouTube directly
- 🛠️ Configurable via `~/.config/shrtrun/config.conf`
- 🕘 Command history for fast re-use

## 📦 Installation

1. Save the script (e.g., as `shrtrun.sh`) and make it executable:

```bash
chmod +x shrtrun.sh
```

2. (Optional) Move it somewhere in your `$PATH`:

```bash
mv shrtrun.sh ~/.local/bin/shrtrun
```

3. Run it via a keybinding or launcher

```bash
shrtrun
```

Or use the full path if not in your `$PATH` (e.g., `/path/to/shrtrun.sh`).

## ⚙️ Configuration

On first run, the script creates a config file at:

```
~/.config/shrtrun/config.conf
```

### 📝 Example config:

```
log_file: /logs/shrtrun.log
browser: firefox
search_engine: https://duckduckgo.com/?q=
youtube_search: https://www.youtube.com/results?search_query=
```

## 🧑‍💻 Usage

- 💬 **Regular Commands:** Type any shell command and hit Enter to execute it.
- 🧠 **Special Prefixes:**
  - `!g your search` — Searches the web via your configured search engine 🌍
  - `!y your search` — Searches YouTube 📹

## 📜 Command History

shrtrun keeps a history file at:

```
~/.config/shrtrun/history.txt
```

This lets you recall previous commands easily when relaunching shrtrun. Only successful or valid commands are saved.

## 🔧 Requirements

- `rofi`
- `awk`, `bash`, `xdg-open` (most likely pre-installed)
- Optional: `notify-send` for desktop notifications 🔔

### 📥 Install dependencies
- 🐧 **Debian/Ubuntu:** `sudo apt install rofi xdg-utils libnotify-bin`
- 🐧 **Arch/Manjaro:** `sudo pacman -S rofi xdg-utils libnotify`
- 🐧 **Fedora:** `sudo dnf install rofi xdg-utils libnotify`

## 🎨 Customization Ideas

- ➕ Add new command prefixes (e.g., `!r` for Reddit)
- 🎨 Change styling in `rofi` config
- 🌐 Sync history across machines

---

📝 **GPL License** – This project is licensed under the GNU General Public License. See the LICENSE file for more details. 🧾

