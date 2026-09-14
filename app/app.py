from datetime import datetime

from flask import Flask, jsonify, render_template

app = Flask(__name__)

VERSION = "V1.2"

BEDS = [
    {
        "id": 1,
        "number": "No 1",
        "model": "Esprit 770",
        "kind": "lie",
        "status": "running",
        "remaining_min": 3,
        "total_min": 12,
    },
    {
        "id": 2,
        "number": "No 2",
        "model": "Megasun T230",
        "kind": "lie",
        "status": "idle",
    },
    {
        "id": 3,
        "number": "No 3",
        "model": "Megasun P9S",
        "kind": "lie",
        "status": "idle",
    },
    {
        "id": 4,
        "number": "No 4",
        "model": "MS Pure 5",
        "kind": "stand",
        "status": "idle",
    },
]

NAV_ITEMS = [
    {"id": "tanning", "label": "Tanning", "icon": "sun"},
    {"id": "cosmetics", "label": "Cosmetics", "icon": "leaf"},
    {"id": "cards", "label": "Cards", "icon": "card"},
    {"id": "studio", "label": "Studio", "icon": "home"},
]

BOTTOM_BUTTONS = [
    {"id": "protocol", "label": "Протокол", "icon": "protocol"},
    {"id": "cosmetics", "label": "Козметика", "icon": "leaf"},
    {"id": "cards", "label": "Карти", "icon": "card"},
    {"id": "studio", "label": "Студио", "icon": "home"},
]


@app.route("/")
def index():
    return render_template(
        "index.html",
        version=VERSION,
        beds=BEDS,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
    )


@app.route("/api/status")
def status():
    return jsonify(
        {
            "time": datetime.now().strftime("%H:%M:%S"),
            "beds": BEDS,
        }
    )


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
