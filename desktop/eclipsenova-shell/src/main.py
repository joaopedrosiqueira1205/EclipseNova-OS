#!/usr/bin/env python3

import tkinter as tk

THEME_SOL = {
    "background": "#e8d7a5",
    "panel": "#d1b979",
    "text": "#302817",
    "accent": "#b88a24",
    "symbol": "☀"
}

THEME_LUA = {
    "background": "#10182b",
    "panel": "#182440",
    "text": "#e5e8ef",
    "accent": "#8ca5c9",
    "symbol": "☾"
}

theme = THEME_SOL


def change_theme():
    global theme

    if theme == THEME_SOL:
        theme = THEME_LUA
    else:
        theme = THEME_SOL

    apply_theme()


def apply_theme():
    root.configure(bg=theme["background"])
    sidebar.configure(bg=theme["panel"])
    dock.configure(bg=theme["panel"])

    title.configure(
        bg=theme["panel"],
        fg=theme["text"]
    )

    theme_button.configure(
        text=theme["symbol"],
        bg=theme["accent"],
        fg=theme["text"]
    )

    launcher.configure(
        text=theme["symbol"],
        bg=theme["accent"],
        fg=theme["text"]
    )


root = tk.Tk()

root.title("EclipseNova Shell 0.1")
root.geometry("1200x700")

# Painel lateral
sidebar = tk.Frame(root, width=210)
sidebar.pack(side="left", fill="y")
sidebar.pack_propagate(False)

title = tk.Label(
    sidebar,
    text="EclipseNova",
    font=("Serif", 20)
)

title.pack(pady=30)

menus = [
    "Início",
    "Explorar",
    "Documentos",
    "Mídia",
    "Aplicativos",
    "Configurações",
    "Terminal",
    "Rede",
    "Lixeira"
]

for menu in menus:
    button = tk.Button(
        sidebar,
        text=menu,
        relief="flat"
    )

    button.pack(
        fill="x",
        padx=20,
        pady=4
    )

# Dock
dock = tk.Frame(root, height=70)
dock.pack(side="bottom", fill="x")

dock.pack_propagate(False)

for app in ["⌕", "📁", "🌐", ">_", "⚙"]:
    button = tk.Button(
        dock,
        text=app,
        font=("Arial", 18),
        relief="flat"
    )

    button.pack(
        side="left",
        padx=10,
        pady=10
    )

# Sol/Lua principal
launcher = tk.Button(
    dock,
    command=change_theme,
    font=("Arial", 28),
    relief="flat"
)

launcher.pack(
    side="right",
    padx=20,
    pady=8
)

# Seletor superior
theme_button = tk.Button(
    root,
    command=change_theme,
    font=("Arial", 18),
    relief="flat"
)

theme_button.place(
    relx=0.97,
    y=20,
    anchor="ne"
)

apply_theme()

root.mainloop()