class Delay {
  static oneSecond() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  static twoSeconds() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  static threeSeconds() async {
    await Future.delayed(const Duration(seconds: 3));
  }
}
