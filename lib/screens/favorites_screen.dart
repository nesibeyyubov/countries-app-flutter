import 'package:countries_app/models/country.dart';
import 'package:countries_app/providers/countries.dart';
import 'package:countries_app/widgets/favorite_country_item.dart';
import 'package:countries_app/widgets/favorite_region_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = "favorites-screen";

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Countries>(context, listen: false)
          .getFavoriteCountries()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final favoriteCountries =
        Provider.of<Countries>(context, listen: true).favoriteCountries;

    print(favoriteCountries);
    final List<Country> europeCountries = favoriteCountries
        .where((element) => element.region == "Europe")
        .toList();
    final List<Country> asiaCountries =
        favoriteCountries.where((element) => element.region == "Asia").toList();
    final List<Country> africaCountries = favoriteCountries
        .where((element) => element.region == "Africa")
        .toList();
    final List<Country> americaCountries = favoriteCountries
        .where((element) => element.region == "Americas")
        .toList();
    final List<Country> oceaniaCountries = favoriteCountries
        .where((element) => element.region == "Oceania")
        .toList();

    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Your Favorites",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (europeCountries.isNotEmpty)
                      FavoriteRegionListItem("Europe", europeCountries),
                    if (asiaCountries.isNotEmpty)
                      FavoriteRegionListItem("Asia", asiaCountries),
                    if (africaCountries.isNotEmpty)
                      FavoriteRegionListItem("Africa", africaCountries),
                    if (americaCountries.isNotEmpty)
                      FavoriteRegionListItem("America", americaCountries),
                    if (oceaniaCountries.isNotEmpty)
                      FavoriteRegionListItem("Oceania", oceaniaCountries),
                  ],
                ),
              ),
            ),
    );
  }
}
