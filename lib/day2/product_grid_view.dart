import 'package:flutter/material.dart';

class ProductGridPage extends StatelessWidget {
  // Sample product data
  final List<Map<String, String>> products = [
    {"name": "dd", "image": "assets/images/dd.png"},
    {"name": "dd", "image": "assets/images/dd.png"},
    {"name": "dd", "image": "assets/images/dd.png"},
    {"name": "dd", "image": "assets/images/dd.png"},
    {"name": "dd", "image": "assets/images/dd.png"},
    {"name": "dd", "image": "assets/images/dd.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Grid")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.asset(
                        product["image"]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      product["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "You clicked Buy Now for ${product['name']}",
                            ),
                          ),
                        );
                      },
                      child: Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
