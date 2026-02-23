using Toybox.WatchUi;
using Layout;

module Views {
    class InputDelegate extends WatchUi.BehaviorDelegate {

        var mView;

        function initialize(view) {
            BehaviorDelegate.initialize();
            mView = view;
        }

        function onTap(clickEvent) {
            var xy = clickEvent.getCoordinates();
            var x = xy[0];
            var y = xy[1];

            if (x >= Layout.BATT_HIT_X0 && x <= Layout.BATT_HIT_X1 &&
                y >= Layout.BATT_HIT_Y0 && y <= Layout.BATT_HIT_Y1) {

                mView.toggleBatteryMode();
                WatchUi.requestUpdate();
                return true;
            }

            return false;
        }
    }
}