using Toybox.Graphics;
using Toybox.Math;
using Palette;

module UI {
    // Shape controls for smile gauge.
    const RADIUS = 118;
    const THICKNESS = 10;
    const START_DEG = 200;
    const SWEEP_DEG = 140;
    const DIRECTION = Graphics.ARC_CLOCKWISE;

    // Optional calibration overlay.
    const CALIBRATION_MODE = false;

    class BatteryArc {

        static function draw(dc, cx, cy, battPct) {
            var pct = clampPct(battPct);
            var endDeg = START_DEG + SWEEP_DEG;

            dc.setColor(Palette.BATT_TRACK, Graphics.COLOR_TRANSPARENT);
            thickArc(dc, cx, cy, RADIUS, START_DEG, endDeg, THICKNESS);

            if (pct > 0) {
                var fillEnd = START_DEG + (SWEEP_DEG * pct / 100.0);
                dc.setColor(Palette.BATT_FILL, Graphics.COLOR_TRANSPARENT);
                thickArc(dc, cx, cy, RADIUS, START_DEG, fillEnd, THICKNESS);
            }

            if (CALIBRATION_MODE) {
                drawCalibration(dc, cx, cy);
            }
        }

        static function thickArc(dc, cx, cy, r, startDeg, endDeg, thickness) {
            for (var i = 0; i < thickness; i += 1) {
                dc.drawArc(cx, cy, r - i, DIRECTION, startDeg, endDeg);
            }
        }

        static function drawCalibration(dc, cx, cy) {
            dc.setColor(Palette.TXT_SECOND, Graphics.COLOR_TRANSPARENT);
            drawAngleMark(dc, cx, cy, RADIUS + 10, 0, "0");
            drawAngleMark(dc, cx, cy, RADIUS + 10, 90, "90");
            drawAngleMark(dc, cx, cy, RADIUS + 10, 180, "180");
            drawAngleMark(dc, cx, cy, RADIUS + 10, 270, "270");
        }

        static function drawAngleMark(dc, cx, cy, r, deg, label) {
            var rad = deg * Math.PI / 180.0;
            var x = (cx + r * Math.cos(rad)).toNumber();
            var y = (cy - r * Math.sin(rad)).toNumber();
            dc.drawText(x, y, Graphics.FONT_XTINY, label, Graphics.TEXT_JUSTIFY_CENTER);
        }

        static function clampPct(p) {
            if (p == null) { return 0; }
            if (p < 0) { return 0; }
            if (p > 100) { return 100; }
            return p;
        }

        static function altLabel(battPct, isCharging) {
            var levels = [".", "|", "||", "|||", "||||", "|||||", "||||||", "|||||||", "||||||||"];
            var pct = clampPct(battPct);
            var idx = (pct * (levels.size() - 1) / 100.0).toNumber();
            var txt = levels[idx];
            if (isCharging) { return "+" + txt; }
            return txt;
        }
    }
}
