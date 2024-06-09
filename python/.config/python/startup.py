# See https://unix.stackexchange.com/a/297834
import readline

readline.write_history_file = lambda *_: None
