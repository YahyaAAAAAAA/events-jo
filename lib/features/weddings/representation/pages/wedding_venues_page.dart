import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading_indicator.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/my_search_bar.dart';
import 'package:events_jo/features/weddings/representation/components/wedding_venue_card.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenuesPage extends StatefulWidget {
  const WeddingVenuesPage({super.key});

  @override
  State<WeddingVenuesPage> createState() => _WeddingVenuesPageState();
}

class _WeddingVenuesPageState extends State<WeddingVenuesPage> {
  late List<WeddingVenue> weddingVenuList = [];
  late List<WeddingVenue> filterdWeddingVenuList = [];
  late final alphabetically cubit;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //get cubit
    cubit = context.read<alphabetically>();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        //get original list
        weddingVenuList = await cubit.getAllVenues();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wedding Venues in Jordan',
          style: TextStyle(
            color: GColors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              cubit.sortFromClosest(weddingVenuList);
              // cubit.sortAlpha(weddingVenueList);
            },
            child: Icon(
              Icons.sort_by_alpha_rounded,
              color: GColors.black,
            ),
          )
        ],
        //override back button
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: GColors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
      ),
      //states
      body: BlocConsumer<alphabetically, WeddingVenueStates>(
        builder: (context, state) {
          //loading...
          if (state is WeddingVenueLoading) {
            return const Center(
              child: LoadingIndicator(),
            );
          }

          //list ready
          if (state is WeddingVenueLoaded) {
            return Column(
              children: [
                //search bar
                MySearchBar(
                  controller: searchController,
                  onPressed: () => setState(() => searchController.clear()),
                  onChanged: (venue) => cubit.searchList(
                      weddingVenuList, filterdWeddingVenuList, venue),
                ),
                //venues list
                Expanded(
                  child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? weddingVenuList.length
                        : filterdWeddingVenuList.length,
                    itemBuilder: (context, index) {
                      return WeddingVenueCard(
                        weddingVenue: searchController.text.isEmpty
                            ? weddingVenuList[index]
                            : filterdWeddingVenuList[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          //error state
          else {
            return const Center(
              child: Text('Error getting venues list'),
            );
          }
        },
        listener: (context, state) {
          //listens for errors
          if (state is WeddingVenueError) {
            GSnackBar.show(context: context, text: state.message);
          }
        },
      ),
    );
  }
}
