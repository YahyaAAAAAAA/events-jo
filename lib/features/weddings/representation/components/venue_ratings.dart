import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/representation/components/venue_rate.dart';
import 'package:flutter/material.dart';

class VenueRating extends StatelessWidget {
  final AppUser user;
  final List<String> rates;

  const VenueRating({
    super.key,
    required this.rates,
    required this.user,
  });

  Map<String, dynamic> calculateRatings() {
    List<int> rateDistribution = [0, 0, 0, 0, 0];
    double averageRate = 0;
    double sumRate = 0;
    double factorRate = 0;

    for (int i = 0; i < rates.length; i++) {
      final rate = rates[i].parseRateString()[0];
      if (int.parse(rate) != 0) {
        factorRate++;
        sumRate += double.parse(rate);
      }
      switch (rate) {
        case '1':
          rateDistribution[4] += 1;
          break;
        case '2':
          rateDistribution[3] += 1;
          break;
        case '3':
          rateDistribution[2] += 1;
          break;
        case '4':
          rateDistribution[1] += 1;
          break;
        case '5':
          rateDistribution[0] += 1;
          break;
      }
    }
    averageRate = sumRate == 0 ? 0 : sumRate / factorRate;

    return {
      'rateDistribution': rateDistribution,
      'averageRate': averageRate,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final ratingsData = calculateRatings();
        final rateDistribution = ratingsData['rateDistribution'] as List<int>;
        final averageRate = ratingsData['averageRate'] as double;

        showModalBottomSheet(
          context: context,
          backgroundColor: GColors.whiteShade3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(kOuterRadius),
            ),
          ),
          showDragHandle: true,
          isScrollControlled: true,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    "Ratings and reviews",
                    style: TextStyle(
                      color: GColors.black,
                      fontSize: kNormalFontSize,
                    ),
                  ),
                  8.height,
                  // Rates distribution
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            averageRate.toStringAsFixed(1),
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kBiglFontSize + 5,
                            ),
                          ),
                          Text(
                            "Total Ratings: ${rates.length}",
                            style: TextStyle(
                              color: GColors.black,
                              fontSize: kSmallFontSize,
                            ),
                          ),
                        ],
                      ),
                      20.width,
                      Column(
                        children: List.generate(5, (index) {
                          int star = 5 - index;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                star.toString(),
                                style: TextStyle(
                                  color: GColors.emptyRate,
                                  fontSize: kSmallFontSize,
                                ),
                              ),
                              5.width,
                              SizedBox(
                                width: 200,
                                child: LinearProgressIndicator(
                                  value: rateDistribution[index] == 0
                                      ? 0
                                      : rateDistribution[index] / rates.length,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                  20.height,
                  // Users ratings
                  ListView.separated(
                    itemCount: rates.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final rate = rates[index].parseRateString();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          IconButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  GColors.whiteShade3.shade600),
                            ),
                            icon: Icon(
                              Icons.person_outline_outlined,
                              color: GColors.royalBlue,
                              size: kNormalIconSize,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    //TODO
                                    user.name == rate[2]
                                        ? '${rate[2]} (You)'
                                        : rate[2],
                                    style: TextStyle(
                                      color: GColors.black,
                                      fontSize: kSmallFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ', booked ${rate[1]} times',
                                    style: TextStyle(
                                      color:
                                          GColors.black.withValues(alpha: 0.8),
                                      fontSize: kSmallFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  VenueRate(
                                    rating: int.parse(rate[0]),
                                    starSize: kSmallIconSize,
                                    fullColor: GColors.emptyRate,
                                    emptyColor: GColors.emptyRate,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Wrap(
        children: List.generate(5, (index) {
          return Icon(
            Icons.star_rate_rounded,
            color: index < calculateRatings()['averageRate'].round()
                ? GColors.fullRate
                : GColors.emptyRate,
            size: kSmallIconSize - 5,
          );
        }),
      ),
    );
  }
}
