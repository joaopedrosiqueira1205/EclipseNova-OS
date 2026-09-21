import tkinter as tk

from components.launcher import open_launcher


def create_dock(root, theme, change_theme):
    dock = tk.Frame(
        root,
        height=70,
        bg=theme["panel"]
    )

    dock.pack(
        side="bottom",
        fill="x"
    )

    dock.pack_propagate(False)

    apps = [
        ("⌕", "Pesquisar"),
        ("📁", "Arquivos"),
        ("🌐", "Navegador"),
        (">_", "Terminal"),
        ("⚙", "Configurações")
    ]

    for symbol, name in apps:
        button = tk.Button(
            dock,
            text=symbol,
            font=("Arial", 18),
            relief="flat",
            borderwidth=0,
            bg=theme["panel"],
            fg=theme["text"],
            activebackground=theme["accent"],
            activeforeground=theme["text"]
        )

        button.pack(
            side="left",
            padx=10,
            pady=10
        )

    # Sol/Lua no canto inferior direito.
    # Este botão abre o menu principal.
    launcher_button = tk.Button(
        dock,
        text=theme["symbol"],
        command=lambda: open_launcher(root, theme),
        font=("Arial", 28),
        relief="flat",
        borderwidth=0,
        bg=theme["accent"],
        fg=theme["text"],
        activebackground=theme["accent"],
        activeforeground=theme["text"]
    )

    launcher_button.pack(
        side="right",
        padx=20,
        pady=8
    )

    return dock