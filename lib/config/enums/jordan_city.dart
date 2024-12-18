enum JordanCity {
  amman,
  zarqa,
  irbid,
  aqaba,
  salt,
  karak,
  madaba,
  mafraq,
  jerash,
  ajloun,
  tafila,
  maAn,
}

extension JordanCityExtension on JordanCity {
  String get name {
    switch (this) {
      case JordanCity.amman:
        return "amman";
      case JordanCity.zarqa:
        return "zarqa";
      case JordanCity.irbid:
        return "irbid";
      case JordanCity.aqaba:
        return "aqaba";
      case JordanCity.salt:
        return "salt";
      case JordanCity.karak:
        return "karak";
      case JordanCity.madaba:
        return "madaba";
      case JordanCity.mafraq:
        return "mafraq";
      case JordanCity.jerash:
        return "jerash";
      case JordanCity.ajloun:
        return "ajloun";
      case JordanCity.tafila:
        return "tafila";
      case JordanCity.maAn:
        return "ma'an";
    }
  }
}
