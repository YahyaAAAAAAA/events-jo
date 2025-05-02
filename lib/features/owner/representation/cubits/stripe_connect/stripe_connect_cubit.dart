import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/stripe_connect/stripe_connect_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StripeConnectCubit extends Cubit<StripeConnectStates> {
  final OwnerRepo ownerRepo;

  StripeConnectCubit({required this.ownerRepo}) : super(StripeConnectInit());

  Future<void> start(String userId) async {
    emit(StripeConnectLoading());
    try {
      final result = await ownerRepo.startOnboarding(userId);

      emit(StripeConnected(result));
    } catch (e) {
      emit(StripeConnectError(e.toString()));
    }
  }
}
