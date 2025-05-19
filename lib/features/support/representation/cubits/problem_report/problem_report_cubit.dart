import 'package:events_jo/features/support/domain/models/problem_report.dart';
import 'package:events_jo/features/support/domain/repos/problem_report_repo.dart';
import 'package:events_jo/features/support/representation/cubits/problem_report/problem_report_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProblemReportCubit extends Cubit<ProblemReportStates> {
  final ProblemReportRepo problemReportRepo;

  ProblemReportCubit({required this.problemReportRepo})
      : super(ProblemReportInitial());

  //change user's email
  Future<void> addProblem(ProblemReport problem) async {
    //loading...
    emit(ProblemReportLoading());

    try {
      await problemReportRepo.addProblem(problem);

      //done
      emit(ProblemReportLoaded());
    } catch (e) {
      //error
      emit(ProblemReportError(e.toString()));
    }
  }
}
