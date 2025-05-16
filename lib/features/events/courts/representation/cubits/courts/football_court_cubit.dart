import 'package:events_jo/config/algorithms/ratings_utils.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_states.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/shared/domain/repo/events_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballCourtsCubit extends Cubit<FootballCourtsStates> {
  final EventsRepo eventsRepo;

  FootballCourtsCubit({required this.eventsRepo})
      : super(FootballCourtsInitial());

  List<FootballCourt>? cachechCourts;

  Future<void> getAllCourts() async {
    emit(FootballCourtsLoading());
    try {
      final courts = await eventsRepo.getAllCourts();
      courts.sort(
        (a, b) {
          return calculateRatings(b.rates)['averageRate']
              .toDouble()
              .compareTo(calculateRatings(a.rates)['averageRate'].toDouble());
        },
      );
      cachechCourts = courts;
      emit(FootballCourtsLoaded(courts));
    } catch (e) {
      emit(FootballCourtsError(e.toString()));
    }
  }

  Future<FootballCourt?> getCourt(String courtId) async {
    final court = await eventsRepo.getCourt(courtId);
    if (court == null) {
      return null;
    }
    return court;
  }
}
