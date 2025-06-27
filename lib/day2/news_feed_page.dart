import 'package:flutter/material.dart';

class NewsFeedPage extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      "title": "Flutter 3.0 Released",
      "desc": "The latest version of Flutter brings powerful UI improvements.",
      "image": "https://i.ibb.co/mrr7HkhT/3.jpg",
    },
    {
      "title": "AI Trends 2025",
      "desc": "What to expect in the world of artificial intelligence.",
      "image": "https://i.ibb.co/Fb55dzRZ/7.jpg",
    },
    {
      "title": "Travel on a Budget",
      "desc": "Explore the world without breaking the bank.",
      "image": "https://i.ibb.co/60HnvFcS/1.jpg",
    },
    {
      "title": "Healthy Living Tips",
      "desc": "Easy habits for a happier and healthier you.",
      "image": "https://i.ibb.co/mrr7HkhT/3.jpg",
    },
    {
      "title": "Top Programming Languages",
      "desc": "The most popular languages in 2025 revealed.",
      "image": "https://i.ibb.co/fd8v0nDQ/6.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Feed")),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: articles.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final article = articles[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    article["image"]!,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Text(
                    article["title"]!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 12,
                  ),
                  child: Text(
                    article["desc"]!,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
