import 'package:events_jo/features/chat/domain/models/chat.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/support/domain/models/problem_report.dart';

//class to display empty objects when loading
class Dummy {
  static WeddingVenue venue = WeddingVenue(
    id: '123456789',
    name: 'Loading',
    stripeAccountId: '123456789',
    latitude: 0,
    longitude: 0,
    rates: [],
    isOpen: true,
    isApproved: true,
    isBeingApproved: false,
    pics: [
      "https://i.ibb.co/hh5xKbD/plain-white-background-or-wallpaper-abstract-image-2-E064-N7.jpg"
    ],
    ownerId: '123',
    ownerName: 'Owner 123',
    startDate: [DateTime.now().year, DateTime.now().month, DateTime.now().day],
    endDate: [
      DateTime.now().add(const Duration(hours: 1)).year,
      DateTime.now().add(const Duration(hours: 1)).month,
      DateTime.now().add(const Duration(hours: 1)).day
    ],
    time: [1, 2],
    peopleMax: 10000000,
    peopleMin: 0,
    peoplePrice: 1,
    city: 'loading',
  );

  static FootballCourt court = FootballCourt(
    id: '123456789',
    name: 'Loading',
    latitude: 0,
    longitude: 0,
    rates: [],
    isApproved: true,
    isBeingApproved: false,
    stripeAccountId: '12345678900',
    pics: [
      "https://i.ibb.co/hh5xKbD/plain-white-background-or-wallpaper-abstract-image-2-E064-N7.jpg"
    ],
    ownerId: '123',
    ownerName: 'Owner 123',
    startDate: [DateTime.now().year, DateTime.now().month, DateTime.now().day],
    endDate: [
      DateTime.now().add(const Duration(hours: 1)).year,
      DateTime.now().add(const Duration(hours: 1)).month,
      DateTime.now().add(const Duration(hours: 1)).day
    ],
    time: [1, 2],
    city: 'loading',
    pricePerHour: 15,
  );

  static Chat chat = Chat(
    lastMessage: 'Hello World',
    lastUpdated: DateTime.now(),
    participants: ['123', '456'],
    participantsNames: ['Sender', 'Reciever'],
  );

  static ProblemReport problem = ProblemReport(
    id: '123',
    problem: 'Dummy Problem',
    userId: '456',
    userName: 'Dummy Name',
    isDone: false,
  );
}
