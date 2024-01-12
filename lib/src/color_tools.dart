part of mapbox_gl_flutterflow;

extension MapBoxColorConversion on Color {
  String toHexStringRGB() {
    final r = red.toRadixString(16).padLeft(2, '0');
    final g = green.toRadixString(16).padLeft(2, '0');
    final b = blue.toRadixString(16).padLeft(2, '0');
    return '#$r$g$b';
  }
}
