import 'package:flutter/material.dart';

class SearchButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.1,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.grey[200],
      ),
      child: Text(
        'Para onde?',
        style: TextStyle(fontSize: 17.0, fontFamily: 'Brand Bold'),
      ),
    );
  }
}
