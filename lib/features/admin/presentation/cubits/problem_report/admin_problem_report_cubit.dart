import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/problem_report/admin_problem_report_states.dart';
import 'package:events_jo/features/support/domain/models/problem_report.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminProblemReportCubit extends Cubit<AdminProblemReportStates> {
  final AdminRepo adminRepo;

  AdminProblemReportCubit({required this.adminRepo})
      : super(AdminProblemReportInitial());

  //change user's email
  Future<void> getProblems() async {
    //loading...
    emit(AdminProblemReportLoading());

    try {
      final problems = await adminRepo.getProblems();

      //done
      emit(AdminProblemReportLoaded(problems));
    } catch (e) {
      //error
      emit(AdminProblemReportError(e.toString()));
    }
  }

  Future<void> checkProblem(ProblemReport problem) async {
    try {
      await adminRepo.checkProblem(problem);
      getProblems();
    } catch (e) {
      //error
      emit(AdminProblemReportError(e.toString()));
    }
  }
}
