import 'package:flutter/material.dart';

class PickPlaceMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black54, offset: Offset(-1, 0), blurRadius: 2.0),
        ],
      ),
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.place_sharp,
            color: Colors.grey,
          ),
          SizedBox(width: 10.0),
          Text(
            'Choose on map',
            style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
