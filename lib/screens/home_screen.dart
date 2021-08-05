import 'package:countries_app/screens/countries_screen.dart';
import 'package:countries_app/utils/regions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "home-screen";

  void onRegionSelected(
      Region region, List<Color> regionColors, BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CountriesScreen.routeName,
        arguments: {'region': region, 'regionColors': regionColors});
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        RegionItem(onRegionSelected),
                        Spacer(),
                        RegionItem(onRegionSelected, Region.Europe),
                      ],
                    ),
                    Row(
                      children: [
                        RegionItem(onRegionSelected, Region.Asia),
                        Spacer(),
                        RegionItem(onRegionSelected, Region.Africa),
                      ],
                    ),
                    Row(
                      children: [
                        RegionItem(onRegionSelected, Region.America),
                        Spacer(),
                        RegionItem(onRegionSelected, Region.Oceania),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class RegionItem extends StatelessWidget {
  final Region? region;
  final Function onRegionSelected;

  RegionItem(this.onRegionSelected, [this.region]);

  String get regionName {
    switch (region) {
      case Region.Oceania:
        return "Oceania";
      case Region.America:
        return "Americas";
      case Region.Africa:
        return "Africa";
      case Region.Asia:
        return "Asia";
      case Region.Europe:
        return "Europe";
      default:
        return "Select Region";
    }
  }

  List<Color> get regionColors {
    switch (region) {
      case Region.Oceania:
        return [Color(0xff2fceff), Color(0xff0084a9)];
      case Region.America:
        return [Color(0xff3622ff), Color(0xff1800fd)];
      case Region.Africa:
        return [Color(0xffff8659), Color(0xfffc5a22)];
      case Region.Asia:
        return [Color(0xff017bd2), Color(0xff004879)];
      case Region.Europe:
        return [Color(0xff07A581), Color(0xff06755C)];
      default:
        return [Colors.transparent];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: 170,
      height: 120,
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            boxShadow: region == null
                ? null
                : [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                    )
                  ],
            borderRadius: BorderRadius.circular(10),
            gradient: region == null
                ? null
                : LinearGradient(
                    colors: regionColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
          ),
          child: InkWell(
            onTap: () => onRegionSelected(region, regionColors, context),
            splashColor: Colors.black12,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                regionName,
                style: TextStyle(
                    fontSize: 25,
                    color: region == null ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
