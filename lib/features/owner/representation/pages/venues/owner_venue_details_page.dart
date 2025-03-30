import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/owner/representation/cubits/creation/owner_cubit.dart';
import 'package:events_jo/features/owner/representation/cubits/creation/owner_states.dart';

class OwnerApprovedVenueDetailsPage extends StatefulWidget {
  final WeddingVenue weddingVenue;

  const OwnerApprovedVenueDetailsPage({
    super.key,
    required this.weddingVenue,
  });

  @override
  State<OwnerApprovedVenueDetailsPage> createState() =>
      _OwnerApprovedVenueDetailsPageState();
}

class _OwnerApprovedVenueDetailsPageState
    extends State<OwnerApprovedVenueDetailsPage> {
  late final WeddingVenue weddingVenue;
  late final OwnerCubit ownerCubit;

  @override
  void initState() {
    super.initState();

    weddingVenue = widget.weddingVenue;
    ownerCubit = context.read<OwnerCubit>();
  }

  void _navigateToUpdatePage(String detail) {
    // Navigate to the respective update page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UpdateDetailPage(detail: detail, weddingVenue: weddingVenue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venue Details'),
      ),
      body: BlocConsumer<OwnerCubit, OwnerStates>(
        listener: (context, state) {
          if (state is OwnerLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Venue updated successfully')),
            );
          } else if (state is OwnerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error updating venue: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is OwnerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Type'),
                  subtitle: const Text('weddingVenue.type'),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Type'),
                ),
                ListTile(
                  title: const Text('Name'),
                  subtitle: Text(weddingVenue.name),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Name'),
                ),
                ListTile(
                  title: const Text('Images'),
                  subtitle: const Text('weddingVenue.images'),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Images'),
                ),
                ListTile(
                  title: const Text('License'),
                  subtitle: const Text('weddingVenue.license'),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('License'),
                ),
                ListTile(
                  title: const Text('Location'),
                  subtitle: const Text('weddingVenue.location'),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Location'),
                ),
                ListTile(
                  title: const Text('Meals'),
                  subtitle: const Text(
                    'weddingVenue.meals.join(',
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Meals'),
                ),
                ListTile(
                  title: const Text('Date Range'),
                  // subtitle: Text('${weddingVenue.dateRange.start} - ${weddingVenue.dateRange.end}'),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Date Range'),
                ),
                ListTile(
                  title: const Text('Open Hours'),
                  // subtitle: Text(weddingVenue.openHours),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Open Hours'),
                ),
                ListTile(
                  title: const Text('Drinks'),
                  // subtitle: Text(weddingVenue.drinks.join(', ')),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Drinks'),
                ),
                ListTile(
                  title: const Text('People Price'),
                  subtitle: Text(weddingVenue.peoplePrice.toString()),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('People Price'),
                ),
                ListTile(
                  title: const Text('Maximum People'),
                  subtitle: Text(weddingVenue.peopleMax.toString()),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Maximum People'),
                ),
                ListTile(
                  title: const Text('Minimum People'),
                  subtitle: Text(weddingVenue.peopleMin.toString()),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _navigateToUpdatePage('Minimum People'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UpdateDetailPage extends StatelessWidget {
  final String detail;
  final WeddingVenue weddingVenue;

  const UpdateDetailPage({
    super.key,
    required this.detail,
    required this.weddingVenue,
  });

  @override
  Widget build(BuildContext context) {
    // Implement the UI for updating the specific detail
    return Scaffold(
      appBar: AppBar(
        title: Text('Update $detail'),
      ),
      body: Center(
        child: Text('Update $detail page for ${weddingVenue.name}'),
      ),
    );
  }
}
