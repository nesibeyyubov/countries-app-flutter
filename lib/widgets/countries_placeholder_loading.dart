import 'package:countries_app/widgets/countries_placeholder_item.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesPlaceholderLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color(0xFFCDCDCD),
        highlightColor: const Color(0xFFEEEEEE),
        child: Column(
          children: [
            CountriesPlaceholderItem(),
            CountriesPlaceholderItem(),
            CountriesPlaceholderItem(),
            CountriesPlaceholderItem(),
            CountriesPlaceholderItem(),
            CountriesPlaceholderItem(),
            CountriesPlaceholderItem(),
          ],
        ));
  }
}
