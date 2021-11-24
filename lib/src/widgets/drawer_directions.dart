import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rescuing_dreams/src/controller/map_controller.dart';
import 'package:rescuing_dreams/src/fire_base/fire_base_auth.dart';

class DrawerDirections extends StatelessWidget {
  String distance;
  String duraction;
  int amount;
  Function() onPress;

  DrawerDirections({
    required this.distance,
    required this.duraction,
    required this.amount,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 16.0,
            spreadRadius: 0.5,
            offset: Offset(0.7, 0.7),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 17),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.indigo[100],
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/circle_pin.png",
                      height: 45,
                      width: 45,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Guincho",
                          style:
                              TextStyle(fontSize: 18, fontFamily: "Brand-Bold"),
                        ),
                        Row(
                          children: [
                            Text(
                              distance,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              ' do destino',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Text(
                      "R\$ " + amount.toString() + ',00',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontFamily: "Brand-Bold"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(CupertinoIcons.money_dollar,
                      size: 18, color: Colors.black54),
                  SizedBox(width: 16),
                  Text("Cash"),
                  SizedBox(width: 16),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black54,
                    size: 16,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onLongPress: null,
                child: Padding(
                  padding: EdgeInsets.all(17),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Solicitar Guincho",
                        style:
                            TextStyle(fontFamily: "Brand Bold", fontSize: 18),
                      ),
                      Image.asset(
                        "assets/images/tow-truck.png",
                        height: 30,
                        width: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo[300],
                  elevation: 3,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8)),
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: onPress,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
