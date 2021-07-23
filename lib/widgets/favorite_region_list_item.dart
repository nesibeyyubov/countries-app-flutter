import 'package:countries_app/models/country.dart';
import 'package:flutter/material.dart';

import 'favorite_country_item.dart';

class FavoriteRegionListItem extends StatelessWidget {
  final String region;
  final List<Country> countries;

  FavoriteRegionListItem(this.region,this.countries);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            region,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black),
          ),
          SizedBox(height: 10,),
          Container(
            height: 130,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (ctx,position){
                return FavoriteCountryItem(countries[position]);
              },
              itemCount: countries.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}
