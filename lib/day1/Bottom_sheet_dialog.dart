import 'package:flutter/material.dart';

class BottomSheetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showBottomSheet(
          context: context,

          builder: (BuildContext context) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(leading: Icon(Icons.save), title: Text("Save")),
                  ListTile(
                    leading: Icon(Icons.download),
                    title: Text("Download"),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu),
          SizedBox(width: 8),
          Text("Show Bottom Sheet"),
        ],
      ),
    );
  }
}
