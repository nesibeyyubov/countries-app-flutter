import 'package:countries_app/database/database.dart';
import 'package:http/http.dart' as http;
import 'package:countries_app/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class Countries with ChangeNotifier {
  List<Country> _countries = [];
  List<Country> _favoriteCountries = [];

  List<Country> get countries {
    return [..._countries];
  }

  List<Country> get favoriteCountries {
    return [..._favoriteCountries];
  }

  List<Country> get countriesSortedByPopulation {
    var copiedCountries = [..._countries];
    copiedCountries.sort((country1, country2) {
      return country2.population.compareTo(country1.population);
    });
    return copiedCountries;
  }

  bool isCountryFavorite(String flag){
    if(favoriteCountries.indexWhere((element) => element.flag == flag) != -1){
      return true;
    }
    return false;
  }

  List<Country> get countriesSortedByArea {
    var copiedCountries = [..._countries];
    copiedCountries.sort((country1, country2) {
      return country2.area.compareTo(country1.area);
    });
    return copiedCountries;
  }

  Future<void> getFavoriteCountries() async {
    final db = CountriesDatabase.instance;
    final countries = await db.getCountries();
    _favoriteCountries = countries;
    notifyListeners();
  }

  Future<void> searchCountriesByName(String name) async{
    List<Country> loadedProducts = [];
    final url = Uri.parse("https://restcountries.eu/rest/v2/name/$name");
    final response = await http.get(url);
    List<dynamic> decodedResponse = json.decode(response.body);
    decodedResponse.forEach((ctry) {
      var country = Country.fromJson(ctry);
      loadedProducts.add(country);
    });
    final db = CountriesDatabase.instance;
    final favoriteCountries = await db.getCountries();
    for(var i = 0;i<loadedProducts.length;i++){
      for(var j = 0;j<favoriteCountries.length;j++){
        if(favoriteCountries[j].flag == loadedProducts[i].flag){
          loadedProducts[i].isFavorite = true;
          break;
        }
      }
    }
    _countries = loadedProducts;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String flag) async {
    final favoriteToggledCountry =
        _countries.firstWhere((element) => element.flag == flag).toggleFavoriteStatus();
    if (!favoriteToggledCountry.isFavorite) {
      _favoriteCountries.remove(favoriteToggledCountry);
    } else {
      _favoriteCountries.add(favoriteToggledCountry);
    }
    notifyListeners();
    final db = CountriesDatabase.instance;
    if (favoriteToggledCountry.isFavorite) {
      db.insert(favoriteToggledCountry);
    } else {
      db.delete(favoriteToggledCountry.flag);
    }
  }

  Future<void> removeFavoriteCountry(String flag) async{
    _favoriteCountries.removeWhere((element) => element.flag == flag);
    notifyListeners();
    await CountriesDatabase.instance.delete(flag);
  }

  Future<void> getCountriesByRegion(String region) async {
    try {
      List<Country> loadedCountries = [];
      var uri = Uri.parse("https://restcountries.eu/rest/v2/region/$region");
      var response = await http.get(uri);
      List<dynamic> decodedResponse = json.decode(response.body);
      decodedResponse.forEach((country) {
        var newCountry = Country.fromJson(country);
        loadedCountries.add(newCountry);
      });

      final db = CountriesDatabase.instance;
      final favoriteCountries = await db.getCountries();
      loadedCountries.forEach((country) {
        for (var i = 0; i < favoriteCountries.length; i++) {
          if (favoriteCountries[i].flag == country.flag) {
            country.isFavorite = true;
            break;
          }
        }
      });
      _countries = loadedCountries;
      notifyListeners();

    } catch (exception) {
      print(exception.toString());
    }
  }
}
