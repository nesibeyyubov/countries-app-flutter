import 'package:countries_app/utils/sort_options.dart';
import 'package:flutter/material.dart';


class SortBy extends StatefulWidget {
  @override
  _SortByState createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: const Text("SORT BY: ")),
        FilterChip(
          label: const Text("Population"),
          backgroundColor: sortedBy == SortOptions.Population
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          onSelected: (_) => onSortItemSelected(SortOptions.Population),
          shape: StadiumBorder(
              side:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1)),
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
              side:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1)),
          labelStyle: TextStyle(
              color: sortedBy == SortOptions.Area
                  ? Colors.white
                  : Theme.of(context).primaryColor),
          label: const Text("Area"),
          onSelected: (_) => onSortItemSelected(SortOptions.Area),
        ),
      ],
    );
  }
}
