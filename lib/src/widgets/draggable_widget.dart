import 'package:flutter/material.dart';
import 'package:rescuing_dreams/src/widgets/list_tile_widget.dart';
import 'package:rescuing_dreams/src/widgets/search_button.widget.dart';

class DraggableWidget extends StatelessWidget {
  late final Function() onTap;
  DraggableWidget(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, -1),
            blurRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            width: 35,
            color: Colors.grey[300],
            height: 3.5,
          ),
          GestureDetector(
            onTap: onTap,
            child: SearchButtonWidget(),
          ),
          ListTileWidget(
            head: 'Enter home location',
            icon: Icons.home,
            onTap: () {},
          ),
          ListTileWidget(
            head: 'Enter work location',
            icon: Icons.work,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
