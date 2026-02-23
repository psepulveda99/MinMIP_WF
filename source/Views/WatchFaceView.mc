using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.ActivityMonitor;
using Toybox.Sensor;

using Palette;
using Layout;

using UI.BatteryArc;
using UI.Format;

using Services.WeatherService;
using Services.SensorService;

module Views {

    class WatchFaceView extends WatchUi.WatchFace {

        // Toggle batería
        var mBatteryShowPercent = true;

        // caches (performance MIP)
        var mLastMinute = -1;
        var mLastWeatherEpoch = 0;

        // Weather
        var mTemp = null;
        var mCond = null;

        // Outdoor (Sensor.Info)
        var mAltM = null;
        var mHeadingDeg = null;

        // Health
        var mSteps = 0;
        var mHr = null;

        // System
        var mBattPct = 0;
        var mIsCharging = false; // stub (lo conectamos cuando confirmemos API)

        function initialize() {
            WatchFace.initialize();
        }

        function onShow() {
            // Temporalmente desactivado: en simulador produce "Symbol Not Found" al iniciar.
            // SensorService.enableMagnetometerLowRate();
        }

        function onHide() {
            SensorService.disableSensors();
        }

        function toggleBatteryMode() {
            mBatteryShowPercent = !mBatteryShowPercent;
        }

        function onUpdate(dc) {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
            dc.clear();
            
            var clock = System.getClockTime();
            var timeStr = (clock.hour < 10 ? "0" : "") + clock.hour.toString() + ":" + 
                         (clock.min < 10 ? "0" : "") + clock.min.toString();
            
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_LARGE, 
                       timeStr, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function drawBackground(dc) {
            dc.setColor(Palette.TOP_BG, Palette.TOP_BG);
            dc.clear();

            // Top
            dc.setColor(Palette.TOP_BG, Palette.TOP_BG);
            dc.fillRectangle(0, 0, Layout.W, Layout.MID_Y0);

            // Mid band
            dc.setColor(Palette.MID_BG, Palette.MID_BG);
            dc.fillRectangle(0, Layout.MID_Y0, Layout.W, Layout.MID_H);

            // Bottom
            dc.setColor(Palette.BOT_BG, Palette.BOT_BG);
            dc.fillRectangle(0, Layout.MID_Y1, Layout.W, Layout.H - Layout.MID_Y1);

            // Accent lines
            dc.setColor(Palette.ACCENT, Palette.ACCENT);
            dc.fillRectangle(0, Layout.MID_Y0 - Layout.SEP_THICK, Layout.W, Layout.SEP_THICK);
            dc.fillRectangle(0, Layout.MID_Y1, Layout.W, Layout.SEP_THICK);
        }

        function drawTop(dc) {
            dc.setColor(Palette.TXT_SECOND, Graphics.COLOR_TRANSPARENT);

            var tempStr = (mTemp == null) ? "--°" : (mTemp.format("%d") + "°");
            var altStr  = (mAltM == null) ? "-- m" : (mAltM.format("%d") + " m");

            var hdgCar = UI.Format.cardinalFromDeg(mHeadingDeg);
            var hdgDeg = (mHeadingDeg == null) ? "--°" : (mHeadingDeg.format("%d") + "°");

            // Layout simple (ajustamos después a tu prototipo exacto)
            dc.drawText(18, 18, Graphics.FONT_SMALL, tempStr, Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(18, 44, Graphics.FONT_XTINY, altStr, Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(170, 44, Graphics.FONT_XTINY, (hdgCar + " " + hdgDeg), Graphics.TEXT_JUSTIFY_LEFT);

            // Icono clima: placeholder
            dc.setColor(Palette.ICON, Graphics.COLOR_TRANSPARENT);
            dc.drawText(210, 18, Graphics.FONT_XTINY, "☁", Graphics.TEXT_JUSTIFY_CENTER);
        }

        function drawMiddleTime(dc, clock) {
            dc.setColor(Palette.TXT_PRIMARY, Graphics.COLOR_TRANSPARENT);

            var timeStr = UI.Format.two(clock.hour) + ":" + UI.Format.two(clock.min);

            dc.drawText(Layout.CX, Layout.MID_Y0 + 8,
                        Graphics.FONT_LARGE,
                        timeStr, Graphics.TEXT_JUSTIFY_CENTER);
        }

        function drawBottom(dc) {
            dc.setColor(Palette.TXT_SECOND, Graphics.COLOR_TRANSPARENT);

            dc.drawText(18, 175, Graphics.FONT_XTINY,
                        ("Steps " + mSteps.format("%d")), Graphics.TEXT_JUSTIFY_LEFT);

            var hrStr = (mHr == null) ? "--" : mHr.format("%d");
            dc.drawText(18, 195, Graphics.FONT_XTINY,
                        ("HR " + hrStr + " bpm"), Graphics.TEXT_JUSTIFY_LEFT);

            // Battery arc
            UI.BatteryArc.draw(dc, Layout.CX, Layout.CY, 118, mBattPct);

            // Toggle label
            dc.setColor(Palette.TXT_PRIMARY, Graphics.COLOR_TRANSPARENT);
            var battText = mBatteryShowPercent
                ? (mBattPct.format("%d") + "%")
                : UI.BatteryArc.altLabel(mBattPct, mIsCharging);

            dc.drawText(Layout.CX, 225, Graphics.FONT_SMALL,
                        battText, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }
}