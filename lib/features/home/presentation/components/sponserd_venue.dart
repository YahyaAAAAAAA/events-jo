import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/dummy.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_cubit.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_states.dart';
import 'package:events_jo/features/events/courts/representation/pages/football_courts_details_page.dart';
import 'package:events_jo/features/events/shared/domain/models/event.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_states.dart';
import 'package:events_jo/features/events/weddings/representation/pages/wedding_venues_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SponsoredVenue extends StatefulWidget {
  final AppUser user;
  final int selectedTab;

  const SponsoredVenue({
    super.key,
    required this.user,
    required this.selectedTab,
  });

  @override
  State<SponsoredVenue> createState() => _SponsoredVenueState();
}

class _SponsoredVenueState extends State<SponsoredVenue> {
  static const int maxItems = 5;

  int venueCurrentIndex = 0;
  int courtCurrentIndex = 0;
  int? venueIndexLimit;
  int? courtIndexLimit;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant SponsoredVenue oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTab != widget.selectedTab) {
      _resetIndexes();
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      setState(() {
        if (widget.selectedTab == 0 &&
            venueIndexLimit != null &&
            venueIndexLimit! > 0) {
          venueCurrentIndex = (venueCurrentIndex + 1) % venueIndexLimit!;
        } else if (widget.selectedTab == 1 &&
            courtIndexLimit != null &&
            courtIndexLimit! > 0) {
          courtCurrentIndex = (courtCurrentIndex + 1) % courtIndexLimit!;
        }
      });
    });
  }

  void _resetIndexes() {
    setState(() {
      venueCurrentIndex = 0;
      courtCurrentIndex = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedTab == 0
        ? BlocBuilder<WeddingVenuesCubit, WeddingVenuesStates>(
            builder: (context, state) {
              if (state is WeddingVenuesLoaded) {
                final venues = state.venues;
                venueIndexLimit = min(venues.length, maxItems);
                return buildWidget(venues, false);
              } else {
                venueIndexLimit = null;
                return Skeletonizer(
                  enabled: true,
                  containersColor: GColors.white,
                  child: buildWidget(
                      List.generate(maxItems, (_) => Dummy.venue), true),
                );
              }
            },
          )
        : BlocBuilder<FootballCourtsCubit, FootballCourtsStates>(
            builder: (context, state) {
              if (state is FootballCourtsLoaded) {
                final courts = state.courts;
                courtIndexLimit = min(courts.length, maxItems);
                return buildWidget(courts, false);
              } else {
                courtIndexLimit = null;
                return Skeletonizer(
                  enabled: true,
                  containersColor: GColors.white,
                  child: buildWidget(
                      List.generate(maxItems, (_) => Dummy.venue), true),
                );
              }
            },
          );
  }

  Widget buildWidget(List<Event> events, bool isLoading) {
    final isVenue = widget.selectedTab == 0;
    final currentIndex = isVenue ? venueCurrentIndex : courtCurrentIndex;

    if (events.isEmpty || currentIndex >= events.length) {
      return const Center(
          child: Text("No venues or courts available right now."));
    }

    final currentEvent = events[currentIndex];
    final imageUrl =
        currentEvent.pics.isEmpty ? kPlaceholderImage : currentEvent.pics[0];

    return FittedBox(
      child: InkWell(
        onTap: () {
          if (isVenue && currentEvent is WeddingVenue) {
            context.push(WeddingVenuesDetailsPage(
                user: widget.user, weddingVenue: currentEvent));
          } else if (!isVenue && currentEvent is FootballCourt) {
            context.push(FootballCourtsDetailsPage(
                user: widget.user, footballCourt: currentEvent));
          }
        },
        borderRadius: BorderRadius.circular(kOuterRadius),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: isLoading
                ? null
                : LinearGradient(
                    colors: GColors.logoGradientColors.reversed.toList()),
            color: GColors.royalBlue,
            borderRadius: BorderRadius.circular(kOuterRadius),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      width: 115,
                      child: Text(
                        isVenue
                            ? 'Check Out Our Top Venues'
                            : 'Check Out Our Top Courts',
                        style: TextStyle(
                          color: GColors.white,
                          fontSize: kNormalFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (isVenue && currentEvent is WeddingVenue) {
                          context.push(WeddingVenuesDetailsPage(
                              user: widget.user, weddingVenue: currentEvent));
                        } else if (!isVenue && currentEvent is FootballCourt) {
                          context.push(FootballCourtsDetailsPage(
                              user: widget.user, footballCourt: currentEvent));
                        }
                      },
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kSmallFontSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(kOuterRadius),
                  bottomRight: Radius.circular(kOuterRadius),
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(kOuterRadius),
                          bottomRight: Radius.circular(kOuterRadius),
                        ),
                        border: Border.all(
                          color: const Color(0xFF3089dd),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(kOuterRadius),
                          bottomRight: Radius.circular(kOuterRadius),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              const GlobalLoadingImage(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline, color: GColors.black),
                          fit: BoxFit.cover,
                          height: 150,
                          width: 225,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(min(events.length, maxItems),
                            (index) {
                          final isSelected = index == currentIndex;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.5),
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: isSelected
                                    ? GColors.royalBlue
                                    : GColors.white,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      bottom: -1,
                      left: -1,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(maxWidth: 200),
                        decoration: const BoxDecoration(
                          color: Color(0xFF3089dd),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(kOuterRadius)),
                        ),
                        child: Text(
                          currentEvent.name,
                          style: TextStyle(
                            color: GColors.white,
                            fontSize: kSmallFontSize,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
