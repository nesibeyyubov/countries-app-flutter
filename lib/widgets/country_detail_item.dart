import 'package:flutter/material.dart';

class CountryDetailItem extends StatelessWidget {
  final String detailKey;
  final String detailValue;

  CountryDetailItem({required this.detailKey, required this.detailValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(10),
      color: Color.fromRGBO(239, 239, 239, 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            detailKey,
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Spacer(),
          Text(
            detailValue,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
