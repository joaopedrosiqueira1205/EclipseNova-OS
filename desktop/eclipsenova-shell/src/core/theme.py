import json
import os


THEME_SOL = {
    "name": "Sol",
    "background": "#E8D7A5",
    "panel": "#D1B979",
    "text": "#302817",
    "accent": "#B88A24",
    "symbol": "☀"
}

THEME_LUA = {
    "name": "Lua",
    "background": "#10182B",
    "panel": "#182440",
    "text": "#E5E8EF",
    "accent": "#8CA5C9",
    "symbol": "☾"
}


CONFIG_DIR = os.path.join(
    os.path.expanduser("~"),
    ".config",
    "eclipsenova"
)

CONFIG_FILE = os.path.join(
    CONFIG_DIR,
    "settings.json"
)


def save_theme(theme):
    os.makedirs(CONFIG_DIR, exist_ok=True)

    data = {
        "theme": theme["name"]
    }

    with open(CONFIG_FILE, "w", encoding="utf-8") as file:
        json.dump(data, file, indent=4)


def load_theme():
    try:
        with open(CONFIG_FILE, "r", encoding="utf-8") as file:
            data = json.load(file)

        if data.get("theme") == "Lua":
            return THEME_LUA

    except (FileNotFoundError, json.JSONDecodeError):
        pass

    return THEME_SOL