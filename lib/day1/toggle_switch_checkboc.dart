import 'package:flutter/material.dart';

class ToggleSwitchCheckbox extends StatefulWidget {
  const ToggleSwitchCheckbox({super.key});

  @override
  State<ToggleSwitchCheckbox> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ToggleSwitchCheckbox> {
  bool isSwitched = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: isSwitched,

          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
        ),
        Text("Switch is ${isSwitched ? "On" : "Off"}"),
        SizedBox(width: 10),
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text("Checked"),
      ],
    );
  }
}
