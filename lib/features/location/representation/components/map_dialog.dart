import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

//* This shows map for the user/event location (CAN BE CHANGED)
class MapDialog extends StatelessWidget {
  final double latitude;
  final double longitude;
  final Marker marker;
  final void Function(TapPosition, LatLng)? onTap;
  final void Function()? onCancel;
  final void Function()? onConfirm;

  const MapDialog({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.marker,
    required this.onTap,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Your current location, you can pick a new one',
                  style: TextStyle(
                    color: GColors.black,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(latitude, longitude),
                  initialZoom: 15,
                  interactionOptions: const InteractionOptions(
                    flags: ~InteractiveFlag.doubleTapZoom,
                  ),
                  onTap: onTap,
                ),
                children: [
                  openStreet,
                  MarkerLayer(
                    markers: [
                      marker,
                    ],
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //cancel button
                    TextButton.icon(
                      onPressed: onCancel,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          GColors.white,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.clear,
                        color: GColors.redShade3,
                      ),
                      label: Text(
                        'Cancel',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    //confirm button
                    TextButton.icon(
                      onPressed: onConfirm,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          GColors.white,
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),
                      icon: Icon(
                        Icons.check,
                        color: GColors.greenShade3,
                      ),
                      label: Text(
                        'Confirm',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TileLayer get openStreet => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.events_jo',
    );
