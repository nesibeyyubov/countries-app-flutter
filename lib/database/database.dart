import 'dart:ffi';

import 'package:countries_app/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CountriesDatabase {
  CountriesDatabase._init();

  static final CountriesDatabase instance = CountriesDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    final String typeText = "TEXT";
    final String typePrimaryKey = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final String typeDouble = "REAL";
    final String typeInteger = "INTEGER";

    final dbPath = await getDatabasesPath();
    final fullPath = join(dbPath!, "countries.db");
    _database =
        await openDatabase(fullPath, version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE countries_table(id $typePrimaryKey, "
              "name $typeText, "
              "flag $typeText, "
              "capital $typeText, "
              "region $typeText, "
              "alpha3Code $typeText, "
              "population $typeInteger, "
              "area $typeDouble, "
              "isFavorite $typeInteger,"
              "latlng $typeText,"
              "callingCodes $typeText,"
              "borders $typeText,"
              "currencies $typeText,"
              "languages $typeText"
              ")"
      );

    });
    return _database!;
  }

  Future<void> insert(Country country) async {
    final db = await database;
    await db.insert("countries_table", Country.toMap(country));
  }

  Future<void> delete(String flag) async{
    final db = await database;
    await db.delete("countries_table",where: "flag = ?",whereArgs: [flag]);
  }

  Future<List<Country>> getCountries() async {
    final db = await database;
    final List<Map<String, dynamic>> countriesMap =
        await db.query("countries_table");
    final List<Country> countries =
        countriesMap.map((countryMap) => Country.toCountry(countryMap)).toList();
    return countries;
  }
}
