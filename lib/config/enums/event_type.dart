enum EventType {
  venue,
  farm,
  court,
}

extension EventTypeExtentions on EventType {
  static EventType fromString(String type) {
    switch (type) {
      case 'venue':
        return EventType.venue;
      case 'court':
        return EventType.court;
      default:
        return EventType.farm;
    }
  }
}
