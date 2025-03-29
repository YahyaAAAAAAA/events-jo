import 'package:flutter/material.dart';

extension DateTimeRangeExtensions on DateTimeRange {
  bool conflictsWith(DateTimeRange other) {
    return start.isBefore(other.end) && end.isAfter(other.start);
  }
}
