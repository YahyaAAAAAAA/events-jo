import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_meals_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/meals/wedding_venue_meals_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenueMealsCubit extends Cubit<WeddingVenueMealsStates> {
  final WeddingVenueMealsRepo weddingVenueMealsRepo;

  WeddingVenueMealsCubit({required this.weddingVenueMealsRepo})
      : super(WeddingVenueMealsInit());

  //get all venue meals from database
  Future<List<WeddingVenueMeal>> getAllMeals(String id) async {
    emit(WeddingVenueMealsLoading());

    final weddingVenueMealsList = await weddingVenueMealsRepo.getAllMeals(id);

    emit(WeddingVenueMealsLoaded());

    return weddingVenueMealsList;
  }
}
