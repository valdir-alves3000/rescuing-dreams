import 'package:flutter/material.dart';
import 'package:rescuing_dreams/src/widgets/list_tile_widget.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      color: Colors.red,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Valdir Alves',
              style: TextStyle(fontSize: 16, fontFamily: 'Brand Bold'),
            ),
            accountEmail: Text('valdir@alves.com'),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Image(
                image: NetworkImage(
                    'https://avatars.githubusercontent.com/u/51173956?s=48&v=4'),
                    fit: BoxFit.cover,
              ),
              
            ),
          ),
          ListTileWidget('My account', Icons.person),          
          ListTileWidget('Settings', Icons.settings),          
          ListTileWidget('Help', Icons.help),          
          ListTileWidget('Suport', Icons.forum),       
          
        ],
      ),
    );
  }
}
