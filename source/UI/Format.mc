module UI {
    class Format {
        static function two(n) {
            if (n < 10) { return "0" + n.format("%d"); }
            return n.format("%d");
        }

        static function cardinalFromDeg(deg) {
            if (deg == null) { return "--"; }
            var dirs = ["N","NE","E","SE","S","SW","W","NW"];
            var idx = ((deg + 22.5) / 45.0).toNumber() % 8;
            return dirs[idx];
        }
    }
}