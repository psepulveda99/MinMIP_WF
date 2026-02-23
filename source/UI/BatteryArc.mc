using Toybox.Graphics;
using Palette;

module UI {
    class BatteryArc {

        static function draw(dc, cx, cy, r, battPct) {
            var startDeg = 210;
            var sweepDeg = 300;
            var endTrack = startDeg + sweepDeg;

            dc.setColor(Palette.BATT_TRACK, Graphics.COLOR_TRANSPARENT);
            thickArc(dc, cx, cy, r, startDeg, endTrack, 6);

            var fillEnd = startDeg + (sweepDeg * clampPct(battPct) / 100.0);
            dc.setColor(Palette.BATT_FILL, Graphics.COLOR_TRANSPARENT);
            thickArc(dc, cx, cy, r, startDeg, fillEnd, 6);
        }

        static function thickArc(dc, cx, cy, r, startDeg, endDeg, thickness) {
            for (var i = 0; i < thickness; i += 1) {
                dc.drawArc(cx, cy, r - i, startDeg, endDeg);
            }
        }

        static function clampPct(p) {
            if (p < 0) { return 0; }
            if (p > 100) { return 100; }
            return p;
        }

        static function altLabel(battPct, isCharging) {
            var bars = ["▁","▂","▃","▄","▅","▆","▇","█"];
            var idx = (clampPct(battPct) * (bars.size()-1) / 100.0).toNumber();
            if (isCharging) { return "⚡ " + bars[idx]; }
            return bars[idx];
        }
    }
}