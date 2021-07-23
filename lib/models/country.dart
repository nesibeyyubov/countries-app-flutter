import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Country with ChangeNotifier {
  final String name;
  final String flag;
  final String capital;
  final String region;
  final String alpha3Code;
  final int population;
  final double area;
  bool isFavorite = false;
  final List<double> latlng;
  final List<String> callingCodes;
  final List<String> borders;
  final List<Map<String, dynamic>> currencies;
  final List<Map<String, dynamic>> languages;

  Country(
      {required this.name,
      required this.flag,
      required this.callingCodes,
      required this.capital,
      required this.alpha3Code,
      required this.region,
      required this.population,
      required this.latlng,
      required this.currencies,
      required this.languages,
      required this.borders,
      required this.area});

  Country toggleFavoriteStatus() {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
    return this;
  }

  static Map<String, Object> toMap(Country country) {
    return {
      'name': country.name,
      'flag': country.flag,
      'callingCodes': json.encode(country.callingCodes),
      'capital': country.capital,
      'alpha3Code': country.alpha3Code,
      'region': country.region,
      'population': country.population,
      'latlng': json.encode(country.latlng),
      'currencies': json.encode(country.currencies),
      'languages': json.encode(country.languages),
      'borders': json.encode(country.borders),
      'area': country.area,
      'isFavorite': country.isFavorite ? 1 : 0
    };
  }

  static Country toCountry(Map<String, dynamic> country) {
    return Country(
        name: country['name'],
        flag: country['flag'],
        callingCodes: List<String>.from(json.decode(country['callingCodes'])),
        capital: country['capital'],
        alpha3Code: country['alpha3Code'],
        region: country['region'],
        population: country['population'],
        latlng: List<double>.from(json.decode(country['latlng'])),
        currencies: List<Map<String, dynamic>>.from(json.decode(country['currencies'])),
        languages: List<Map<String, dynamic>>.from(json.decode(country['languages'])),
        borders: List<String>.from(json.decode(country['borders'])),
        area: country['area']);
  }


  static Country fromJson(country) {
    return Country(
        name: country['name'],
        flag: country['flag'],
        alpha3Code: country['alpha3Code'],
        callingCodes: List<String>.from(country['callingCodes']),
        capital: country['capital'],
        region: country['region'],
        population: country['population'],
        latlng: List<double>.from(country['latlng']),
        currencies: List<Map<String, dynamic>>.from(country['currencies']),
        languages: List<Map<String, dynamic>>.from(country['languages']),
        borders: List<String>.from(country['borders']),
        area: country['area'] ?? 0);
  }

  @override
  String toString() {
    return this.name;
  }
}
