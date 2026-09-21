import subprocess
import platform
import os


def open_terminal():
    try:
        if platform.system() == "Linux":
            subprocess.Popen(["xfce4-terminal"])
        elif platform.system() == "Windows":
            subprocess.Popen(["cmd.exe"])
    except Exception as error:
        print("Erro ao abrir terminal:", error)


def open_files():
    try:
        if platform.system() == "Linux":
            subprocess.Popen(["thunar"])
        elif platform.system() == "Windows":
            subprocess.Popen(["explorer.exe"])
    except Exception as error:
        print("Erro ao abrir arquivos:", error)


def open_documents():
    documents = os.path.expanduser("~/Documents")

    try:
        if platform.system() == "Linux":
            subprocess.Popen(["thunar", documents])
        elif platform.system() == "Windows":
            os.startfile(documents)
    except Exception as error:
        print("Erro ao abrir documentos:", error)