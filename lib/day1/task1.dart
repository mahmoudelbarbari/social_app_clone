import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomizableContainer(
            Colors.green,
            TextRow(
              "This is a Container with an icon and Text!",
              Icons.star,
              Colors.yellow,
              TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          CustomizableContainer(
            Colors.lightBlueAccent,
            Column(
              children: [
                TextRow(
                  "Frist item with info icon",
                  Icons.info,
                  Colors.blue,
                  TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 10),
                TextRow(
                  "Second item with check_circle_icon",
                  Icons.check_circle,
                  Colors.green,
                  TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                TextRow(
                  "Third item with warning icon",
                  Icons.warning,
                  Colors.yellow,
                  TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomizableContainer(
                Colors.pink,
                Column(
                  children: [
                    Icon(Icons.home, color: Colors.white),
                    Text("Home", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(width: 10),
              CustomizableContainer(
                Colors.blue,
                Column(
                  children: [
                    Icon(Icons.settings, color: Colors.white),
                    Text("Settings", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(width: 10),
              CustomizableContainer(
                Colors.green,
                Column(
                  children: [
                    Icon(Icons.notifications, color: Colors.white),
                    Text(
                      "Notifications",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomizableContainer extends StatelessWidget {
  final Color backgrounColor;
  final Widget widget;
  const CustomizableContainer(this.backgrounColor, this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: backgrounColor,
      child: widget,
    );
  }
}

class TextRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final TextStyle? textStyle;
  const TextRow(this.title, this.icon, this.color, this.textStyle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 10),
        Text(title, style: textStyle),
      ],
    );
  }
}

class CustomizableListTile extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const CustomizableListTile({this.title, this.subTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.alarm, color: Colors.blue),
      title: Text(title ?? ""),
      subtitle: Text(subTitle ?? ""),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {},
    );
  }
}
