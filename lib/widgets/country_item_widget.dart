import 'package:countries_app/models/country.dart';
import 'package:countries_app/providers/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CountryItem extends StatelessWidget {
  final Function onCountryClicked;
  final Country country;

  CountryItem(this.onCountryClicked,this.country);

  @override
  Widget build(BuildContext context) {
    final countriesData = Provider.of<Countries>(context);
    return Container(
        height: 80,
        margin: EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
            // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            borderRadius: BorderRadius.circular(5),
            // color: Color.fromRGBO(238, 238, 238, 1.0)
        ),
        child: Material(
          color: Color.fromRGBO(238, 238, 238, 1.0),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: InkWell(
              onTap: ()=>onCountryClicked(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 70,
                    child: SvgPicture.network(
                      country.flag,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 210,
                        child: Text(
                          country.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Text(
                        country.capital,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(bottom: 3),
                        child: Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  country.population.toString(),
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.my_location,
                                  size: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  country.area.toString(),
                                  style: TextStyle(fontSize: 12, color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      countriesData.toggleFavoriteStatus(country.flag);
                    },
                    child: Icon(
                      country.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: country.isFavorite ? Colors.red : Colors.black87,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}