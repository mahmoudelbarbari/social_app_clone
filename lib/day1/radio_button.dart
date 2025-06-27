import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({super.key});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  int value = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 1; i <= 3; i++)
          Expanded(
            child: Column(
              children: [
                Radio(
                  value: i,
                  groupValue: value,
                  onChanged: (v) {
                    setState(() {
                      value = v!;
                    });
                  },
                ),
                Text("Option $i"),
              ],
            ),
          ),
      ],
    );
  }
}
