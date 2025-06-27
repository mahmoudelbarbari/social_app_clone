import 'package:flutter/material.dart';

class ImageGalleryPage extends StatelessWidget {
  final List<String> imageUrls = List.generate(
    20,
    (index) => "https://picsum.photos/seed/image$index/300/200",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Gallery")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.extent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: imageUrls.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(url, fit: BoxFit.cover),
            );
          }).toList(),
        ),
      ),
    );
  }
}
