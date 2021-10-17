import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  late final String hintText;
  late final IconData iconData;
  late final Color color;
  late bool enabled;
  late final void Function(String) onChanged;
  late final Function() onTap;
  final TextEditingController textEditingInputController;

  InputWidget({
    required this.hintText,
    required this.iconData,
    required this.color,
    required this.enabled,
    required this.onChanged,
    required this.onTap,
    required this.textEditingInputController,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(this.iconData, size: 19, color: color),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 1.4,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                controller: textEditingInputController,
                onChanged: onChanged,
                enabled: enabled,
                decoration: InputDecoration.collapsed(
                    hintText: hintText,
                    hintStyle: TextStyle(fontFamily: 'Brand Bold')),
              )),
        ),
      ],
    );
  }
}
