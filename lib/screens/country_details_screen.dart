import 'package:countries_app/models/country.dart';
import 'package:countries_app/providers/countries.dart';
import 'package:countries_app/screens/country_map_screen.dart';
import 'package:countries_app/widgets/border_item.dart';
import 'package:countries_app/widgets/country_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CountryDetailsScreen extends StatelessWidget {
  static const routeName = "country-details-screen";

  @override
  Widget build(BuildContext context) {
    final countriesData = Provider.of<Countries>(context);
    List<Country> allCountries = countriesData.countries;

    final routes = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    Country country = routes['country'] as Country;
    bool fromFavorites = routes['fromFavorites'] as bool;
    bool isCountryFavorite = countriesData.isCountryFavorite(country.flag);

    List<Country> borders = allCountries
        .where((ctry) => ctry.borders.contains(country.alpha3Code))
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SvgPicture.network(
                      country.flag,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      ),
                      bottom: 0,
                    ),
                    Positioned(
                      left: 5,
                      top: 25,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      child: Text(
                        country.name,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    Positioned(
                        bottom: 15,
                        right: 15,
                        child: GestureDetector(
                          onTap: () {
                            countriesData.toggleFavoriteStatus(country.flag);
                          },
                          child: Icon(
                            isCountryFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 26,
                            color:
                                isCountryFavorite ? Colors.red : Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Capital: ${country.capital}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Population and area",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              horizontal:
                                  BorderSide(color: Colors.grey, width: 1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people,
                                color: Theme.of(context).primaryColor,
                                size: 50,
                              ),
                              Text(
                                country.population.toString(),
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.my_location,
                                color: Theme.of(context).primaryColor,
                                size: 50,
                              ),
                              Text(
                                "${country.area.toString()}km",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    CountryDetailItem(
                      detailKey: "Currency",
                      detailValue: country.currencies[0]['code'] as String,
                    ),
                    CountryDetailItem(
                      detailKey: "Language",
                      detailValue: country.languages[0]['name'] as String,
                    ),
                    CountryDetailItem(
                      detailKey: "Calling code",
                      detailValue: "+${country.callingCodes[0]}",
                    ),
                    CountryDetailItem(
                      detailKey: "Region",
                      detailValue: country.region,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if(!fromFavorites) Container(
                      margin: EdgeInsets.only(left: 10),
                      child: const Text(
                        "Borders",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    if(!fromFavorites) borders.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 5, left: 10),
                            child: const Text("No borders"))
                        : Container(
                            height: 100,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 10, top: 15),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: borders
                                  .map((border) =>
                                      BorderItem(border.name, border.flag))
                                  .toList(),
                            ),
                          ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: double.infinity,
                      child: Material(
                        color: Theme.of(context).primaryColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, CountryMapScreen.routeName,
                                arguments: country.latlng);
                          },
                          splashColor: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on, color: Colors.white),
                              const Text(
                                "SHOW IN MAP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
