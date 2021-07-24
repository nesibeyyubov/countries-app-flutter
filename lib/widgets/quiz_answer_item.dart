import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizAnswerItem extends StatelessWidget {
  final String optionText;
  final int variant;
  final bool isRightQuestion;
  final Function onOptionsItemSelected;
  final bool isAnswered;

  QuizAnswerItem({
    required this.optionText,
    required this.variant,
    required this.onOptionsItemSelected,
    required this.isAnswered,
    required this.isRightQuestion,
  });

  String get variantName {
    switch (variant) {
      case 0:
        return "A";
      case 1:
        return "B";
      case 2:
        return "C";
      case 3:
        return "D";
      default:
        return "A";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onOptionsItemSelected(isRightQuestion),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: isAnswered
                ? isRightQuestion
                    ? Theme.of(context).primaryColor
                    : Colors.red
                : Color(0xFFE4F0EE),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 6),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: Color(0xFFFEC107),
                  borderRadius: BorderRadius.circular(17.5)),
              child: Center(
                child: Text(
                  variantName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              width: 250,
              child: Text(
                optionText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isAnswered ? Colors.white : Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }
}
