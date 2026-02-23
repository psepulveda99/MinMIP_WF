using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.ActivityMonitor;

using Palette;
using Layout;

using UI.BatteryArc;
using UI.Format;

module Views {

    class WatchFaceView extends WatchUi.WatchFace {

        // Bottom battery gauge anchor.
        const BATT_ARC_CX = 130;
        const BATT_ARC_CY = 130;
        const BATT_LABEL_Y = 206;

        var mBatteryShowPercent = true;
        var mIsCharging = false;

        var mLastMinute = -1;

        var mTemp = null;
        var mCond = null;

        var mAltM = null;
        var mHeadingDeg = null;

        var mSteps = 0;
        var mHr = null;

        var mBattPct = 0;

        function initialize() {
            WatchFace.initialize();
        }

        function onShow() {
        }

        function onHide() {
        }

        function toggleBatteryMode() {
            mBatteryShowPercent = !mBatteryShowPercent;
        }

        function onUpdate(dc) {
            var clock = System.getClockTime();

            if (clock.min != mLastMinute) {
                mLastMinute = clock.min;
                refreshSystemData();
                refreshActivityData();
            }

            drawBackground(dc);
            drawTop(dc);
            drawMiddleTime(dc, clock);
            drawBottom(dc);
        }

        function refreshSystemData() {
            try {
                var stats = System.getSystemStats();
                if (stats != null && stats has :battery && stats.battery != null) {
                    mBattPct = UI.BatteryArc.clampPct(stats.battery);
                }
            } catch (e) { }
        }

        function refreshActivityData() {
            try {
                var info = ActivityMonitor.getInfo();
                if (info != null) {
                    if (info has :steps && info.steps != null) {
                        mSteps = info.steps;
                    }
                    if (info has :currentHeartRate && info.currentHeartRate != null) {
                        mHr = info.currentHeartRate;
                    }
                }
            } catch (e) { }
        }

        function drawBackground(dc) {
            dc.setColor(Palette.TOP_BG, Palette.TOP_BG);
            dc.clear();

            dc.setColor(Palette.TOP_BG, Palette.TOP_BG);
            dc.fillRectangle(0, 0, Layout.W, Layout.MID_Y0);

            dc.setColor(Palette.MID_BG, Palette.MID_BG);
            dc.fillRectangle(0, Layout.MID_Y0, Layout.W, Layout.MID_H);

            dc.setColor(Palette.BOT_BG, Palette.BOT_BG);
            dc.fillRectangle(0, Layout.MID_Y1, Layout.W, Layout.H - Layout.MID_Y1);

            dc.setColor(Palette.ACCENT, Palette.ACCENT);
            dc.fillRectangle(0, Layout.MID_Y0 - Layout.SEP_THICK, Layout.W, Layout.SEP_THICK);
            dc.fillRectangle(0, Layout.MID_Y1, Layout.W, Layout.SEP_THICK);
        }

        function drawTop(dc) {
            dc.setColor(Palette.TXT_SECOND, Graphics.COLOR_TRANSPARENT);

            var tempStr = (mTemp == null) ? "--" : (mTemp.format("%d") + " deg");
            var altStr = (mAltM == null) ? "-- m" : (mAltM.format("%d") + " m");

            var hdgCar = UI.Format.cardinalFromDeg(mHeadingDeg);
            var hdgDeg = (mHeadingDeg == null) ? "--" : (mHeadingDeg.format("%d") + " deg");

            dc.drawText(18, 18, Graphics.FONT_SMALL, tempStr, Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(18, 44, Graphics.FONT_XTINY, altStr, Graphics.TEXT_JUSTIFY_LEFT);
            dc.drawText(170, 44, Graphics.FONT_XTINY, (hdgCar + " " + hdgDeg), Graphics.TEXT_JUSTIFY_LEFT);

            dc.setColor(Palette.ICON, Graphics.COLOR_TRANSPARENT);
            dc.drawText(210, 18, Graphics.FONT_XTINY, "WX", Graphics.TEXT_JUSTIFY_CENTER);
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

            dc.drawText(18, 172, Graphics.FONT_XTINY,
                        ("Steps " + mSteps.format("%d")), Graphics.TEXT_JUSTIFY_LEFT);

            var hrStr = (mHr == null) ? "--" : mHr.format("%d");
            dc.drawText(18, 190, Graphics.FONT_XTINY,
                        ("HR " + hrStr + " bpm"), Graphics.TEXT_JUSTIFY_LEFT);

            UI.BatteryArc.draw(dc, BATT_ARC_CX, BATT_ARC_CY, mBattPct);

            dc.setColor(Palette.TXT_PRIMARY, Graphics.COLOR_TRANSPARENT);
            var battText = mBatteryShowPercent
                ? (mBattPct.format("%d") + "%")
                : UI.BatteryArc.altLabel(mBattPct, mIsCharging);

            dc.drawText(Layout.CX, BATT_LABEL_Y, Graphics.FONT_SMALL,
                        battText, Graphics.TEXT_JUSTIFY_CENTER);
        }
    }
}
