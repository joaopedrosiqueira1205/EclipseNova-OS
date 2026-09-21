#!/usr/bin/env python3

import tkinter as tk

from core.theme import (
    THEME_SOL,
    THEME_LUA,
    load_theme,
    save_theme
)

from components.sidebar import create_sidebar
from components.dock import create_dock
from components.topbar import create_topbar


current_theme = load_theme()


def change_theme():
    global current_theme

    if current_theme["name"] == "Sol":
        current_theme = THEME_LUA
    else:
        current_theme = THEME_SOL

    save_theme(current_theme)
    rebuild_interface()


def rebuild_interface():
    for widget in root.winfo_children():
        widget.destroy()

    root.configure(
        bg=current_theme["background"]
    )

    create_sidebar(
        root,
        current_theme
    )

    create_topbar(
        root,
        current_theme,
        change_theme
    )

    create_dock(
        root,
        current_theme,
        change_theme
    )

    workspace = tk.Frame(
        root,
        bg=current_theme["background"]
    )

    workspace.pack(
        fill="both",
        expand=True
    )

    welcome = tk.Label(
        workspace,
        text="EclipseNova",
        font=("Serif", 32),
        bg=current_theme["background"],
        fg=current_theme["text"]
    )

    welcome.place(
        relx=0.5,
        rely=0.45,
        anchor="center"
    )

    subtitle = tk.Label(
        workspace,
        text="Todo ciclo revela um novo horizonte.",
        font=("Serif", 14),
        bg=current_theme["background"],
        fg=current_theme["text"]
    )

    subtitle.place(
        relx=0.5,
        rely=0.53,
        anchor="center"
    )


root = tk.Tk()

root.title("EclipseNova Shell 0.3")

root.geometry("1200x700")
root.minsize(900, 550)

rebuild_interface()

root.mainloop()