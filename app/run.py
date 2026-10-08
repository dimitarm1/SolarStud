"""Double-click launcher: starts the server without debug mode or the
auto-reloader, and opens the default browser once it answers. Use
`python app.py` instead for development, which keeps Flask's debug mode
and auto-reload."""

import app

if __name__ == "__main__":
    app.run_server(debug=False, open_browser=True)
