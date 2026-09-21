import tkinter as tk

from core.apps import (
    open_files,
    open_terminal
)


def open_launcher(root, theme):
    launcher = tk.Toplevel(root)

    launcher.title("EclipseNova")
    launcher.geometry("320x430")
    launcher.resizable(False, False)

    launcher.configure(
        bg=theme["panel"]
    )

    title = tk.Label(
        launcher,
        text=theme["symbol"],
        font=("Serif", 48),
        bg=theme["panel"],
        fg=theme["accent"]
    )

    title.pack(pady=(25, 5))

    name = tk.Label(
        launcher,
        text="EclipseNova",
        font=("Serif", 20),
        bg=theme["panel"],
        fg=theme["text"]
    )

    name.pack(pady=(0, 20))

    options = [
        ("Aplicativos", None),
        ("Arquivos", open_files),
        ("Terminal", open_terminal),
        ("Configurações", None),
        ("Desligar", None)
    ]

    for text, command in options:
        button = tk.Button(
            launcher,
            text=text,
            command=command,
            font=("Serif", 12),
            bg=theme["panel"],
            fg=theme["text"],
            activebackground=theme["accent"],
            activeforeground=theme["text"],
            relief="flat",
            borderwidth=0
        )

        button.pack(
            fill="x",
            padx=35,
            pady=5
        )