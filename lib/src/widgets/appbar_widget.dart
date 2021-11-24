import 'package:flutter/material.dart';
import 'package:rescuing_dreams/src/widgets/input_widget.dart';

class AppBarWidget extends StatelessWidget {
  Function() onPress;
  void Function(String) onChanged;
  Function() onTap;
  TextEditingController destinationController;
  TextEditingController originController;
  String originText;
  AppBarWidget({
    required this.onPress,
    required this.onChanged,
    required this.onTap,
    required this.originController,
    required this.destinationController,
    required this.originText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Entre com o destino',
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontFamily: 'Brand Bold',
        ),
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.close),
      ),
      bottom: PreferredSize(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.5),
          child: Column(
            children: [
              InputWidget(
                hintText: originText,
                iconData: Icons.gps_fixed,
                color: Colors.green,
                enabled: false,
                onTap: onTap,
                onChanged: onChanged,
                textEditingInputController: originController,
              ),
              SizedBox(height: 9),
              Row(
                children: [
                  InputWidget(
                    hintText: 'Ingressar destino',
                    iconData: Icons.place_sharp,
                    color: Colors.indigo,
                    enabled: true,
                    onTap: onTap,
                    onChanged: onChanged,
                    textEditingInputController: destinationController,
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(80.0),
      ),
    );
  }
}
