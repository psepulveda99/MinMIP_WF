using Toybox.Application;
using Toybox.WatchUi;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        // For watchfaces, return only the view to avoid delegate/runtime issues in simulator.
        return [ new Views.WatchFaceView() ];
    }
}