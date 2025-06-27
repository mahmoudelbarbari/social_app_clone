import 'package:flutter/material.dart';

class TravelWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full screen background image
          Positioned.fill(
            child: Image.network(
              'https://dnm.nflximg.net/api/v6/2DuQlx0fM4wd1nzqm5BFBi6ILa8/AAAAQU_urEWnoojHROfowF6_3wtE4QXYWLo3Hnd3ABsjnwGqYKGdsEabiqhoyvC5s2WPmNvhwIrCexG9KGrytxovVdPqMA-NMDFaEDX3dW_cGdFwwMWmbDY39sgVEvc6UDSPWYQPLLSp1IsDKWiuSuyG-WNc.jpg?r=31b',
              fit: BoxFit.cover,
            ),
          ),

          // Dark overlay for readability (optional)
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          // Centered welcome message
          Center(
            child: Text(
              'Welcome to TravelGo!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Positioned "Get Started" button at the bottom
          Positioned(
            bottom: 50,
            left: 40,
            right: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.pinkAccent,
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Add navigation or action here
              },
              child: Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}
