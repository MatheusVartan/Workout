class KeypointerUtils{
  static bool isMatch(
      double actualX, double actualY, double expectedX, double expectedY) {
    return _isFlooredOrCeiling(actualX, expectedX) &&
        _isFlooredOrCeiling(actualY, expectedY);
  }

  static bool _isFlooredOrCeiling(double actual, double expected) {
    return actual >= expected - 0.06 && actual <= expected + 0.06;
  }
}