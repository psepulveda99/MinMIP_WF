using Toybox.Weather;

module Services {
    class WeatherService {

        static function getSnapshot() {
            var cc = Weather.getCurrentConditions();
            if (cc == null) {
                return { :temp => null, :cond => null };
            }
            return { :temp => cc.temperature, :cond => cc.condition };
        }
    }
}