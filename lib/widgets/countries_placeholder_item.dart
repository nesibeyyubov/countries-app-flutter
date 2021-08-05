import 'package:flutter/material.dart';

class CountriesPlaceholderItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 70,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 210,
                  height: 15,
                  color: Colors.grey,
                ),
                SizedBox(height: 4,),
                Container(
                  width: 80,
                  height: 15,
                  color: Colors.grey,
                ),
                Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 40,
                            height: 15,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 14,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 40,
                            height: 15,
                            color: Colors.grey,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              width: 20,
              height: 15,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
