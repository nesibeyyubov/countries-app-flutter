import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BorderItem extends StatelessWidget {
  final String name;
  final String flag;

  BorderItem(this.name,this.flag);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 95,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(color: Color.fromRGBO(239, 239, 239, 1.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Container(
              width: 50,
              height: 50,
              child: SvgPicture.network(
                flag,
                fit: BoxFit.cover,
              ),
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}