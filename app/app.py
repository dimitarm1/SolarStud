import os
from datetime import datetime
from pathlib import Path

from flask import Flask, abort, jsonify, redirect, render_template, request, send_file, url_for

import controller_link
import db
import models

ALLOWED_IMAGE_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp", ".svg"}
DEBUG = True

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
        controller_address_min=models.MIN_CONTROLLER_ADDRESS,
        controller_address_max=models.MAX_REAL_CONTROLLER_ADDRESS,
        demo_address_min=models.MIN_DEMO_CONTROLLER_ADDRESS,
        demo_address_max=models.MAX_CONTROLLER_ADDRESS,
        hw_error=request.args.get("hw_error"),
    )


@app.route("/bed/<int:bed_id>/start", methods=["POST"])
def start_bed(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    total_min = request.form.get("total_min", type=int, default=models.DEFAULT_SESSION_MINUTES)
    try:
        models.start_session(bed_id, total_min=total_min)
    except controller_link.ControllerLinkError as exc:
        return redirect(url_for("bed_detail", bed_id=bed_id, hw_error=str(exc)))
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/bed/<int:bed_id>/stop", methods=["POST"])
def stop_bed(bed_id):
    if models.get_bed(bed_id) is None:
        abort(404)
    try:
        models.stop_session(bed_id)
    except controller_link.ControllerLinkError as exc:
        return redirect(url_for("bed_detail", bed_id=bed_id, hw_error=str(exc)))
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
        controller_address=request.form.get("controller_address", ""),
    )
    return redirect(url_for("bed_detail", bed_id=bed_id))


@app.route("/api/controllers/scan")
def scan_controllers():
    exclude_bed_id = request.args.get("bed_id", type=int)
    port = models.get_serial_port()
    if not port:
        return jsonify({"error": "No serial port configured. Set one on the Studio page."}), 400
    try:
        found = controller_link.scan(port)
    except controller_link.ControllerLinkError as exc:
        return jsonify({"error": str(exc)}), 503

    in_use = models.list_controller_addresses_in_use(exclude_bed_id=exclude_bed_id)
    for entry in found:
        entry["in_use_by_bed_id"] = in_use.get(entry["address"])
    return jsonify({"port": port, "controllers": found})


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
        serial_port=models.get_serial_port(),
    )


@app.route("/studio/bed-count", methods=["POST"])
def studio_set_bed_count():
    current = models.get_bed_count()
    count = request.form.get("bed_count", type=int, default=current)
    models.set_bed_count(count)
    return redirect(url_for("studio"))


@app.route("/studio/serial-port", methods=["POST"])
def studio_set_serial_port():
    models.set_serial_port(request.form.get("serial_port", ""))
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
    # Under the debug reloader there are two processes: a parent monitor
    # (WERKZEUG_RUN_MAIN unset) and the child that actually serves requests
    # (WERKZEUG_RUN_MAIN="true"). Only start the scheduler in the process
    # that will actually stick around, so it doesn't run twice.
    if not DEBUG or os.environ.get("WERKZEUG_RUN_MAIN") == "true":
        db.start_backup_scheduler()
    app.run(debug=DEBUG, host="0.0.0.0", port=5000)
