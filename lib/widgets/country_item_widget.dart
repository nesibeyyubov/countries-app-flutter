import 'package:countries_app/models/country.dart';
import 'package:countries_app/providers/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CountryItem extends StatefulWidget {
  final Function onCountryClicked;
  final Country country;

  CountryItem(this.onCountryClicked, this.country);

  @override
  _CountryItemState createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _heartAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _heartAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.bounceInOut));
  }

  void _startHeartAnimation() {
    _animationController.forward().then((value) {
      _animationController.reverse();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Build is running...");
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
        color: const Color.fromRGBO(238, 238, 238, 1.0),
        child: InkWell(
          onTap: () => widget.onCountryClicked(),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 70,
                  child: SvgPicture.network(
                    widget.country.flag,
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
                        widget.country.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      widget.country.capital,
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Spacer(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 3),
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
                                widget.country.population.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
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
                                widget.country.area.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
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
                    _startHeartAnimation();
                    countriesData.toggleFavoriteStatus(widget.country.flag);
                  },
                  child: ScaleTransition(
                    scale: _heartAnimation as Animation<double>,
                    child: Container(
                      child: Icon(
                        widget.country.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 20,
                        color: widget.country.isFavorite
                            ? Colors.red
                            : Colors.black87,
                      ),
                    ),
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
