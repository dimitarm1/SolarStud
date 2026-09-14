from datetime import datetime

from flask import Flask, abort, jsonify, redirect, render_template, request, url_for

import db
import models

app = Flask(__name__)
db.init_db()

VERSION = "V1.2"

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
        beds=models.list_beds(),
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
    )


@app.route("/bed/<int:bed_id>")
def bed_detail(bed_id):
    bed = models.get_bed(bed_id)
    if bed is None:
        abort(404)
    return render_template(
        "bed_detail.html",
        version=VERSION,
        bed=bed,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        session_min=models.MIN_SESSION_MINUTES,
        session_max=models.MAX_SESSION_MINUTES,
        session_default=models.DEFAULT_SESSION_MINUTES,
    )


@app.route("/bed/<int:bed_id>/start", methods=["POST"])
def start_bed(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    total_min = request.form.get("total_min", type=int, default=models.DEFAULT_SESSION_MINUTES)
    models.start_session(bed_id, total_min=total_min)
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/bed/<int:bed_id>/stop", methods=["POST"])
def stop_bed(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    models.stop_session(bed_id)
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/api/status")
def status():
    return jsonify(
        {
            "time": datetime.now().strftime("%H:%M:%S"),
            "beds": models.list_beds(),
        }
    )


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
