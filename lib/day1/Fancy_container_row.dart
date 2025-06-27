import 'package:flutter/material.dart';

class FancyContainerRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 50,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,

                style: BorderStyle.solid,
              ),
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Icon(Icons.snowing),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,

                style: BorderStyle.solid,
              ),
              shape: BoxShape.circle,
              color: Colors.purple,
            ),
            child: Icon(Icons.snowing),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,

                style: BorderStyle.solid,
              ),
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Icon(Icons.snowing),
          ),
        ],
      ),
    );
  }
}
