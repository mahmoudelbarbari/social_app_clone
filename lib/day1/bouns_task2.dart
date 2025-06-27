import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          SectionTitle("Row Example"),
          RowExample(),
          Divider(),
          SectionTitle("Column Example"),
          ColumnExample(),
          Divider(),
          SectionTitle("Text Example"),
          TextExample1(),
          Divider(),
          SectionTitle("Icon Exmplae"),
          IconExample(),
          Divider(),
          SectionTitle("Elevated Button"),
          ElevatedButtonExample(),
          Divider(),
          SectionTitle("Outlined Button"),
          OutlinedButtonExample(),
          Divider(),
          SectionTitle("Container Design"),
          ContainerExample(),
          Divider(),
          SectionTitle("Checkbox & Radio"),
          CheckboxRatioBtnExample(),
          Divider(),
          SectionTitle("Alert Dialog"),
          DialogExample(),
          Divider(),
          SectionTitle("Buttom Sheet"),
          DialogModalExample(),
          Divider(),
          SectionTitle("Scroll View Test"),
          SingleChildScrollViewExample(),
        ],
      ),
    );
  }
}

class RowExample extends StatelessWidget {
  const RowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(width: 40, height: 40, color: Colors.yellow),
        Container(width: 40, height: 40, color: Colors.green),
        Container(width: 40, height: 40, color: Colors.red),
      ],
    );
  }
}

class ColumnExample extends StatelessWidget {
  const ColumnExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("First", style: TextStyle(backgroundColor: Colors.yellow)),
        Text("Second", style: TextStyle(backgroundColor: Colors.green)),
        Text("Third", style: TextStyle(backgroundColor: Colors.red)),
      ],
    );
  }
}

class TextExample1 extends StatelessWidget {
  const TextExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello Flutter!",
      style: TextStyle(
        fontSize: 30,
        color: Colors.blue,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,
        decorationColor: Colors.black,
        decorationStyle: TextDecorationStyle.solid,
      ),
    );
  }
}

class IconExample extends StatelessWidget {
  const IconExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.heart_broken, color: Colors.red, size: 50),
        Icon(Icons.star, color: Colors.yellow, size: 50),
        Icon(Icons.home, color: Colors.blue, size: 50),
      ],
    );
  }
}

class ElevatedButtonExample extends StatelessWidget {
  const ElevatedButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10)),
      child: Text("Elevated Click"),
    );
  }
}

class OutlinedButtonExample extends StatelessWidget {
  const OutlinedButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(padding: EdgeInsets.all(10)),
      child: Text("Outlined Click"),
    );
  }
}

class ContainerExample extends StatelessWidget {
  const ContainerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: Colors.blue),
          SizedBox(width: 10),
          Text("This is a styled container"),
        ],
      ),
    );
  }
}

class CheckboxRatioBtnExample extends StatelessWidget {
  const CheckboxRatioBtnExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: true, onChanged: (value) {}),
        Text("Agree"),
        SizedBox(width: 20),
        Radio(value: true, groupValue: true, onChanged: (value) {}),
        Text("Select"),
      ],
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("TV"),
              content: Text("Are you sure u want 2 buy this TV ?"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("yes"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("no"),
                ),
              ],
            );
          },
        );
      },
      child: Text("Show Alert Dialog"),
    );
  }
}

class DialogModalExample extends StatelessWidget {
  const DialogModalExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Option",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Share"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Delete"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Text("Show Bottom Sheet"),
    );
  }
}

class SingleChildScrollViewExample extends StatelessWidget {
  const SingleChildScrollViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.red,
            child: Center(child: Text("Box 1")),
          ),
          SizedBox(width: 10),
          Container(
            width: 80,
            height: 80,
            color: Colors.pink,
            child: Center(child: Text("Box 2")),
          ),
          SizedBox(width: 10),
          Container(
            width: 80,
            height: 80,
            color: Colors.purple,
            child: Center(child: Text("Box 3")),
          ),
          SizedBox(width: 10),
          Container(
            width: 80,
            height: 80,
            color: Colors.purple[900],
            child: Center(child: Text("Box 4")),
          ),
          SizedBox(width: 10),
          Container(
            width: 80,
            height: 80,
            color: Colors.purple[700],
            child: Center(child: Text("Box 5")),
          ),
          SizedBox(width: 10),
          Container(
            width: 80,
            height: 80,
            color: Colors.blue[900],
            child: Center(child: Text("Box 6")),
          ),
          SizedBox(width: 10),
          Container(
            width: 80,
            height: 80,
            color: Colors.lightBlue,
            child: Center(child: Text("Box 7")),
          ),
        ],
      ),
    );
  }
}
