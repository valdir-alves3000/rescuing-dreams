import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  late final String head;
  late final IconData icon;
  late final Function() onTap;

  ListTileWidget({
    required this.head,
    required this.icon,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 37.0, top: 26.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 25,
              ),
              SizedBox(width: 22),
              Text(
                head,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
