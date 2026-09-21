import tkinter as tk


def create_topbar(root, theme, change_theme):
    topbar = tk.Frame(
        root,
        height=55,
        bg=theme["background"]
    )

    topbar.pack(side="top", fill="x")
    topbar.pack_propagate(False)

    theme_button = tk.Button(
        topbar,
        text="☀  Sol   |   Lua  ☾",
        command=change_theme,
        bg=theme["panel"],
        fg=theme["text"],
        relief="flat"
    )

    theme_button.pack(side="right", padx=20, pady=10)

    return topbar