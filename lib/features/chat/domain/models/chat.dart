import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String lastMessage;
  final DateTime lastUpdated;
  final List<dynamic> participants;
  final List<dynamic> participantsNames;

  Chat({
    required this.lastMessage,
    required this.lastUpdated,
    required this.participants,
    required this.participantsNames,
  });

  factory Chat.fromJson(Map<String, dynamic> map) {
    return Chat(
      lastMessage: map['lastMessage'] ?? '',
      lastUpdated: (map['lastUpdated'] as Timestamp).toDate(),
      participants: map['participants'],
      participantsNames: map['participantsNames'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastMessage': lastMessage,
      'lastUpdated': lastUpdated,
      'participants': participants,
      'participantsNames': participantsNames,
    };
  }
}
