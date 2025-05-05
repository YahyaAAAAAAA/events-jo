import 'dart:async';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/stripe_connect/stripe_connect_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StripeConnectCubit extends Cubit<StripeConnectStates> {
  final OwnerRepo ownerRepo;
  StreamSubscription<String?>? onboardingStatusSubscription;

  StripeConnectCubit({required this.ownerRepo}) : super(StripeConnectInit());

  Future<String> startOnboarding(String userId) async {
    try {
      final result = await ownerRepo.startOnboarding(userId);

      return result.onboardingUrl;
    } catch (e) {
      emit(StripeConnectError(e.toString()));

      throw e;
    }
  }

  StreamSubscription<String?> listenToOnboardingStatus(String ownerId) {
    onboardingStatusSubscription =
        ownerRepo.listenToOnboardingStatus(ownerId).listen(
      (status) {
        if (status == null) {
          emit(StripeNotConnected());
          return;
        }

        if (status == 'incomplete') {
          emit(StripeNotCompleted());
          return;
        }

        if (status == 'complete') {
          emit(StripeConnected(status));
          return;
        }
      },
    );
    return onboardingStatusSubscription!;
  }

  @override
  Future<void> close() {
    onboardingStatusSubscription?.cancel();
    return super.close();
  }
}
