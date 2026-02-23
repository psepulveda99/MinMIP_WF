using Toybox.Application;
using Toybox.WatchUi;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        var view = new Views.WatchFaceView();
        var delegate = new Views.InputDelegate(view);
        return [ view, delegate ];
    }
}