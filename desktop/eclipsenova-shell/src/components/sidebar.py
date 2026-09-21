import tkinter as tk

from core.apps import (
    open_terminal,
    open_files,
    open_documents
)


def create_sidebar(root, theme):
    sidebar = tk.Frame(
        root,
        width=210,
        bg=theme["panel"]
    )

    sidebar.pack(
        side="left",
        fill="y"
    )

    sidebar.pack_propagate(False)

    title = tk.Label(
        sidebar,
        text="EclipseNova",
        font=("Serif", 20),
        bg=theme["panel"],
        fg=theme["text"]
    )

    title.pack(pady=25)

    menus = [
        ("Início", None),
        ("Explorar", open_files),
        ("Documentos", open_documents),
        ("Mídia", None),
        ("Aplicativos", None),
        ("Configurações", None),
        ("Terminal", open_terminal),
        ("Rede", None),
        ("Lixeira", None)
    ]

    for name, command in menus:
        button = tk.Button(
            sidebar,
            text=name,
            command=command,
            relief="flat",
            bg=theme["panel"],
            fg=theme["text"],
            activebackground=theme["accent"],
            activeforeground=theme["text"],
            borderwidth=0
        )

        button.pack(
            fill="x",
            padx=15,
            pady=3
        )

    return sidebar