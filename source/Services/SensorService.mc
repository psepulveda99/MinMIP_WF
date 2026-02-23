using Toybox.Sensor;
using Toybox.Math;

module Services {
    class SensorDataListener {
        function onSensorData(data) {
            // Handle sensor data
        }
    }

    class SensorService {
        static var mListener = null;

        static function enableMagnetometerLowRate() {
            var options = {
                :period => 1,
                :magnetometer => { :enabled => true, :sampleRate => 1 }
            };

            try {
                if (mListener == null) {
                    mListener = new SensorDataListener();
                }
                Sensor.registerSensorDataListener(mListener.method(:onSensorData), options);
            } catch (e) { }
        }

        static function disableSensors() {
            try { Sensor.unregisterSensorDataListener(); } catch (e) { }
        }

        static function noop(data) { }

        static function headingDegFromInfo(info) {
            if (info == null || info.heading == null) { return null; }
            var deg = info.heading * 180.0 / Math.PI;
            if (deg < 0) { deg += 360.0; }
            return deg.toNumber();
        }
    }
}