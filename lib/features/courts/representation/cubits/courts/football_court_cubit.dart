import 'package:events_jo/features/courts/domain/repo/football_court_repo.dart';
import 'package:events_jo/features/courts/representation/cubits/courts/football_court_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FootballCourtsCubit extends Cubit<FootballCourtsStates> {
  final FootballCourtRepo footballCourtRepo;

  FootballCourtsCubit({required this.footballCourtRepo})
      : super(FootballCourtsInitial());

  Future<void> getAllCourts() async {
    emit(FootballCourtsLoading());
    try {
      final courts = await footballCourtRepo.getAllCourts();
      emit(FootballCourtsLoaded(courts));
    } catch (e) {
      emit(FootballCourtsError(e.toString()));
    }
  }
}
