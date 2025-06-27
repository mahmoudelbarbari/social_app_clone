import 'package:flutter/material.dart';

class ScrollableCard extends StatelessWidget {
  const ScrollableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(
      20,
      (index) => "Item ${index + 1}",
    );
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),

        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.circle), Text(items[index])],
            ),
          );
        },
      ),
    );
  }
}


