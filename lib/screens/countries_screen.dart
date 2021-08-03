import 'package:countries_app/models/country.dart';
import 'package:countries_app/providers/countries.dart';
import 'package:countries_app/screens/country_details_screen.dart';
import 'package:countries_app/utils/regions.dart';
import 'package:countries_app/utils/sort_options.dart';
import 'package:countries_app/widgets/countries_placeholder_loading.dart';
import 'package:countries_app/widgets/country_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountriesScreen extends StatefulWidget {
  static const routeName = "countries-screen";

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  String _searchViewText = "";
  SortOptions sortedBy = SortOptions.None;

  void onSortItemSelected(SortOptions sortItem) {
    if (sortItem == SortOptions.Population) {
      if (sortedBy == SortOptions.Population) {
        setState(() {
          sortedBy = SortOptions.None;
        });
      } else {
        setState(() {
          sortedBy = SortOptions.Population;
        });
      }
    } else if (sortItem == SortOptions.Area) {
      if (sortedBy == SortOptions.Area) {
        setState(() {
          sortedBy = SortOptions.None;
        });
      } else {
        setState(() {
          sortedBy = SortOptions.Area;
        });
      }
    }
  }

  String getRegionName(Region region) {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      final region = getRegionName(arguments['region'] as Region);
      setState(() {
        _isLoading = true;
      });
      Provider.of<Countries>(context, listen: false)
          .getCountriesByRegion(region.toLowerCase())
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  void onCountrySelected(BuildContext context, Country country) {
    Navigator.of(context).pushNamed(CountryDetailsScreen.routeName,
        arguments: {'country': country, 'fromFavorites': false});
  }

  void onSearchTextChanged(String text) {
    setState(() {
      _searchViewText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final region = getRegionName(arguments['region'] as Region);
    final regionColors = arguments['regionColors'];

    final countriesData = Provider.of<Countries>(context);
    List<Country> countries;
    if (sortedBy == SortOptions.Area) {
      countries = countriesData.countriesSortedByArea;
    } else if (sortedBy == SortOptions.Population) {
      countries = countriesData.countriesSortedByPopulation;
    } else {
      countries = countriesData.countries;
    }

    countries = countries
        .where((element) =>
            element.name.toLowerCase().contains(_searchViewText.toLowerCase()))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        textInputAction: TextInputAction.search,
                        onChanged: onSearchTextChanged,
                        decoration: InputDecoration(
                            fillColor: Color.fromRGBO(238, 238, 238, 1.0),
                            filled: true,
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: "Search"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: regionColors),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          region,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: Text("SORT BY: ")),
                  FilterChip(
                    label: Text("Population"),
                    backgroundColor: sortedBy == SortOptions.Population
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    onSelected: (_) =>
                        onSortItemSelected(SortOptions.Population),
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1)),
                    labelStyle: TextStyle(
                        color: sortedBy == SortOptions.Population
                            ? Colors.white
                            : Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  FilterChip(
                    backgroundColor: sortedBy == SortOptions.Area
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1)),
                    labelStyle: TextStyle(
                        color: sortedBy == SortOptions.Area
                            ? Colors.white
                            : Theme.of(context).primaryColor),
                    label: Text("Area"),
                    onSelected: (_) => onSortItemSelected(SortOptions.Area),
                  ),
                ],
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 10),
                child: _isLoading
                    ? SingleChildScrollView(
                        child: CountriesPlaceholderLoading())
                    : countriesData.countriesByRegionError != null
                        ? Expanded(
                            child: Center(
                              child: Text(
                                countriesData.countriesByRegionError!,
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: countries.length,
                            itemBuilder: (ctx, index) => CountryItem(
                                () => onCountrySelected(
                                    context, countries[index]),
                                countries[index])),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
