import 'package:flutter/material.dart';

class ProfileCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Card")),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 80),
                  ListTile(
                    title: Text(
                      "Time To HVFun",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("HVFun"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: () {}, child: Text("Follow")),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text("Message"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  "https://i.ytimg.com/vi/QMu99s-WF0A/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAzKekxhutpVUySPhgyTgW4AM_o_A",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
