from datetime import datetime
from pathlib import Path

from flask import Flask, abort, jsonify, redirect, render_template, request, send_file, url_for

import db
import models

ALLOWED_IMAGE_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".svg"}

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
        prep_min_bound=models.MIN_PREP_MINUTES,
        prep_max_bound=models.MAX_PREP_MINUTES,
        cool_min_bound=models.MIN_COOL_MINUTES,
        cool_max_bound=models.MAX_COOL_MINUTES,
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


@app.route("/bed/<int:bed_id>/photo")
def bed_photo(bed_id):
    bed = models.get_bed(bed_id)
    if bed is None or not bed["picture_path"]:
        abort(404)
    path = Path(bed["picture_path"])
    if path.suffix.lower() not in ALLOWED_IMAGE_EXTENSIONS or not path.is_file():
        abort(404)
    return send_file(path, conditional=True)


@app.route("/bed/<int:bed_id>/settings", methods=["POST"])
def update_bed_settings(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    models.update_bed_settings(
        bed_id,
        number=request.form.get("number", ""),
        model=request.form.get("model", ""),
        prep_min=request.form.get("prep_min", type=int, default=models.MIN_PREP_MINUTES),
        cool_min=request.form.get("cool_min", type=int, default=models.MIN_COOL_MINUTES),
        picture_path=request.form.get("picture_path", ""),
    )
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/studio")
def studio():
    return render_template(
        "studio.html",
        version=VERSION,
        nav_items=NAV_ITEMS,
        bottom_buttons=BOTTOM_BUTTONS,
        server_time=datetime.now().strftime("%H:%M:%S"),
        bed_count=models.get_bed_count(),
        bed_count_min=models.MIN_BEDS,
        bed_count_max=models.MAX_BEDS,
    )


@app.route("/studio/bed-count", methods=["POST"])
def studio_set_bed_count():
    current = models.get_bed_count()
    count = request.form.get("bed_count", type=int, default=current)
    models.set_bed_count(count)
    return redirect(url_for("studio"))


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
