"""Double-click launcher: starts the server without debug mode or the
auto-reloader, in a background thread, then opens it in a native app
window (via pywebview) instead of a regular browser tab - no address
bar, tabs, or bookmarks, just the app itself. Closing that window ends
the whole program, server included (see _on_closed below), so there's
never a bare console window or a server still quietly listening after
the user thinks they've closed the program.

Use `python app.py` instead for development, which keeps Flask's debug
mode/auto-reload and opens in your own regular browser - the webview
window has no DevTools, address bar, or reload button."""

import os

# QtWebEngine (pywebview's Linux fallback backend, via requirements.txt's
# [qt] extra - GTK+WebKit has no pure-pip install path there) bundles its
# own Chromium renderer, which tries to set up a sandbox at startup; on
# many Linux setups (restricted user namespaces, some container/
# filesystem configurations) that check fails hard with a native abort
# before Python ever gets a chance to catch anything. Harmless to disable
# everywhere: it only does anything on the Qt backend, so it's a no-op on
# Windows (WebView2/edgechromium) and macOS (Cocoa/WebKit), and this is
# our own local server, not untrusted web content. Must be set before Qt
# itself initializes, which happens lazily inside webview.start() below -
# setting it this early is simplest and always early enough.
os.environ.setdefault("QTWEBENGINE_DISABLE_SANDBOX", "1")

import threading
import time
import urllib.error
import urllib.request

import webview

import app


def _wait_until_ready(url, timeout_seconds=15):
    deadline = time.monotonic() + timeout_seconds
    while time.monotonic() < deadline:
        try:
            urllib.request.urlopen(url, timeout=0.5)
            return
        except (OSError, urllib.error.URLError):
            time.sleep(0.25)  # server socket isn't listening yet - keep polling


def _on_closed():
    """The server runs as a daemon thread with no clean stop() of its
    own (Flask's dev server is meant to run for a process's whole
    lifetime), so the simplest way to guarantee it - and everything
    else - actually goes away the moment the window closes is to end
    the process outright, rather than trying to tear down each piece
    individually. SQLite's WAL mode (db.get_connection) is specifically
    built to tolerate exactly this kind of abrupt stop without
    corruption, so this is safe even mid-write."""
    os._exit(0)


if __name__ == "__main__":
    url = f"http://127.0.0.1:{app.PORT}/"

    server_thread = threading.Thread(
        target=app.run_server, kwargs={"debug": False, "open_browser": False}, daemon=True
    )
    server_thread.start()
    _wait_until_ready(url)

    window = webview.create_window("Solar Studio", url)
    window.events.closed += _on_closed
    webview.start()
