import 'package:countries_app/models/country.dart';
import 'package:countries_app/providers/countries.dart';
import 'package:countries_app/utils/regions.dart';
import 'package:countries_app/utils/sort_options.dart';
import 'package:countries_app/widgets/country_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'country_details_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "search-screen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isLoading = false;
  SortOptions sortedBy = SortOptions.None;
  TextEditingController textFieldController = TextEditingController();

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

  void onCountrySelected(BuildContext context, Country country) {
    Navigator.of(context)
        .pushNamed(CountryDetailsScreen.routeName, arguments: country);
  }

  void onSearchTextChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Countries>(context, listen: false)
          .searchCountriesByName(text)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final countriesData = Provider.of<Countries>(context);
    List<Country> countries = countriesData.countries;
    if (sortedBy == SortOptions.Area) {
      countries = countriesData.countriesSortedByArea;
    } else if (sortedBy == SortOptions.Population) {
      countries = countriesData.countriesSortedByPopulation;
    } else {
      countries = countriesData.countries;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textFieldController,
                        textAlignVertical: TextAlignVertical.bottom,
                        textInputAction: TextInputAction.search,
                        onChanged: onSearchTextChanged,
                        decoration: InputDecoration(
                            fillColor: const Color.fromRGBO(238, 238, 238, 1.0),
                            filled: true,
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            hintText: "Search"),
                      ),
                    ),
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
                    label: const Text("Population"),
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
                    label: const Text("Area"),
                    onSelected: (_) => onSortItemSelected(SortOptions.Area),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                "Search Results",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : countriesData.countriesBySearchError != null
                        ? Expanded(
                            child: Center(
                              child: const Text(
                                "No search result",
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
