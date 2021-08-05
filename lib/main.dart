import 'package:countries_app/providers/countries.dart';
import 'package:countries_app/screens/countries_screen.dart';
import 'package:countries_app/screens/country_details_screen.dart';
import 'package:countries_app/screens/country_map_screen.dart';
import 'package:countries_app/screens/favorites_screen.dart';
import 'package:countries_app/screens/home_screen.dart';
import 'package:countries_app/screens/question_screen.dart';
import 'package:countries_app/screens/quiz_screen.dart';
import 'package:countries_app/screens/search_screen.dart';
import 'package:countries_app/widgets/countries_placeholder_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentIndex = 0;

  void onBottomNavItemSelect(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var bottomNavigationScreens = [
      HomeScreen(),
      SearchScreen(),
      QuizScreen(),
      FavoritesScreen()
    ];
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(7, 165, 129, 1),
        statusBarIconBrightness: Brightness.light));
    return ChangeNotifierProvider(
      create: (ctx) => Countries(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(7, 165, 129, 1),
        ),
        home: Scaffold(
          body: bottomNavigationScreens[_currentIndex],
          // body: CountriesPlaceholderLoading(),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: const Color.fromRGBO(7, 165, 129, 1),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            currentIndex: _currentIndex,
            onTap: onBottomNavItemSelect,
            items: [
              BottomNavigationBarItem(
                  icon: const  Icon(Icons.home),
                  label: "Home",
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: const Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(icon: const Icon(Icons.quiz), label: "Quiz"),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite), label: "Favorites"),
            ],
          ),
        ),
        routes: {
          CountriesScreen.routeName: (ctx) => CountriesScreen(),
          FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
          CountryDetailsScreen.routeName: (ctx) => CountryDetailsScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          QuizScreen.routeName: (ctx) => QuizScreen(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          CountryMapScreen.routeName: (ctx) => CountryMapScreen(),
          QuestionScreen.routeName: (ctx) => QuestionScreen()
        },
      ),
    );
  }
}
