import 'package:flutter/material.dart';
import 'package:oddo/constants/textstyles.dart';

class HomeScreenCards extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  HomeScreenCards(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onPressed,
        child: Card(
          child: Center(
            child: Text(text, style: black18w600,),
          ),
        ),
      ),
    );
  }
}