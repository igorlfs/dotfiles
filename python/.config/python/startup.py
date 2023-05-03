# See https://unix.stackexchange.com/a/261017
import sys


def register_readline_completion():
    # rlcompleter must be loaded for Python-specific completion
    try:
        import readline, rlcompleter
    except ImportError:
        return
    # Enable tab-completion
    readline_doc = getattr(readline, "__doc__", "")
    if readline_doc is not None and "libedit" in readline_doc:
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind("tab: complete")


sys.__interactivehook__ = register_readline_completion
