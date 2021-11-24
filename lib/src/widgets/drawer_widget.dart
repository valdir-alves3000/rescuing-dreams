import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rescuing_dreams/src/widgets/list_tile_widget.dart';

class DrawerWidget extends StatelessWidget {
  late final Function() closeDrawer;

  DrawerWidget({required this.closeDrawer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      color: Colors.white,
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
          ListTileWidget(head: 'My account', icon: Icons.person, onTap: () {}),
          ListTileWidget(head: 'Settings', icon: Icons.settings, onTap: () {}),
          ListTileWidget(head: 'Help', icon: Icons.help, onTap: () {}),
          ListTileWidget(head: 'Suport', icon: Icons.forum, onTap: () {}),
          ListTileWidget(head: 'Sair', icon: Icons.close, onTap: closeDrawer),
        ],
      ),
    );
  }
}
