import 'package:events_jo/config/extensions/string_extensions.dart';

Map<String, dynamic> calculateRatings(List<String> rates) {
  List<int> rateDistribution = [0, 0, 0, 0, 0];
  double averageRate = 0;
  double sumRate = 0;
  double factorRate = 0;

  for (int i = 0; i < rates.length; i++) {
    final rate = rates[i].parseRateString()[0];
    if (int.parse(rate) != 0) {
      factorRate++;
      sumRate += double.parse(rate);
    }
    switch (rate) {
      case '1':
        rateDistribution[4] += 1;
        break;
      case '2':
        rateDistribution[3] += 1;
        break;
      case '3':
        rateDistribution[2] += 1;
        break;
      case '4':
        rateDistribution[1] += 1;
        break;
      case '5':
        rateDistribution[0] += 1;
        break;
    }
  }
  averageRate = sumRate == 0 ? 0 : sumRate / factorRate;

  return {
    'rateDistribution': rateDistribution,
    'averageRate': averageRate,
  };
}
