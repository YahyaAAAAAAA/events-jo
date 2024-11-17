import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/repo/weddin_venue_drinks_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/drinks/wedding_venue_meals_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenueDrinksCubit extends Cubit<WeddingVenueDrinksStates> {
  final WeddingVenueDrinksRepo weddingVenueDrinksRepo;

  WeddingVenueDrinksCubit({required this.weddingVenueDrinksRepo})
      : super(WeddingVenueDrinksInit());

  //get all venue drinks from database
  Future<List<WeddingVenueDrink>> getAllDrinks(String id) async {
    emit(WeddingVenueDrinksLoading());

    final weddingVenueDrinksList =
        await weddingVenueDrinksRepo.getAllDrinks(id);

    emit(WeddingVenueDrinksLoaded());

    return weddingVenueDrinksList;
  }
}
