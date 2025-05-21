import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/order/admin_order_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrderCubit extends Cubit<AdminOrderStates> {
  final AdminRepo adminRepo;

  AdminOrderCubit({required this.adminRepo}) : super(AdminOrderInit());

  void getOrdersStream() {
    emit(AdminOrderLoading());
    try {
      //listen to orders
      adminRepo.getOrdersStream().listen(
        (orders) {
          emit(AdminOrderLoaded(orders));
        },
      );
    } catch (e) {
      emit(AdminOrderError(e.toString()));
    }
  }

  Future<void> refund({
    required String? paymentIntentId,
    required String orderId,
    required String cancelledBy,
    required double amount,
  }) async {
    emit(AdminOrderActionLoading('Refunding in process'));
    try {
      if (paymentIntentId == null) {
        emit(AdminOrderError('No payment intent id found'));
        return;
      }
      await adminRepo.refund(
        paymentIntentId: paymentIntentId,
        orderId: orderId,
        cancelledBy: cancelledBy,
        amount: amount,
      );

      emit(AdminOrderActionLoading('Refunding done'));
      getOrdersStream();
    } catch (e) {
      emit(AdminOrderError(e.toString()));
    }
  }

  Future<void> transfer({
    required String? stripeAccountId,
    required String orderId,
    required double amount,
  }) async {
    emit(AdminOrderActionLoading('Transferring in process'));
    try {
      if (stripeAccountId == null) {
        emit(AdminOrderError('No stripe account id found'));
        return;
      }
      await adminRepo.transfer(
        stripeAccountId: stripeAccountId,
        orderId: orderId,
        amount: amount,
      );

      emit(AdminOrderActionLoading('Transferring done'));
    } catch (e) {
      emit(AdminOrderError(e.toString()));
    }
  }

  Future<void> getBalance() async {
    try {
      await adminRepo.getBalance();
    } catch (e) {
      emit(AdminOrderError(e.toString()));
    }
  }

  Future<void> getPayouts() async {
    try {
      await adminRepo.getPayouts();
    } catch (e) {
      emit(AdminOrderError(e.toString()));
    }
  }
}
