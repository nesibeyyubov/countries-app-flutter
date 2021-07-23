import 'package:countries_app/models/country.dart';
import 'package:countries_app/providers/countries.dart';
import 'package:countries_app/screens/country_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FavoriteCountryItem extends StatelessWidget {
  final Country country;

  FavoriteCountryItem(this.country);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(CountryDetailsScreen.routeName,arguments: country);
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
              height: 130,
              width: 180,
              child: Stack(
                children: [
                  SvgPicture.network(
                    country.flag,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 130,
                        width: 180,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black26, Colors.black],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      )),
                  Positioned(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width:110,
                              child: Text(
                                country.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              country.capital,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromRGBO(229, 229, 229, 1)),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Provider.of<Countries>(context,listen: false).removeFavoriteCountry(country.flag);
                          },
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    top: 15,
                    left: 10,
                    right: 10,
                  ),
                  Positioned(
                      bottom: 15,
                      left: 10,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                country.population.toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromRGBO(229, 229, 229, 1)),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.my_location,
                                size: 12,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                country.area.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                    color: Color.fromRGBO(229, 229, 229, 1)),
                              )
                            ],
                          )
                        ],
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
