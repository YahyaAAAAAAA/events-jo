import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/config/utils/loading_indicator.dart';
import 'package:events_jo/features/admin/presentation/components/admin_card.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin_cubit.dart';
import 'package:events_jo/features/admin/presentation/cubits/admin_states.dart';
import 'package:events_jo/features/admin/presentation/pages/venues/unapproved/admin_unapproved_venue_details.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late final AdminCubit adminCubit;

  @override
  void initState() {
    super.initState();

    //get cubit
    adminCubit = context.read<AdminCubit>();

    adminCubit.getWeddingVenuesStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          onPressed: () => context.read<AuthCubit>().logout(),
          icon: Icons.person,
          size: 25,
        ),
        actions: [
          AppBarButton(
            onPressed: () {},
            icon: CustomIcons.menu,
            size: 20,
          ),
        ],
        leadingWidth: 90,
        toolbarHeight: 70,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO move this to admin unpp vens
          //make 3 cards for (wed,far,fot)
          //make 2 card for (app,unapp)
          BlocConsumer<AdminCubit, AdminStates>(
            builder: (context, state) {
              //done
              if (state is AdminLoaded) {
                final venues = state.venues;
                final names = state.ownersNames;

                if (venues.isEmpty) {
                  return const Center(
                      child: Text('No Requests for Wedding Venues'));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: venues.length,
                    itemBuilder: (context, index) {
                      return AdminCard(
                        name: venues[index].name,
                        owner: names[index],
                        index: index,
                        isApproved: venues[index].isApproved,
                        //navigate to venue details
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AdminUnapprovedVenueDetails(
                              adminCubit: adminCubit,
                              weddingVenue: venues[index],
                              ownerName: names[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              //error
              if (state is AdminError) {
                return Text(state.message);
              }
              //loading...
              else {
                return const LoadingIndicator();
              }
            },
            listener: (context, state) {
              //error
              if (state is AdminError) {
                GSnackBar.show(context: context, text: state.message);
              }
            },
          ),
        ],
      ),
    );
  }
}
