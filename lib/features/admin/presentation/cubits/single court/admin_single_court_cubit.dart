import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20court/admin_single_court_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSingleCourtCubit extends Cubit<AdminSingleCourtStates> {
  final AdminRepo adminRepo;
  bool isDenying = false;

  AdminSingleCourtCubit({required this.adminRepo})
      : super(AdminSingleCourtInit());

  void getCourtStream(String id) {
    emit(AdminSingleCourtLoading());

    final venueStream = adminRepo.getCourtStream(id);

    //combine 3 streams in one stream
    venueStream.listen(
      (data) async {
        //data in stream got deleted (deny action)
        if (data == null) {
          return;
        }
        emit(AdminSingleCourtLoaded(data));
      },
      onError: (error) {
        emit(AdminSingleCourtError(error.toString()));
      },
    );
  }
}
