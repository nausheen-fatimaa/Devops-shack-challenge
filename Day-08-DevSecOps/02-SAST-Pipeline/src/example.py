import subprocess

def safe_example(user_input: str):
    # Training example: validate/allowlist inputs before passing them to commands.
    allowed = {"status", "version"}
    if user_input not in allowed:
        raise ValueError("unsupported command")
    return subprocess.run(["echo", user_input], check=True, capture_output=True, text=True)
