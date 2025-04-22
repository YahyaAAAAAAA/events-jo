import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_states.dart';
import 'package:events_jo/features/events/shared/domain/repo/events_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballCourtsCubit extends Cubit<FootballCourtsStates> {
  final EventsRepo eventsRepo;

  FootballCourtsCubit({required this.eventsRepo})
      : super(FootballCourtsInitial());

  Future<void> getAllCourts() async {
    emit(FootballCourtsLoading());
    try {
      final courts = await eventsRepo.getAllCourts();
      emit(FootballCourtsLoaded(courts));
    } catch (e) {
      emit(FootballCourtsError(e.toString()));
    }
  }
}
