//extend on native string class
extension StringExtensions on String {
  //capitalize first letter, lower case the rest
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  //capitalize the beginning of every word
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');

  //converts time from 24hr system to 12hr system (without minutes)
  String get toTime {
    if (int.parse(this) > 12) {
      return '${int.parse(this) - 12} PM';
    }

    if (int.parse(this) == 12) {
      return '12 PM';
    }

    if (int.parse(this) == 0) {
      return '12 AM';
    }
    return '$this AM';
  }

  //converts time from 24hr system to 12hr system (with minutes)
  String toTimeWithMinutes(String minutes) {
    if (int.parse(minutes) == 0) {
      minutes = '00';
    }

    if (int.parse(this) > 12) {
      return '${int.parse(this) - 12}:$minutes PM';
    }

    if (int.parse(this) == 12) {
      return '12:$minutes PM';
    }

    if (int.parse(this) == 0) {
      return '12:$minutes AM';
    }
    return '$this:$minutes AM';
  }
}
